<?php

namespace App\Transformers\Admin;

use App\Models\ExamSchedule;
use League\Fractal\TransformerAbstract;

class ExamScheduleTransformer extends TransformerAbstract
{
    public function transform(ExamSchedule $examSchedule)
    {
        return [
            'id' => $examSchedule->id,
            'code' => $examSchedule->code,
            'exam' => $examSchedule->exam->title,
            'type' => ucfirst($examSchedule->schedule_type),
            'starts_at' => $examSchedule->starts_at->toDayDateTimeString(),
            'ends_at' => $examSchedule->ends_at->toDayDateTimeString(),
            'status' => ucfirst($examSchedule->status),
        ];
    }
}

