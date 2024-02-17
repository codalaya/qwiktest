<?php


namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class UpdateQuizRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     *
     * @return bool
     */
    public function authorize()
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array
     */
    public function rules()
    {
        return [
            'title' => ['required'],
            'description' => ['nullable'],
            'sub_category_id' => ['required'],
            'quiz_type_id' => ['required'],
            'is_paid' => ['required'],
            'can_redeem' => ['required'],
            'points_required' => ['required_if:can_redeem,true'],
            'is_private' => ['required'],
            'is_active' => ['required']
        ];
    }
}
