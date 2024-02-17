<?php


namespace App\Transformers\Admin;

use App\Models\Section;
use League\Fractal\TransformerAbstract;

class SectionTransformer extends TransformerAbstract
{
    public function transform(Section $section)
    {
        return [
            'id' => $section->id,
            'name' => $section->name,
            'code' => $section->code,
            'icon_path' => $section->icon_path,
            'status' => $section->is_active,
        ];
    }
}

