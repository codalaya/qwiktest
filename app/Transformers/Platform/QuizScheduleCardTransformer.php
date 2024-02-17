<?php


namespace App\Transformers\Platform;

use App\Models\QuizSchedule;
use League\Fractal\TransformerAbstract;

class QuizScheduleCardTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param QuizSchedule $schedule
     * @return array
     */
    public function transform(QuizSchedule $schedule)
    {
        return [
            'code' => $schedule->code,
            'scheduleType' => ucfirst($schedule->schedule_type),
            'starts_at' => $schedule->starts_at_formatted,
            'ends_at' => $schedule->ends_at_formatted,
            'timezone' => $schedule->timezone,
            'title' => $schedule->quiz->title,
            'slug' => $schedule->quiz->slug,
            'total_questions' => $schedule->quiz->total_questions,
            'total_marks' => $schedule->quiz->total_marks,
            'total_duration' => $schedule->quiz->total_duration/60,
            'category' => $schedule->quiz->subCategory->name,
            'type' => $schedule->quiz->quizType->name,
            'paid' => $schedule->quiz->is_paid,
            'redeem' => $schedule->quiz->can_redeem ? $schedule->quiz->points_required.' XP' : false,
        ];
    }
}
