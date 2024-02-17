<?php


namespace App\Transformers\Platform;

use App\Models\ExamSchedule;
use League\Fractal\TransformerAbstract;

class ExamScheduleCalendarTransformer extends TransformerAbstract
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
            'key' => $schedule->code,
            'highlight' => $schedule->schedule_type == 'fixed' ?  ['color' => 'blue', 'fillMode' => 'light'] : ['color' => 'green', 'fillMode' => 'light'],
            'dot' => $schedule->schedule_type == 'fixed' ?  'blue' : 'green',
            'dates' => $schedule->schedule_type == 'fixed' ?  $schedule->starts_at : ['start' => $schedule->starts_at, 'end' => $schedule->ends_at],
            'popover' => [
                'visibility' => 'focus'
            ],
            'customData' => [
                'code' => $schedule->code,
                'entity' => 'exam',
                'slug' => $schedule->exam->slug,
                'title' => $schedule->exam->title,
                'type' => ucfirst($schedule->schedule_type)
            ]
        ];
    }
}
