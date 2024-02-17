<?php

namespace App\Http\Controllers\Admin;

use App\Filters\PaymentFilters;
use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\UpdatePaymentRequest;
use App\Models\Payment;
use App\Repositories\CheckoutRepository;
use App\Repositories\PaymentRepository;
use App\Settings\PaymentSettings;
use App\Transformers\Admin\PaymentDetailsTransformer;
use App\Transformers\Admin\PaymentTransformer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use Inertia\Inertia;

class PaymentCrudController extends Controller
{
    /**
     * @var PaymentSettings
     */
    private PaymentSettings $paymentSettings;
    /**
     * @var CheckoutRepository
     */
    private CheckoutRepository $checkoutRepository;
    /**
     * @var PaymentRepository
     */
    private PaymentRepository $paymentRepository;

    public function __construct(PaymentSettings $paymentSettings, CheckoutRepository $checkoutRepository)
    {
        $this->middleware(['role:admin']);
        $this->paymentSettings = $paymentSettings;
        $this->checkoutRepository = $checkoutRepository;
    }

    /**
     * List all payments
     *
     * @param PaymentFilters $filters
     * @return \Inertia\Response
     */
    public function index(PaymentFilters $filters)
    {
        $paymentProcessors = [];

        foreach (config('qwiktest.payment_processors') as $key => $value) {
            if($this->paymentSettings->toArray()['enable_'.$key]) {
                array_push($paymentProcessors, [
                    'value' => $key,
                    'text' => $value['name'],
                ]);
            }
        }

        return Inertia::render('Admin/Payments', [
            'payments' => function () use($filters) {
                return fractal(Payment::with(['plan', 'user'])->latest()->filter($filters)
                    ->paginate(request()->perPage != null ? request()->perPage : 10),
                    new PaymentTransformer())->toArray();
            },
            'paymentProcessors' => $paymentProcessors,
            'paymentStatuses' => [
                ['value' => 'pending', 'text' => 'Pending'],
                ['value' => 'success', 'text' => 'Success'],
                ['value' => 'failed', 'text' => 'Failed'],
                ['value' => 'cancelled', 'text' => 'Cancelled']
            ]
        ]);
    }

    /**
     * Show an payment
     *
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function show($id)
    {
        $payment = Payment::find($id);
        return response()->json([
            'payment' => fractal($payment, new PaymentDetailsTransformer())->toArray()['data'],
        ]);
    }

    /**
     * Edit an payment
     *
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function edit($id)
    {
        $payment = Payment::find($id);
        return response()->json([
            'payment' => $payment,
        ]);
    }

    /**
     * Update an subscription
     *
     * @param UpdatePaymentRequest $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(UpdatePaymentRequest $request, $id)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! Payments can\'t be changed.');
        }

        $payment = Payment::find($id);
        $payment->update($request->validated());

        return redirect()->back()->with('successMessage', 'Payments was successfully updated!');
    }

    /**
     * Delete an payment
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy($id)
    {
        if(config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! Payments can\'t be deleted.');
        }

        try {
            $payment = Payment::find($id);

            if(!$payment->canSecureDelete('subscription')) {
                return redirect()->back()->with('errorMessage', 'Unable to Delete Payment! Subscription Exist.');
            }

            $payment->secureDelete('subscription');
        }
        catch (\Illuminate\Database\QueryException $e){
            return redirect()->back()->with('errorMessage', 'Unable to Delete Payment . Something went wrong!');
        }
        return redirect()->back()->with('successMessage', 'Payment was successfully deleted!');
    }

    /**
     * Approve/Reject bank payment
     *
     * @param Request $request
     * @param $id
     * @param PaymentRepository $paymentRepository
     * @return \Illuminate\Http\RedirectResponse
     */
    public function authorizeBankPayment(Request $request, $id, PaymentRepository $paymentRepository)
    {
        Validator::make($request->all(), [
            'status' => ['required'],
        ])->validateWithBag('updateBankPayment');

        $payment = Payment::with(['plan', 'subscription'])->findOrFail($id);

        // Check if the subscription exists for the payment
        if($payment->subscription) {
            return redirect()->back()->with('errorMessage', 'Subscription exists for the payment.');
        }

        $payment->status = $request->status == 'approved' ? 'success' : 'cancelled';
        $payment->update();

        // if payment approved create a subscription
        try {
            if($request->status == 'approved' && $payment->status == 'success') {
                $subscription = $paymentRepository->createSubscription([
                    'payment_id' => $payment->id,
                    'plan_id' => $payment->plan_id,
                    'user_id' => $payment->user_id,
                    'category_type' => $payment->plan->category_type,
                    'category_id' => $payment->plan->category_id,
                    'duration' => $payment->plan->duration,
                    'status' => 'active'
                ]);

                // if subscription not created change payment status to pending
                if(!$subscription) {
                    $payment->status = 'pending';
                    $payment->update();
                    return redirect()->back()->with('errorMessage', 'Something went wrong. Please try again later.');
                }
            }
        } catch (\Exception $e) {
            $payment->status = 'pending';
            $payment->update();
            return redirect()->back()->with('errorMessage', 'Something went wrong. Please try again later.');
        }

        return redirect()->back()->with('successMessage', 'Payment was successfully updated!');
    }
}
