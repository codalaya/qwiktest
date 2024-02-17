<?php


namespace App\Transformers\Admin;

use App\Models\Question;
use League\Fractal\TransformerAbstract;

class QuestionTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param Question $question
     * @return array
     */
    public function transform(Question $question)
    {
        return [
            'id' => $question->id,
            'code' => $question->code,
            'question' => formatQuestionProperty($question->question, $question->questionType->code),
            'questionType' => $question->questionType->name,
            'section' => $question->section->name,
            'skill' => $question->skill->name,
            'topic' => $question->topic ? $question->topic->name : '--',
            'status' => $question->is_active ? 'Active' : 'In-active',
        ];
    }
}
