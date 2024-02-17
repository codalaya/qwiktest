<?php


namespace App\Transformers\Admin;

use App\Models\QuizType;
use League\Fractal\TransformerAbstract;

class QuizTypeTransformer extends TransformerAbstract
{
    public function transform(QuizType $quizType)
    {
        return [
            'id' => $quizType->id,
            'name' => $quizType->name,
            'code' => $quizType->code,
            'status' => $quizType->is_active,
        ];
    }
}

