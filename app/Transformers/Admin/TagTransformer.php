<?php

namespace App\Transformers\Admin;

use App\Models\Tag;
use League\Fractal\TransformerAbstract;

class TagTransformer extends TransformerAbstract
{
    public function transform(Tag $tag)
    {
        return [
            'id' => $tag->id,
            'name' => $tag->name,
            'status' => $tag->is_active ? 'Active' : 'In-active',
        ];
    }
}
