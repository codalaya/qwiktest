<?php


namespace App\Transformers\Admin;

use App\Models\Skill;
use League\Fractal\TransformerAbstract;

class SkillTransformer extends TransformerAbstract
{
    public function transform(Skill $skill)
    {
        return [
            'id' => $skill->id,
            'name' => $skill->name,
            'code' => $skill->code,
            'section' => $skill->section->name,
            'status' => $skill->is_active,
        ];
    }
}
