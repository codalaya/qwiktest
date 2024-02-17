<?php


namespace App\Transformers\Platform;

use App\Models\PracticeSet;
use League\Fractal\TransformerAbstract;

class PracticeSetCardTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param PracticeSet $practiceSet
     * @return array
     */
    public function transform(PracticeSet $practiceSet)
    {
        return [
            'id' => $practiceSet->id,
            'title' => $practiceSet->title,
            'slug' => $practiceSet->slug,
            'total_questions' => $practiceSet->total_questions,
            'skill' => $practiceSet->skill->name,
            'paid' => $practiceSet->is_paid,
        ];
    }
}
