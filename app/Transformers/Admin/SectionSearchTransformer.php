<?php


namespace App\Transformers\Admin;

use App\Models\Section;
use League\Fractal\TransformerAbstract;

class SectionSearchTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param Section $section
     * @return array
     */
    public function transform(Section $section)
    {
        return [
            'id' => $section->id,
            'name' => $section->name
        ];
    }
}
