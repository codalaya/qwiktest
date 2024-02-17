<?php


namespace App\Transformers\Platform;

use App\Models\Exam;
use League\Fractal\TransformerAbstract;

class ExamDetailTransformer extends TransformerAbstract
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
            'description' => $exam->description !== null ? $exam->description : __('No Description'),
            'paid' => $exam->is_paid,
            'redeem' => $exam->can_redeem ? $exam->points_required.' XP' : false,
            'total_questions' => $exam->total_questions,
            'total_marks' => $exam->total_marks,
            'total_duration' => $exam->total_duration/60,
            'category' => $exam->subCategory->name,
            'type' => $exam->examType->name,
            'sections' => $exam->examSections,
            'uncompleted_sessions' => $exam->sessions_count,
            'section_lock' => $exam->settings->get('disable_section_navigation', false)
        ];
    }
}
