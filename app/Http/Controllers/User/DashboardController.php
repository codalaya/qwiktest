<?php


namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\ExamSchedule;
use App\Models\PracticeSession;
use App\Models\QuizSchedule;
use App\Models\SubCategory;
use App\Settings\LocalizationSettings;
use App\Transformers\Platform\ExamScheduleCalendarTransformer;
use App\Transformers\Platform\PracticeSessionCardTransformer;
use App\Transformers\Platform\QuizScheduleCalendarTransformer;
use Carbon\Carbon;
use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\Cookie;
use Inertia\Inertia;

class DashboardController extends Controller
{
    private LocalizationSettings $localizationSettings;

    public function __construct(LocalizationSettings $localizationSettings)
    {
        $this->middleware(['role:guest|student|employee', 'verify.syllabus']);
        $this->localizationSettings = $localizationSettings;
    }

    /**
     * User's Main Dashboard
     *
     * @return \Inertia\Response
     */
    public function index()
    {
        $userGroups = auth()->user()->userGroups()->pluck('id');
        $minDate = Carbon::today()->timezone($this->localizationSettings->default_timezone);
        $maxDate = Carbon::today()->addMonths(1)->endOfMonth()->timezone($this->localizationSettings->default_timezone);
        $subCategory = SubCategory::find(Cookie::get('category_id'));

        // Fetch quizzes scheduled for current user via user groups
        $quizSchedules = QuizSchedule::whereHas('userGroups', function (Builder $query) use ($userGroups) {
            $query->whereIn('user_group_id', $userGroups);
        })->whereHas('quiz', function (Builder $query) use ($subCategory) {
            $query->where('sub_category_id', $subCategory->id);
        })->with('quiz')->orderBy('end_date', 'asc')->active()->limit(4)->get();

        // Fetch exams scheduled for current user via user groups
        $examSchedules = ExamSchedule::whereHas('userGroups', function (Builder $query) use ($userGroups) {
            $query->whereIn('user_group_id', $userGroups);
        })->whereHas('exam', function (Builder $query) use ($subCategory) {
            $query->where('sub_category_id', $subCategory->id);
        })->with('exam')->orderBy('end_date', 'asc')->active()->limit(4)->get();

        // Fetch current user in-completed practice sessions
        $practiceSessions = PracticeSession::with(['practiceSet' => function($query) {
            $query->with('skill:id,name');
        }])->whereHas('practiceSet', function (Builder $query) use ($subCategory) {
            $query->where('sub_category_id', $subCategory->id);
        })->where('user_id', auth()->user()->id)->pending()
            ->orderBy('updated_at', 'desc')->limit(1)->get();

        return Inertia::render('User/Dashboard', [
            'scheduleCalendar' => array_merge(fractal($quizSchedules, new QuizScheduleCalendarTransformer())->toArray()['data'],
                fractal($examSchedules, new ExamScheduleCalendarTransformer())->toArray()['data']),
            'practiceSessions' => fractal($practiceSessions, new PracticeSessionCardTransformer())->toArray()['data'],
            'minDate' => $minDate,
            'maxDate' => $maxDate,
        ]);
    }
}
