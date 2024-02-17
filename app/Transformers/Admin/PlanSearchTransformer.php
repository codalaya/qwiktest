<?php


namespace App\Transformers\Admin;

use App\Models\Plan;
use League\Fractal\TransformerAbstract;

class PlanSearchTransformer extends TransformerAbstract
{
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
            'name' => $plan->full_name
        ];
    }
}
