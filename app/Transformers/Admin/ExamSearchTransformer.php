<?php


namespace App\Transformers\Admin;

use App\Models\Exam;
use League\Fractal\TransformerAbstract;

class ExamSearchTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param Exam $exam
     * @return array
     */
    public function transform(Exam $exam)
    {
        return [
            'id' => $exam->id,
            'title' => $exam->title
        ];
    }
}
