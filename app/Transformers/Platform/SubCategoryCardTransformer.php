<?php


namespace App\Transformers\Platform;

use App\Models\SubCategory;
use League\Fractal\TransformerAbstract;

class SubCategoryCardTransformer extends TransformerAbstract
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
            'name' => $subCategory->name,
            'code' => $subCategory->code,
            'slug' => $subCategory->slug,
            'category' => $subCategory->category->name,
            'type' => $subCategory->subCategoryType->name,
            'image_path' => $subCategory->image_path,
            'short_description' => $subCategory->short_description,
            'description' => $subCategory->description,
            'status' => $subCategory->is_active,
            'sections' => $subCategory->sections ? $subCategory->sections : []
        ];
    }
}
