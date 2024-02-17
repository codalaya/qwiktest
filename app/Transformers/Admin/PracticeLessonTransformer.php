<?php

namespace App\Transformers\Admin;

use App\Models\Lesson;
use Illuminate\Support\Str;
use League\Fractal\TransformerAbstract;

class PracticeLessonTransformer extends TransformerAbstract
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
            'duration' => $lesson->duration,
            'skill' => $lesson->skill->name,
            'difficulty' => $lesson->difficultyLevel->name,
            'excerpt' => Str::limit(strip_tags($lesson->body), 100),
            'disabled' => false
        ];
    }
}
