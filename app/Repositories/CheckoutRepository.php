<?php


namespace App\Repositories;

use App\Settings\PaymentSettings;
use App\Settings\TaxSettings;
use Illuminate\Support\Str;

class CheckoutRepository
{
    /**
     * @var PaymentSettings
     */
    private PaymentSettings $paymentSettings;
    /**
     * @var TaxSettings
     */
    private TaxSettings $taxSettings;

    public function __construct(PaymentSettings $paymentSettings, TaxSettings $taxSettings)
    {
        $this->paymentSettings = $paymentSettings;
        $this->taxSettings = $taxSettings;
    }

    /**
     * Calculate order price, discounts, taxes etc.
     *
     * @param $plan
     * @return array
     */
    public function orderSummary($plan)
    {
        $items = [];
        $taxes = [];
        $subTotal = 0;
        $total = 0;

        // Add items and calculate total (for now one plan only)
        $plural = Str::plural('Time', $plan->duration);

        array_push($items, [
            'name' => "{$plan->category->name} {$plan->name} - {$plan->duration} {$plural} Game Plan",
            'amount' => $plan->has_discount ? $plan->total_discounted_price : $plan->total_price,
            'amount_formatted' => $plan->has_discount ? $plan->formatted_total_discounted_price : $plan->formatted_total_price,
            'discount' => $plan->has_discount ? $plan->discount_percentage . '%' : null,
            'original_price' => $plan->formatted_total_price,
        ]);

        // Calculate Total Price
        foreach ($items as $item) {
            $subTotal += $item['amount'];
            $total += $item['amount'];
        }

        // calculate tax amount
        if ($this->taxSettings->enable_tax) {
            if ($this->taxSettings->tax_amount_type == 'percentage') {
                $amount = ($subTotal * $this->taxSettings->tax_amount) / 100;
                $name = $this->taxSettings->tax_name . ' ' . $this->taxSettings->tax_amount . '%';
            } else {
                $amount = $this->taxSettings->tax_amount;
                $name = $this->taxSettings->tax_name;
            }
            array_push($taxes, [
                'name' => $name,
                'type' => $this->taxSettings->tax_type,
                'amount' => $amount,
                'amount_formatted' => formatPrice($amount, $this->paymentSettings->currency_symbol, $this->paymentSettings->currency_symbol_position)
            ]);
        }

        // calculate additional tax amount
        if ($this->taxSettings->enable_additional_tax) {
            if ($this->taxSettings->additional_tax_amount_type == 'percentage') {
                $amount = ($subTotal * $this->taxSettings->additional_tax_amount) / 100;
                $name = $this->taxSettings->additional_tax_name . ' ' . $this->taxSettings->additional_tax_amount . '%';
            } else {
                $amount = $this->taxSettings->additional_tax_amount;
                $name = $this->taxSettings->additional_tax_name;
            }
            array_push($taxes, [
                'name' => $name,
                'type' => $this->taxSettings->additional_tax_type,
                'amount' => $amount,
                'amount_formatted' => formatPrice($amount, $this->paymentSettings->currency_symbol, $this->paymentSettings->currency_symbol_position)
            ]);
        }

        // adjust taxes to total price
        foreach ($taxes as $tax) {
            $total += $tax['type'] == 'exclusive' ? $tax['amount'] : 0;
        }

        return [
            'items' => $items,
            'taxes' => $taxes,
            'sub_total' => $subTotal,
            'total' => $total,
            'sub_total_formatted' => formatPrice($subTotal, $this->paymentSettings->currency_symbol, $this->paymentSettings->currency_symbol_position),
            'total_formatted' => formatPrice($total, $this->paymentSettings->currency_symbol, $this->paymentSettings->currency_symbol_position)
        ];
    }

    /**
     * Get active payment processors
     *
     * @return array
     */
    public function getPaymentProcessors()
    {
        $paymentProcessors = [];

        foreach (config('qwiktest.payment_processors') as $key => $value) {
            if ($this->paymentSettings->toArray()['enable_' . $key]) {
                array_push($paymentProcessors, [
                    'code' => $key,
                    'name' => $value['name'],
                    'description' => $value['description'],
                    'default' => $this->paymentSettings->default_payment_processor == $key
                ]);
            }
        }

        return $paymentProcessors;
    }
}
