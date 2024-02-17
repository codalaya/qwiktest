<?php


namespace App\Transformers\Admin;

use App\Models\Plan;
use App\Settings\PaymentSettings;
use League\Fractal\TransformerAbstract;

class PlanTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param Plan $plan
     * @return array
     */
    public function transform(Plan $plan)
    {
        $paymentSettings = app(PaymentSettings::class);
        return [
            'id' => $plan->id,
            'name' => $plan->name,
            'category' => $plan->category->name,
            'price' => formatPrice($plan->price, $paymentSettings->currency_symbol, $paymentSettings->currency_symbol_position),
            'code' => $plan->code,
            'duration' => $plan->duration.' '.__('Months'),
            'status' => $plan->is_active,
        ];
    }
}
