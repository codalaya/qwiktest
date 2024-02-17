<?php

namespace App\Transformers\Admin;

use App\Models\ExamType;
use League\Fractal\TransformerAbstract;

class ExamTypeTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param ExamType $examType
     * @return array
     */
    public function transform(ExamType $examType)
    {
        return [
            'id' => $examType->id,
            'name' => $examType->name,
            'code' => $examType->code,
            'status' => $examType->is_active,
        ];
    }
}
