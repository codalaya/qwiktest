<?php

namespace App\Transformers\Platform;

use League\Fractal\TransformerAbstract;

class TopScorerTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param $scorer
     * @return array
     */
    public function transform($scorer)
    {
        return [
            'id' => $scorer->user_id,
            'name' => "{$scorer->user->first_name} {$scorer->user->last_name}",
            'high_score' => round($scorer->high_score, 2)
        ];
    }
}
