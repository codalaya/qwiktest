<?php


namespace App\Transformers\Admin;

use App\Models\Quiz;
use League\Fractal\TransformerAbstract;

class QuizSearchTransformer extends TransformerAbstract
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
            'id' => $quiz->id,
            'title' => $quiz->title
        ];
    }
}
