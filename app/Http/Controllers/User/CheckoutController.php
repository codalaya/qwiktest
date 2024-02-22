<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Http\Requests\Platform\CheckoutProcessRequest;
use App\Models\Payment;
use App\Models\Plan;
use App\Repositories\CheckoutRepository;
use App\Repositories\PaymentRepository;
use App\Repositories\RazorpayRepository;
use App\Settings\BankSettings;
use App\Settings\PaymentSettings;
use App\Settings\RazorpaySettings;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class CheckoutController extends Controller
{
    /**
     * @var CheckoutRepository
     */
    private CheckoutRepository $repository;
    /**
     * @var PaymentRepository
     */
    private PaymentRepository $paymentRepository;
    /**
     * @var PaymentSettings
     */
    private PaymentSettings $paymentSettings;

    public function __construct(CheckoutRepository $repository, PaymentRepository $paymentRepository, PaymentSettings $paymentSettings)
    {
        $this->middleware(['role:guest|student|employee']);
        $this->repository = $repository;
        $this->paymentRepository = $paymentRepository;
        $this->paymentSettings = $paymentSettings;
    }

    /**
     * Plan checkout page
     *
     * @param Request $request
     * @param $plan
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View
     * @throws \Exception
     */
    public function checkout(Request $request, $plan)
    {
        $plan = Plan::with('category:id,name')->where('code', '=', $plan)->firstOrFail();

        return view('store.checkout.index', [
            'plan' => $plan->code,
            'billing_information' => $request->user()->preferences->get('billing_information', []),
            'payment_id' => 'payment_' . Str::random(16),
            'order' => $this->repository->orderSummary($plan),
            'paymentProcessors' => $this->repository->getPaymentProcessors(),
            'countries' => isoCountries(),
            'bankSettings' => app(BankSettings::class),
        ]);
    }

    /**
     * Process checkout and redirect to review & pay page
     *
     * @param CheckoutProcessRequest $request
     * @param $plan
     * @return string
     */
    public function processCheckout(CheckoutProcessRequest $request, $plan)
    {
        if (config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! These settings can\'t be changed.');
        }

        $plan = Plan::with('category:id,name')->where('code', '=', $plan)->firstOrFail();

        // check the user has active subscription to the current plan
        $activeSubscriptions = auth()->user()->subscriptions()
            ->where('category_id', '=', $plan->category_id)
            ->where('ends_at', '>', now()->toDateTimeString())
            ->where('status', '=', 'active')
            ->count();

        if ($activeSubscriptions > 0) {
            return redirect()->back()->with('errorMessage', 'You already had an active subscription to ' . $plan->category->name . '.');
        }

        // Check the user has pending bank payment
        if ($request->user()->hasPendingBankPayment($plan->id)) {
            return redirect()->back()->with('errorMessage', __('A pending bank payment request already exists for this plan.'));
        }

        $orderSummary = $this->repository->orderSummary($plan);

        // Update user billing information
        $request->user()->preferences = [
            'billing_information' => [
                'full_name' => $request->full_name,
                'email' => $request->email,
                'phone' => $request->phone,
                'address' => $request->address,
                'city' => $request->city,
                'state' => $request->state,
                'country' => $request->country,
                'zip' => $request->zip,
            ]
        ];
        $request->user()->update();

        if ($request->payment_method == 'bank') {
            return $this->handleBankPayment($request->payment_id, $plan->id, $orderSummary);
        } elseif ($request->payment_method == 'razorpay') {
            return $this->initRazorpayPayment($request->payment_id, $plan->id, $orderSummary);
        } else {
            return redirect()->back();
        }
    }

    /**
     * Initiate Razorpay Payment
     *
     * @param $paymentId
     * @param $planId
     * @param $orderSummary
     * @return string
     */
    public function initRazorpayPayment($paymentId, $planId, $orderSummary)
    {
        $repository = app(RazorpayRepository::class);
        $order = null;

        // Create payment record and razorpay order
        try {
            $order = $repository->createOrder($paymentId, $orderSummary['total'] * 100);
            $payment = $this->paymentRepository->createPayment([
                'payment_id' => $paymentId,
                'currency' => $this->paymentSettings->default_currency,
                'plan_id' => $planId,
                'user_id' => request()->user()->id,
                'payment_date' => Carbon::now()->toDateTimeString(),
                'payment_processor' => 'razorpay',
                'reference_id' => $order['id'],
                'total_amount' => $orderSummary['total'],
                'billing_information' => request()->user()->preferences->billing_information,
                'status' => 'pending',
                'order_summary' => $orderSummary
            ]);
            if (!$payment) {
                return redirect()->back()->with('successMessage', 'Something went wrong. Please try again.');
            }
        } catch (\Exception $e) {
            Log::channel('daily')->error($e->getMessage());
            return redirect()->route('payment_failed');
        }

        return view('store.checkout.razorpay', [
            'order_id' => $order['id'],
            'order_currency' => $order['currency'],
            'order_total' => $order['amount'],
            'razorpay_key' => app(RazorpaySettings::class)->key_id,
            'billing_information' => request()->user()->preferences->get('billing_information', []),
            'order' => $orderSummary,
        ]);
    }

    /**
     * Handle Razorpay Payment
     *
     * @param Request $request
     * @param RazorpayRepository $repository
     * @return \Illuminate\Http\RedirectResponse
     */
    public function handleRazorpayPayment(Request $request, RazorpayRepository $repository)
    {
        $validator = Validator::make($request->all(), [
            'razorpay_signature' => 'required',
            'razorpay_payment_id' => 'required',
            'razorpay_order_id' => 'required',
        ]);

        if ($validator->fails()) {
            return redirect()->route('payment_failed');
        }

        try {
            $verified = $repository->verifyPayment([
                'razorpay_signature' => $request->get('razorpay_signature'),
                'razorpay_payment_id' => $request->get('razorpay_payment_id'),
                'razorpay_order_id' => $request->get('razorpay_order_id')
            ]);
            if ($verified) {
                $payment = Payment::with(['plan', 'subscription'])->where('reference_id', '=', $request->get('razorpay_order_id'))->first();

                // check if payment has been process previously
                if ($payment->status == 'success' || $payment->status == 'failed'  || $payment->status == 'cancelled') {
                    return redirect()->back()->with('errorMessage', 'Payment already completed or cancelled.');
                }

                //else update payment status and razorpay data
                $payment->transaction_id = $request->get('razorpay_payment_id');
                $payment->data->set([
                    'razorpay' => $validator->validated()
                ]);
                $payment->payment_date = Carbon::now()->toDateTimeString();
                $payment->status = 'success';
                $payment->update();

                $plan = $payment->plan;

                // create if subscription not exists for the payment
                if (!$payment->subscription) {
                    $subscription = $this->paymentRepository->createSubscription([
                        'payment_id' => $payment->id,
                        'plan_id' => $payment->plan_id,
                        'user_id' => $payment->user_id,
                        'category_type' => $payment->plan->category_type,
                        'category_id' => $payment->plan->category_id,
                        'duration' => $payment->plan->duration,
                        'status' => 'active',
                        'remained_game_play' => $plan->duration,
                    ]);
                }

                return redirect()->route('payment_success');
            } else {
                return redirect()->route('payment_failed');
            }
        } catch (\Exception $e) {
            Log::channel('daily')->error($e->getMessage());
            return redirect()->route('payment_failed');
        }
    }

    /**
     * Handle Bank Payment
     *
     * @param $paymentId
     * @param $planId
     * @param $orderSummary
     * @return \Illuminate\Http\RedirectResponse
     */
    public function handleBankPayment($paymentId, $planId, $orderSummary)
    {
        try {
            $payment = $this->paymentRepository->createPayment([
                'payment_id' => $paymentId,
                'currency' => $this->paymentSettings->default_currency,
                'plan_id' => $planId,
                'user_id' => request()->user()->id,
                'payment_date' => Carbon::now()->toDateTimeString(),
                'payment_processor' => 'bank',
                'total_amount' => $orderSummary['total'],
                'billing_information' => request()->user()->preferences->billing_information,
                'status' => 'pending',
                'order_summary' => $orderSummary
            ]);
            if (!$payment) {
                return redirect()->route('payment_failed');
            }
        } catch (\Exception $e) {
            Log::channel('daily')->error($e->getMessage());
            redirect()->back()->with('errorMessage', 'Something went wrong');
        }
        return redirect()->route('payment_pending');
    }

    public function paymentSuccess()
    {
        return view('store.checkout.payment_success');
    }

    public function paymentPending()
    {
        return view('store.checkout.payment_pending');
    }

    public function paymentCancelled()
    {
        return view('store.checkout.payment_cancelled');
    }

    public function paymentFailed()
    {
        return view('store.checkout.payment_failed');
    }
}
