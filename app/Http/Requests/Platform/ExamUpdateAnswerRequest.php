<?php


namespace App\Http\Requests\Platform;

use Illuminate\Foundation\Http\FormRequest;

class ExamUpdateAnswerRequest extends FormRequest
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
            'user_answer' => ['nullable'],
            'time_taken' => ['required', 'numeric'],
            'status' => ['required', 'string']
        ];
    }
}
