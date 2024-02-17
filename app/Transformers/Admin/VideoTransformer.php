<?php

namespace App\Transformers\Admin;

use App\Models\Video;
use League\Fractal\TransformerAbstract;

class VideoTransformer extends TransformerAbstract
{
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
            'type' => $video->video_type_name,
            'section' => $video->section->name,
            'skill' => $video->skill->name,
            'topic' => $video->topic ? $video->topic->name : '--',
            'duration' => $video->duration.' Min',
            'is_paid' => $video->is_paid ? 'Paid': 'Free',
            'status' => $video->is_active ? 'Active' : 'In-active',
        ];
    }
}
