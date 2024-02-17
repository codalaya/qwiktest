<?php


namespace App\Transformers\Admin;

use App\Models\QuizSchedule;
use League\Fractal\TransformerAbstract;

class QuizScheduleTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param QuizSchedule $quizSchedule
     * @return array
     */
    public function transform(QuizSchedule $quizSchedule)
    {
        return [
            'id' => $quizSchedule->id,
            'code' => $quizSchedule->code,
            'quiz' => $quizSchedule->quiz->title,
            'type' => ucfirst($quizSchedule->schedule_type),
            'starts_at' => $quizSchedule->starts_at->toDayDateTimeString(),
            'ends_at' => $quizSchedule->ends_at->toDayDateTimeString(),
            'status' => ucfirst($quizSchedule->status),
        ];
    }
}
