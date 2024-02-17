<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\Section;
use App\Models\SubCategory;
use App\Settings\LocalizationSettings;
use App\Transformers\Platform\SubCategoryCardTransformer;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Cookie;
use Inertia\Inertia;

class PracticeDashboardController extends Controller
{
    private LocalizationSettings $localizationSettings;

    public function __construct(LocalizationSettings $localizationSettings)
    {
        $this->middleware(['role:guest|student|employee', 'verify.syllabus']);
        $this->localizationSettings = $localizationSettings;
    }

    /**
     * User's Learn & Practice Screen
     *
     * @return \Inertia\Response
     */
    public function learn()
    {
        return Inertia::render('User/LearnPractice', [
            'category' => fractal(SubCategory::with(['sections:id,name,code,slug', 'subCategoryType:id,name', 'category:id,name'])
                ->orderBy('name')->find(Cookie::get('category_id')), new SubCategoryCardTransformer())
                ->toArray()['data']
        ]);
    }

    /**
     * Section's Learn & Practice Screen
     *
     * @param SubCategory $category
     * @param $section
     * @return \Inertia\Response
     */
    public function learnSection(SubCategory $category, $section)
    {
        $catId = $category->id;
        $section = Section::with(['skills' => function($query) use ($catId) {
            $query->withCount(['practiceSets' => function (Builder $builder) use ($catId) {
                $builder->where('is_active', '=', 1)->where('sub_category_id', '=', $catId);
            }, 'practiceLessons' => function (Builder $builder) use ($catId) {
                $builder->where('sub_category_id', '=', $catId);
            }, 'practiceVideos' => function (Builder $builder) use ($catId) {
                $builder->where('sub_category_id', '=', $catId);
            }]);
        }])->where('slug', $section)
            ->firstOrFail();

        return Inertia::render('User/LearnPracticeSection', [
            'category' => $category,
            'section' => $section
        ]);
    }
}
