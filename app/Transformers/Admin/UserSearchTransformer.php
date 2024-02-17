<?php


namespace App\Transformers\Admin;

use App\Models\User;
use League\Fractal\TransformerAbstract;

class UserSearchTransformer extends TransformerAbstract
{
    /**
     * A Fractal transformer.
     *
     * @param User $user
     * @return array
     */
    public function transform(User $user)
    {
        return [
            'id' => $user->id,
            'name' => "{$user->first_name} {$user->last_name}"
        ];
    }
}
