<?php

namespace App\Http\Controllers;

use App\Models\Payment;
use App\Models\Plan;
use App\Repositories\CheckoutRepository;
use App\Repositories\PaymentRepository;
use App\Repositories\RazorpayRepository;
use App\Settings\PaymentSettings;
use App\Settings\RazorpaySettings;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Str;

class AddMoneyController extends Controller
{
    public function showPage(Request $request)
    {
        return inertia('User/AddMoney');
    }


    public function generateOrder(Request $request)
    {
        $plan = Plan::where('price', 0)->latest()->first();
        $plan->setAttribute('price', $request->amount);
        $paymentId = 'payment_0_' . Str::random(16);
        $orderSummary = resolve(CheckoutRepository::class)->orderSummary($plan);
        $orderSummary['paying_amount'] = $request->amount;
        $billingInfo = auth()->user()->only(['full_name', 'user_name', 'email', 'phone']);

        return $this->initRazorpayPayment($paymentId, $plan->id, $orderSummary, $billingInfo);
    }

    public function addMoneyCallback(Request $request,  RazorpayRepository $repository)
    {
        info($request->all());

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
                    return ['errorMessage', 'Payment already completed or cancelled.'];
                }

                //else update payment status and razorpay data
                $payment->transaction_id = $request->get('razorpay_payment_id');
                $payment->data->set([
                    'razorpay' => $validator->validated()
                ]);
                $payment->payment_date = Carbon::now()->toDateTimeString();
                $payment->status = 'success';
                $payment->total_amount = $payment->data->order_summary['paying_amount'];
                $payment->update();

                $amount = $payment->data->order_summary['paying_amount'];
                $payment->user->deposit($amount);

                return redirect()->route('payment_success');
            } else {
                return redirect()->route('payment_failed');
            }
        } catch (\Exception $e) {
            Log::channel('daily')->error($e->getMessage());
            return redirect()->route('payment_failed');
        }
    }

    protected function initRazorpayPayment($paymentId, $planId, $orderSummary, $billingInfo)
    {
        $repository = resolve(RazorpayRepository::class);
        $paymentRepo = resolve(PaymentRepository::class);
        $paymentSetting = resolve(PaymentSettings::class);
        $order = null;

        // Create payment record and razorpay order
        try {
            $order = $repository->createOrder($paymentId, $orderSummary['paying_amount'] * 100);
            $payment = $paymentRepo->createPayment([
                'payment_id' => $paymentId,
                'currency' => $paymentSetting->default_currency,
                'plan_id' => $planId,
                'user_id' => request()->user()->id,
                'payment_date' => Carbon::now()->toDateTimeString(),
                'payment_processor' => 'razorpay',
                'reference_id' => $order['id'],
                'total_amount' => $orderSummary['total'],
                'billing_information' => $billingInfo,
                'status' => 'pending',
                'order_summary' => $orderSummary
            ]);
            if (!$payment) {
                return response()->json(['message' => 'payment not completed.']);
            }
        } catch (\Exception $e) {
            Log::channel('daily')->error($e->getMessage());
            return redirect()->route('payment_failed');
        }

        return  [
            'order_id' => $order['id'],
            'order_currency' => $order['currency'],
            'order_total' => $order['amount'],
            'razorpay_key' => app(RazorpaySettings::class)->key_id,
            'billing_information' =>  $billingInfo,
            'order' => $orderSummary,
        ];
    }
}
