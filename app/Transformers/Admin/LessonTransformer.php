<?php

namespace App\Transformers\Admin;

use App\Models\Lesson;
use League\Fractal\TransformerAbstract;

class LessonTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param Lesson $lesson
     * @return array
     */
    public function transform(Lesson $lesson)
    {
        return [
            'id' => $lesson->id,
            'code' => $lesson->code,
            'title' => $lesson->title,
            'section' => $lesson->section->name,
            'skill' => $lesson->skill->name,
            'topic' => $lesson->topic ? $lesson->topic->name : '--',
            'duration' => $lesson->duration.' Min',
            'is_paid' => $lesson->is_paid ? 'Paid': 'Free',
            'status' => $lesson->is_active ? 'Active' : 'In-active',
        ];
    }
}
