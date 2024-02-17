<?php

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class UpdateLessonRequest extends FormRequest
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
            'title' => ['required', 'max:250'],
            'body' => ['required'],
            'skill_id' => ['required'],
            'topic_id' => ['nullable'],
            'difficulty_level_id' => ['required'],
            'duration' => ['required'],
            'is_paid' => ['required'],
            'is_active' => ['required'],
        ];
    }
}
