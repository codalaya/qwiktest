<?php

namespace App\Transformers\Admin;

use App\Models\Exam;
use League\Fractal\TransformerAbstract;

class ExamTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param Exam $exam
     * @return array
     */
    public function transform(Exam $exam)
    {
        return [
            'id' => $exam->id,
            'code' => $exam->code,
            'title' => $exam->title,
            'examType' => $exam->examType->name,
            'category' => $exam->subCategory->name,
            'sections' => $exam->exam_sections_count > 0 ? $exam->exam_sections_count.' Sections' : 'No Sections',
            'visibility' => $exam->is_private ? 'Private' : 'Public',
            'status' => $exam->is_active ? 'Published' : 'Draft',
        ];
    }
}
