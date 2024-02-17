<?php

namespace App\Transformers\Platform;

use App\Models\ExamSection;
use League\Fractal\TransformerAbstract;

class ExamResultSectionTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param ExamSection $section
     * @return array
     */
    public function transform(ExamSection $section)
    {
        return [
            'id' => $section->id,
            'sno' => $section->pivot->sno,
            'name' => $section->pivot->name,
            'section_id' => $section->pivot->section_id,
            'total_questions' => $section->total_questions,
            'results' => json_decode($section->pivot->results, true),
        ];
    }
}
