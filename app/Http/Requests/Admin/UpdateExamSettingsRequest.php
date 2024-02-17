<?php

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class UpdateExamSettingsRequest extends FormRequest
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
            'restrict_attempts' => ['required'],
            'no_of_attempts' => ['required_if:restrict_attempts,true'],
            'disable_question_navigation' => ['required'],
            'disable_section_navigation' => ['required'],
            'list_questions' => ['required'],
            "auto_duration" => ['required'],
            "auto_grading" => ['required'],
            "enable_negative_marking" => ['required'],
            "enable_section_cutoff" => ['required'],
            'cutoff' => ['required'],
            'disable_finish_button' => ['required'],
            'hide_solutions' => ['required'],
            'shuffle_questions' => ['required']
        ];
    }
}
