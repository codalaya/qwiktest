<?php

namespace App\Http\Controllers\User;

use App\Filters\LessonFilters;
use App\Http\Controllers\Controller;
use App\Models\Section;
use App\Models\Skill;
use App\Models\SubCategory;
use App\Transformers\User\PracticeVideoTransformer;
use Illuminate\Http\Request;
use Inertia\Inertia;

class PracticeVideoController extends Controller
{
    private int $perPage = 10;

    /**
     * Skill Videos Page
     *
     * @param SubCategory $category
     * @param Section $section
     * @param $skill
     * @return \Inertia\Response
     */
    public function skillVideos(SubCategory $category, Section $section, $skill)
    {
        $skill = Skill::where('slug', $skill)->firstOrFail();
        return Inertia::render('User/PracticeVideos', [
            'category' => $category,
            'section' => $section,
            'skill' => $skill,
            'subscription' => request()->user()->hasActiveSubscription($category->id, 'videos')
        ]);
    }

    /**
     * Fetch videos of a skill
     *
     * @param Request $request
     * @param SubCategory $category
     * @param Section $section
     * @param $skill
     * @param LessonFilters $filters
     * @return \Illuminate\Http\JsonResponse
     */
    public function fetchPracticeVideos(Request $request, SubCategory $category, Section $section, $skill, LessonFilters $filters)
    {
        $skill = Skill::where('slug', $skill)->firstOrFail();
        $subscription = request()->user()->hasActiveSubscription($category->id, 'videos');

        $lessons = fractal($skill->practiceVideos()->filter($filters)->where('sub_category_id', $category->id)
            ->orderBy('videos.is_paid', 'asc')
            ->paginate($this->perPage), new PracticeVideoTransformer($subscription))
            ->toArray();

        return response()->json([
            'videos' => $lessons['data'],
            'pagination' => $lessons['meta']['pagination'],
        ], 200);
    }

    /**
     * Go to Video watch mode
     *
     * @param Request $request
     * @param SubCategory $category
     * @param Section $section
     * @param $skill
     * @return \Inertia\Response
     */
    public function watchVideos(Request $request, SubCategory $category, Section $section, $skill)
    {
        $skill = Skill::where('slug', $skill)->firstOrFail();
        $subscription = request()->user()->hasActiveSubscription($category->id, 'videos');
        $currentItem = 1;

        if($request->has('start')) {
            $currentItem = (int) $request->get('start') + 1;
        }

        $index = ceil($currentItem%$this->perPage);

        return Inertia::render('User/VideoScreen', [
            'category' => $category,
            'section' => $section,
            'skill' => $skill,
            'currentPage' => ceil($currentItem/$this->perPage),
            'videoIndex' => $index == 0 ? 0 : $index-1,
            'subscription' => $subscription
        ]);
    }
}
