<?php


namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class StorePracticeSetRequest extends FormRequest
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
            'title' => ['required', 'max:160'],
            'description' => ['nullable'],
            'sub_category_id' => ['required'],
            'skill_id' => ['required'],
            'is_active' => ['required'],
            'is_paid' => ['required'],
        ];
    }
}
