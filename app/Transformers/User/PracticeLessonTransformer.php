<?php

namespace App\Transformers\User;

use App\Models\Lesson;
use League\Fractal\TransformerAbstract;

class PracticeLessonTransformer extends TransformerAbstract
{
    private bool $body;
    private bool $subscription;

    public function __construct(bool $body = false, bool $subscription = false)
    {
        $this->body = $body;
        $this->subscription = $subscription;
    }

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
            'body' => $this->getBody($lesson),
            'read_time' => $lesson->duration,
            'paid' => $lesson->is_paid,
            'sort_order' => $lesson->pivot->sort_order
        ];
    }

    public function getBody($lesson)
    {
        if($lesson->is_paid && $this->body) {
            return $this->subscription ? $lesson->body : '';
        } else {
            return $this->body ? $lesson->body : '';
        }
    }
}
