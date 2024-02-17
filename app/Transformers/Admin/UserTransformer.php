<?php


namespace App\Transformers\Admin;

use League\Fractal\TransformerAbstract;
use App\Models\User;

class UserTransformer extends TransformerAbstract
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
            'fullName' => $user->first_name.' '.$user->last_name,
            'firstName' => $user->first_name,
            'lastName' => $user->last_name,
            'userName' => $user->user_name,
            'email' => $user->email,
            'role' => implode(",", $user->getRoleNames()->toArray()),
            'status' => $user->is_active,
        ];
    }
}
