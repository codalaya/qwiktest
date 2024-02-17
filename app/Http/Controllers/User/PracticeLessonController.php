<?php

namespace App\Http\Controllers\User;

use App\Filters\LessonFilters;
use App\Http\Controllers\Controller;
use App\Models\Section;
use App\Models\Skill;
use App\Models\SubCategory;
use App\Transformers\User\PracticeLessonTransformer;
use Illuminate\Http\Request;
use Inertia\Inertia;

class PracticeLessonController extends Controller
{
    private int $perPage = 10;

    /**
     * Skill Lessons Page
     *
     * @param SubCategory $category
     * @param Section $section
     * @param $skill
     * @return \Inertia\Response
     */
    public function skillLessons(SubCategory $category, Section $section, $skill)
    {
        $skill = Skill::where('slug', $skill)->firstOrFail();
        return Inertia::render('User/PracticeLessons', [
            'category' => $category,
            'section' => $section,
            'skill' => $skill,
            'subscription' => request()->user()->hasActiveSubscription($category->id, 'lessons')
        ]);
    }

    /**
     * Fetch lessons of a skill
     *
     * @param Request $request
     * @param SubCategory $category
     * @param Section $section
     * @param $skill
     * @param LessonFilters $filters
     * @return \Illuminate\Http\JsonResponse
     */
    public function fetchPracticeLessons(Request $request, SubCategory $category, Section $section, $skill, LessonFilters $filters)
    {
        $skill = Skill::where('slug', $skill)->firstOrFail();
        $subscription = request()->user()->hasActiveSubscription($category->id, 'lessons');

        $body = $request->has('withBody');

        $lessons = fractal($skill->practiceLessons()->filter($filters)->where('sub_category_id', $category->id)
            ->orderBy('lessons.is_paid', 'asc')
            ->paginate($this->perPage), new PracticeLessonTransformer($body, $subscription))
            ->toArray();

        return response()->json([
            'lessons' => $lessons['data'],
            'pagination' => $lessons['meta']['pagination'],
        ], 200);
    }

    /**
     * Go to Lesson read mode
     *
     * @param Request $request
     * @param SubCategory $category
     * @param Section $section
     * @param $skill
     * @return \Inertia\Response
     */
    public function readLessons(Request $request, SubCategory $category, Section $section, $skill)
    {
        $skill = Skill::where('slug', $skill)->firstOrFail();
        $subscription = request()->user()->hasActiveSubscription($category->id, 'lessons');
        $currentItem = 1;

        if($request->has('start')) {
            $currentItem = (int) $request->get('start') + 1;
        }

        $index = ceil($currentItem%$this->perPage);

        return Inertia::render('User/LessonScreen', [
            'category' => $category,
            'section' => $section,
            'skill' => $skill,
            'currentPage' => ceil($currentItem/$this->perPage),
            'lessonIndex' => $index == 0 ? 0 : $index-1,
            'subscription' => $subscription
        ]);
    }
}
