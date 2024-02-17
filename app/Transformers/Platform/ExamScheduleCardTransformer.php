<?php


namespace App\Transformers\Platform;

use App\Models\ExamSchedule;
use League\Fractal\TransformerAbstract;

class ExamScheduleCardTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param ExamSchedule $schedule
     * @return array
     */
    public function transform(ExamSchedule $schedule)
    {
        return [
            'code' => $schedule->code,
            'scheduleType' => ucfirst($schedule->schedule_type),
            'starts_at' => $schedule->starts_at_formatted,
            'ends_at' => $schedule->ends_at_formatted,
            'timezone' => $schedule->timezone,
            'title' => $schedule->exam->title,
            'slug' => $schedule->exam->slug,
            'total_questions' => $schedule->exam->total_questions,
            'total_marks' => $schedule->exam->total_marks,
            'total_duration' => $schedule->exam->total_duration/60,
            'category' => $schedule->exam->subCategory->name,
            'type' => $schedule->exam->examType->name,
            'paid' => $schedule->exam->is_paid,
            'redeem' => $schedule->exam->can_redeem ? $schedule->exam->points_required.' XP' : false,
        ];
    }
}
