<?php


namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class StoreSectionRequest extends FormRequest
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
            'name' => ['required', 'max:255'],
            'short_description' => ['nullable', 'max:255'],
            'icon_path' => ['nullable', 'max:255'],
            'is_active' => ['required'],
        ];
    }
}
