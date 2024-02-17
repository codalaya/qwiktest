<?php

namespace App\Transformers\Admin;

use App\Models\Video;
use Illuminate\Support\Str;
use League\Fractal\TransformerAbstract;

class PracticeVideoTransformer extends TransformerAbstract
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
            'duration' => $video->duration,
            'skill' => $video->skill->name,
            'difficulty' => $video->difficultyLevel->name,
            'disabled' => false
        ];
    }
}
