<?php


namespace App\Transformers\Platform;

use App\Models\Quiz;
use League\Fractal\TransformerAbstract;

class QuizCardTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param Quiz $quiz
     * @return array
     */
    public function transform(Quiz $quiz)
    {
        return [
            'code' => $quiz->code,
            'title' => $quiz->title,
            'slug' => $quiz->slug,
            'total_questions' => $quiz->total_questions,
            'total_marks' => $quiz->total_marks,
            'total_duration' => $quiz->total_duration/60,
            'category' => $quiz->subCategory->name,
            'type' => $quiz->quizType->name,
            'paid' => $quiz->is_paid,
            'redeem' => $quiz->can_redeem ? $quiz->points_required.' XP' : false,
        ];
    }
}
