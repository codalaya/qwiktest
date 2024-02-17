<?php


namespace App\Repositories;

use App\Settings\PaymentSettings;
use App\Settings\StripeSettings;
use Stripe\Checkout\Session;
use Stripe\Exception\ApiErrorException;
use Stripe\Stripe;

class StripeRepository
{
    /**
     * @var StripeSettings
     */
    private StripeSettings $settings;

    public function __construct(StripeSettings $settings)
    {
        $this->settings = $settings;
        Stripe::setApiKey($settings->secret_key);
    }

    /**
     * @param $paymentId
     * @param $amount
     * @return Session
     * @throws ApiErrorException
     */
    public function createSession($paymentId, $amount)
    {
        return Session::create([
            'line_items' => [[
                'price_data' => [
                    'currency' => app(PaymentSettings::class)->default_currency,
                    'product_data' => [
                        'name' => $paymentId,
                    ],
                    'unit_amount' => $amount,
                ],
                'quantity' => 1,
            ]],
            'mode' => 'payment',
            'success_url' => route('stripe_callback'),
            'cancel_url' => route('payment_cancelled'),
        ]);
    }
}
