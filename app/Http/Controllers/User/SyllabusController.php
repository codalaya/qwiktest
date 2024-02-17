<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\SubCategory;
use App\Transformers\Platform\SubCategoryCardTransformer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Cookie;
use Inertia\Inertia;

class SyllabusController extends Controller
{
    public function changeSyllabus()
    {
        return Inertia::render('User/ChangeSyllabus', [
            'categories' => fractal(SubCategory::active()->has('sections')
                ->with(['sections:id,name,code,slug', 'subCategoryType:id,name', 'category:id,name'])
                ->orderBy('name')->get(), new SubCategoryCardTransformer())
                ->toArray()['data']
        ]);
    }

    public function updateSyllabus(Request $request)
    {
        $category = SubCategory::where('code', $request->category)->firstOrFail();

        Cookie::queue('category_id', $category->id, 60*24*7);
        Cookie::queue('category_name', $category->name, 60*24*7);

        return redirect()->route('user_dashboard')->with('successMessage', 'Syllabus updated to '.$category->name);
    }
}
