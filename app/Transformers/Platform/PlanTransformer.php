<?php

namespace App\Transformers\Platform;

use App\Models\Plan;
use League\Fractal\TransformerAbstract;

class PlanTransformer extends TransformerAbstract
{
    private $allFeatures;

    public function __construct($allFeatures)
    {
        $this->allFeatures = $allFeatures;
    }

    /**
     * A Fractal transformer.
     *
     * @param Plan $plan
     * @return array
     */
    public function transform(Plan $plan)
    {
        return [
            'id' => $plan->id,
            'name' => $plan->name,
            'code' => $plan->code,
            'duration' => $plan->duration,
            'price' => $plan->formatted_price,
            'has_discount' => $plan->has_discount,
            'discount_percentage' => $plan->discount_percentage.'%',
            'discounted_price' => $plan->formatted_discounted_price,
            'total_price' => $plan->has_discount ? $plan->formatted_total_discounted_price : $plan->formatted_total_price,
            'description' => $plan->description,
            'popular' => $plan->is_popular,
            'features' => fractal($this->allFeatures, new PlanFeatureTransformer($plan->features))->toArray()['data']
        ];
    }
}
