<?php


namespace App\Transformers\Admin;

use App\Models\Topic;
use League\Fractal\TransformerAbstract;

class TopicTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param Topic $topic
     * @return array
     */
    public function transform(Topic $topic)
    {
        return [
            'id' => $topic->id,
            'code' => $topic->code,
            'name' => $topic->name,
            'skill' => $topic->skill->name,
            'status' => $topic->is_active,
        ];
    }
}
