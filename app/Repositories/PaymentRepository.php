<?php


namespace App\Repositories;

use App\Models\Payment;
use App\Models\Subscription;
use App\Settings\BillingSettings;
use Carbon\Carbon;
use Illuminate\Support\Str;

class PaymentRepository
{
    /**
     * Store Payment
     *
     * @param $data
     * @return Payment
     */
    public function createPayment($data)
    {
        $billingSettings = app(BillingSettings::class);

        $payment = new Payment();
        $payment->payment_id = $data['payment_id'];
        $payment->currency = $data['currency'];
        $payment->plan_id = $data['plan_id'];
        $payment->user_id = $data['user_id'];
        $payment->total_amount = $data['total_amount'];
        $payment->payment_date = $data['payment_date'];
        $payment->payment_processor = $data['payment_processor'];
        $payment->transaction_id = $data['transaction_id'] ?? null;
        $payment->reference_id = $data['reference_id'] ?? null;
        $payment->status = $data['status'];
        $payment->data = [
            'vendor_billing_information' => $billingSettings->toArray(),
            'customer_billing_information' => $data['billing_information'],
            'order_summary' => $data['order_summary']
        ];
        $payment->save();

        $payment->invoice_id = $billingSettings->invoice_prefix.'-'.Str::padLeft($payment->id, 5, '0');
        $payment->update();

        return $payment;
    }

    public function createSubscription($data)
    {
        $subscription = new Subscription();
        $subscription->plan_id = $data['plan_id'];
        $subscription->payment_id = $data['payment_id'];
        $subscription->user_id = $data['user_id'];
        $subscription->category_type = $data['category_type'];
        $subscription->category_id = $data['category_id'];
        $subscription->starts_at = Carbon::now()->toDateTimeString();
        $subscription->ends_at = Carbon::now()->addMonths($data['duration'])->toDateTimeString();
        $subscription->status = $data['status'];
        $subscription->save();

        return $subscription;
    }
}
