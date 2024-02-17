<?php


namespace App\Http\Requests\Admin;

use Illuminate\Foundation\Http\FormRequest;

class StorePlanRequest extends FormRequest
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
            'name' => ['required', 'string', 'max:100'],
            'category_type' => ['required'],
            'category_id' => ['required'],
            'duration' => ['required'],
            'price' => ['required'],
            'has_discount' => ['required'],
            'discount_percentage' => ['required_if:has_discount,true'],
            'description' => ['nullable'],
            'sort_order' => ['required'],
            'feature_restrictions' => ['required'],
            'is_popular' => ['required'],
            'is_active' => ['required']
        ];
    }
}
