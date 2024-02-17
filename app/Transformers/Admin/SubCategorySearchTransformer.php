<?php


namespace App\Transformers\Admin;

use App\Models\SubCategory;
use League\Fractal\TransformerAbstract;

class SubCategorySearchTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param SubCategory $subCategory
     * @return array
     */
    public function transform(SubCategory $subCategory)
    {
        return [
            'id' => $subCategory->id,
            'name' => $subCategory->name.' ('.$subCategory->category->name.')'
        ];
    }
}
