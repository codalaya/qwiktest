<?php


namespace App\Transformers\Admin;

use App\Models\ComprehensionPassage;
use Illuminate\Support\Str;
use League\Fractal\TransformerAbstract;

class ComprehensionTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param ComprehensionPassage $passage
     * @return array
     */
    public function transform(ComprehensionPassage $passage)
    {
        return [
            'id' => $passage->id,
            'title' => $passage->title,
            'body' => Str::limit($passage->body, 100),
            'code' => $passage->code,
            'status' => $passage->is_active ? 'Active' : 'In-active',
        ];
    }
}
