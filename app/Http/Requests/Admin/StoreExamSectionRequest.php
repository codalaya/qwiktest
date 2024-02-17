<?php

namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class StoreExamSectionRequest extends FormRequest
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
            'name' => ['required'],
            'section_id' => ['required'],
            'section_order' => ['required'],
            'auto_duration' => ['required'],
            'total_duration' => ['required_if:auto_duration,false'],
            'auto_grading' => ['required'],
            'correct_marks' => ['required_if:auto_grading,false'],
            'enable_section_cutoff' => ['required'],
            'section_cutoff' => ['required_if:enable_section_cutoff,true'],
            'enable_negative_marking' => ['required'],
            'negative_marking_type' => ['required_if:enable_negative_marking,true'],
            'negative_marks' => ['required_if:enable_negative_marking,true']
        ];
    }
}
