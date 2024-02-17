<?php


namespace App\Transformers\Admin;

use App\Models\Skill;
use League\Fractal\TransformerAbstract;

class SkillSearchTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param Skill $skill
     * @return array
     */
    public function transform(Skill $skill)
    {
        return [
            'id' => $skill->id,
            'name' => $skill->name.' ('.$skill->section->name.')'
        ];
    }
}
