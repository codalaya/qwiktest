<?php

namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\QuizSchedule;
use App\Models\QuizType;
use App\Models\SubCategory;
use App\Models\UserGroup;
use App\Settings\LocalizationSettings;
use App\Transformers\Platform\QuizCardTransformer;
use App\Transformers\Platform\QuizScheduleCardTransformer;
use App\Transformers\Platform\QuizTypeTransformer;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Cookie;
use Inertia\Inertia;

class QuizDashboardController extends Controller
{
    private LocalizationSettings $localizationSettings;

    public function __construct(LocalizationSettings $localizationSettings)
    {
        $this->middleware(['role:guest|student|employee', 'verify.syllabus']);
        $this->localizationSettings = $localizationSettings;
    }

    /**
     * User's Quiz Dashboard
     *
     * @return \Inertia\Response
     */
    public function quiz()
    {
        $userGroups = auth()->user() ?  auth()->user()->userGroups()->pluck('id') : UserGroup::where('slug', 'general')->pluck('id');

        $category = SubCategory::find(Cookie::get('category_id'));

        // Fetch quizzes scheduled for current user via user groups
        $schedules = QuizSchedule::whereHas('userGroups', function (Builder $query) use ($userGroups) {
            $query->whereIn('user_group_id', $userGroups);
        })->whereHas('quiz', function (Builder $query) use ($category) {
            $query->where('sub_category_id', '=', $category->id);
        })->with(['quiz' => function ($builder) {
            $builder->with(['subCategory:id,name', 'quizType:id,name']);
        }])->orderBy('end_date', 'desc')->orderBy('end_time', 'desc')->active()->limit(4)->get();

        // Fetch public quizzes by quiz type
        $quizTypes = QuizType::active()->orderBy('name')->get();

        return Inertia::render('User/QuizDashboard', [
            'quizSchedules' => fractal($schedules, new QuizScheduleCardTransformer())->toArray()['data'],
            'quizTypes' => fractal($quizTypes, new QuizTypeTransformer())->toArray()['data'],
            // 'subscription' => request()->user()->hasActiveSubscription($category->id, 'quizzes')
        ]);
    }

    /**
     * Live Quizzes Screen
     *
     * @return \Inertia\Response
     */
    public function liveQuizzes()
    {
        $category = SubCategory::find(Cookie::get('category_id'));
        return Inertia::render('User/LiveQuizzes', [
            'subscription' => request()->user()->hasActiveSubscription($category->id, 'quizzes')
        ]);
    }

    /**
     * Fetch live quizzes api endpoint
     *
     * @return \Illuminate\Http\JsonResponse
     */
    public function fetchLiveQuizzes()
    {
        $userGroups = auth()->user()->userGroups()->pluck('id');
        $category = SubCategory::find(Cookie::get('category_id'));

        // Fetch quizzes scheduled for current user via user groups
        $schedules = QuizSchedule::whereHas('userGroups', function (Builder $query) use ($userGroups) {
            $query->whereIn('user_group_id', $userGroups);
        })->whereHas('quiz', function (Builder $query) use ($category) {
            $query->where('sub_category_id', '=', $category->id);
        })->with(['quiz' => function ($builder) {
            $builder->with(['subCategory:id,name', 'quizType:id,name']);
        }])->orderBy('end_date', 'asc')->active()->paginate(10);

        return response()->json([
            'schedules' => fractal($schedules, new QuizScheduleCardTransformer())->toArray()
        ], 200);
    }

    /**
     * Get Quizzes by type page
     *
     * @param QuizType $type
     * @return \Inertia\Response
     */
    public function quizzesByType(QuizType $type)
    {
        $category = SubCategory::find(Cookie::get('category_id'));
        return Inertia::render('User/QuizzesByType', [
            'type' => $type,
            'subscription' => request()->user()->hasActiveSubscription($category->id, 'quizzes')
        ]);
    }

    /**
     * Fetch quizzes by type
     *
     * @param QuizType $type
     * @return \Illuminate\Http\JsonResponse
     */
    public function fetchQuizzesByType(QuizType $type)
    {
        $subCategory = SubCategory::find(Cookie::get('category_id'));

        // Fetch public quizzes by quiz type
        $quizzes = $type->quizzes()->has('questions')
            ->where('sub_category_id', '=', $subCategory->id)
            ->orderBy('quizzes.is_paid', 'asc')
            ->with(['subCategory:id,name', 'quizType:id,name'])
            ->isPublic()->published()
            ->paginate(10);

        return response()->json([
            'quizzes' => fractal($quizzes, new QuizCardTransformer())->toArray(),
        ], 200);
    }
}
