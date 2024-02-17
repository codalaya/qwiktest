<?php



namespace App\Transformers\Platform;

use App\Models\ExamType;
use Illuminate\Support\Str;
use League\Fractal\TransformerAbstract;

class ExamTypeTransformer extends TransformerAbstract
{
    public function transform(ExamType $examType)
    {
        return [
            'slug' => $examType->slug,
            'code' => $examType->code,
            'name' => Str::plural($examType->name),
            'color' => '#'.$examType->color,
            'image' => $examType->image_path,
        ];
    }
}


