<?php

namespace App\Transformers\Platform;

use App\Models\ExamSection;
use Carbon\Carbon;
use League\Fractal\TransformerAbstract;

class ExamSessionSectionTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param ExamSection $section
     * @return array
     */
    public function transform(ExamSection $section)
    {
        $now = Carbon::now();
        return [
            'id' => $section->id,
            'sno' => $section->pivot->sno,
            'name' => $section->pivot->name,
            'section_id' => $section->pivot->section_id,
            'current_question' => $section->pivot->current_question,
            'total_questions' => $section->total_questions,
            'total_time_taken' => $section->pivot->total_time_taken,
            'status' => $section->pivot->status,
            'remainingTime' =>  $now->diffInSeconds($section->pivot->ends_at, false)
        ];
    }
}
