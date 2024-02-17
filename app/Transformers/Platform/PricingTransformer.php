<?php

namespace App\Transformers\Platform;

use App\Models\SubCategory;
use League\Fractal\TransformerAbstract;

class PricingTransformer extends TransformerAbstract
{
    private $allFeatures;

    public function __construct($allFeatures)
    {
        $this->allFeatures = $allFeatures;
    }


    /**
     * A Fractal transformer.
     *
     * @param SubCategory $category
     * @return array
     */
    public function transform(SubCategory $category)
    {
        return [
            'id' => $category->id,
            'name' => $category->name,
            'category' => $category->category->name,
            'code' => $category->code,
            'slug' => $category->slug,
            'plans' => fractal($category->plans, new PlanTransformer($this->allFeatures))->toArray()['data'],
        ];
    }
}
