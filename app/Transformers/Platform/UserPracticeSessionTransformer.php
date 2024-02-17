<?php


namespace App\Transformers\Platform;

use App\Models\PracticeSession;
use League\Fractal\TransformerAbstract;

class UserPracticeSessionTransformer extends TransformerAbstract
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
            'id' => $session->code,
            'slug' => $session->practiceSet->slug,
            'name' => $session->practiceSet->title,
            'total_points_earned' => $session->total_points_earned.' XP',
            'completed' => $session->completed_at->toFormattedDateString()
        ];
    }
}
