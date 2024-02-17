<?php


namespace App\Transformers\Platform;

use App\Models\QuizSession;
use League\Fractal\TransformerAbstract;

class QuizSessionCardTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param QuizSession $session
     * @return array
     */
    public function transform(QuizSession $session)
    {
        return [
            'code' => $session->code,
            'title' => $session->quiz->title,
            'slug' => $session->quiz->slug,
            'quizType' => $session->quiz->quizType->name,
            'quizSchedule' => $session->quizSchedule != null ? $session->quizSchedule->code : null,
        ];
    }
}
