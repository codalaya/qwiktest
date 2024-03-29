<?php


namespace App\Transformers\Platform;

use App\Models\QuizSchedule;
use League\Fractal\TransformerAbstract;

class QuizScheduleDetailTransformer extends TransformerAbstract
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
            'status' => $schedule->status
        ];
    }
}
