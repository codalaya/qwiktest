<?php

namespace App\Transformers\User;

use App\Models\Video;
use League\Fractal\TransformerAbstract;

class PracticeVideoTransformer extends TransformerAbstract
{
    private bool $subscription;

    public function __construct(bool $subscription = false)
    {
        $this->subscription = $subscription;
    }

    /**
     * A Fractal transformer.
     *
     * @param Video $video
     * @return array
     */
    public function transform(Video $video)
    {
        return [
            'id' => $video->id,
            'code' => $video->code,
            'title' => $video->title,
            'thumbnail' => $video->thumbnail,
            'type' => $video->video_type,
            'link' => $video->is_paid && !$this->subscription ? '' : $video->video_link,
            'watch_time' => $video->duration,
            'paid' => $video->is_paid,
            'sort_order' => $video->pivot->sort_order
        ];
    }
}
