<?php


namespace App\Repositories;

use App\Settings\PaymentSettings;
use App\Settings\RazorpaySettings;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;
use Razorpay\Api\Api;
use Razorpay\Api\Errors\SignatureVerificationError;

class RazorpayRepository
{

    /**
     * @var RazorpaySettings
     */
    private RazorpaySettings $settings;

    public function __construct(RazorpaySettings $settings)
    {
        $this->settings = $settings;
    }

    /**
     * Create an order on Razorpay
     *
     * @param $paymentId
     * @param $amount
     * @return \GuzzleHttp\Promise\PromiseInterface|\Illuminate\Http\Client\Response
     */
    public function createOrder($paymentId, $amount)
    {
        return Http::withBasicAuth($this->settings->key_id, $this->settings->key_secret)
            ->withHeaders(
                ['Content-Type' => 'application/json']
            )->post('https://api.razorpay.com/v1/orders', [
                'receipt' => $paymentId,
                'amount' => $amount,
                'payment_capture' => 1,
                'currency' => app(PaymentSettings::class)->default_currency
            ]);
    }

    /**
     * Verify Razorpay payment with signature
     *
     * @param $attributes
     * @return bool
     */
    public function verifyPayment($attributes)
    {
        try {
            $api = new Api($this->settings->key_id, $this->settings->key_secret);
            $api->utility->verifyPaymentSignature($attributes);
            $success = true;
        } catch (SignatureVerificationError $e) {
            $success = false;
            Log::channel('daily')->error($e->getMessage());
        }
        return $success;
    }

    /**
     * Verify Razorpay webhook signature
     *
     * @param $webhookBody
     * @param $webhookSignature
     * @return bool
     */
    public function verifyWebhook($webhookBody, $webhookSignature)
    {
        try {
            $api = new Api($this->settings->key_id, $this->settings->key_secret);
            $api->utility->verifyWebhookSignature($webhookBody, $webhookSignature, $this->settings->webhook_secret);
            $success = true;
        } catch (SignatureVerificationError $e) {
            $success = false;
            Log::channel('daily')->error($e->getMessage());
        }
        return $success;
    }
}
