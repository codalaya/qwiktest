<?php


namespace App\Transformers\Admin;

use App\Models\Topic;
use League\Fractal\TransformerAbstract;

class TopicSearchTransformer extends TransformerAbstract
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
            'name' => $topic->name.' ('.$topic->skill->name.')'
        ];
    }
}
