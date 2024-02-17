<?php


namespace App\Transformers\Admin;

use App\Models\SubCategory;
use League\Fractal\TransformerAbstract;

class SubCategoryTransformer extends TransformerAbstract
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
            'status' => $subCategory->is_active,
        ];
    }
}
