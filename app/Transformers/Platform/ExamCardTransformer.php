<?php


namespace App\Transformers\Platform;

use App\Models\Exam;
use League\Fractal\TransformerAbstract;

class ExamCardTransformer extends TransformerAbstract
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
            'code' => $exam->code,
            'title' => $exam->title,
            'slug' => $exam->slug,
            'total_questions' => $exam->total_questions,
            'total_marks' => $exam->total_marks,
            'total_duration' => $exam->total_duration/60,
            'category' => $exam->subCategory->name,
            'type' => $exam->examType->name,
            'redeem' => $exam->can_redeem ? $exam->points_required.' XP' : false,
        ];
    }
}
