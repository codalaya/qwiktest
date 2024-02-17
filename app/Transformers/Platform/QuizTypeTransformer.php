<?php


namespace App\Transformers\Platform;

use App\Models\QuizType;
use Illuminate\Support\Str;
use League\Fractal\TransformerAbstract;

class QuizTypeTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param QuizType $quizType
     * @return array
     */
    public function transform(QuizType $quizType)
    {
        return [
            'slug' => $quizType->slug,
            'code' => $quizType->code,
            'name' => Str::plural($quizType->name),
            'color' => '#'.$quizType->color,
            'image' => $quizType->image_path,
        ];
    }
}
