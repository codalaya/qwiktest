<?php


namespace App\Transformers\Platform;

use App\Models\PracticeSession;
use League\Fractal\TransformerAbstract;

class PracticeSessionCardTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param PracticeSession $session
     * @return array
     */
    public function transform(PracticeSession $session)
    {
        return [
            'code' => $session->code,
            'title' => $session->practiceSet->title,
            'slug' => $session->practiceSet->slug,
            'total_questions' => $session->practiceSet->total_questions,
            'skill' => $session->practiceSet->skill->name,
            'percentage_completed' => round($session->percentage_completed, 0)
        ];
    }
}
