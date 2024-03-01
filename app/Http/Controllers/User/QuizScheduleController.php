<?php


namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\Quiz;
use App\Models\QuizSchedule;
use App\Repositories\QuestionRepository;
use App\Repositories\UserQuizRepository;
use App\Settings\LocalizationSettings;
use App\Transformers\Platform\QuizDetailTransformer;
use App\Transformers\Platform\QuizScheduleDetailTransformer;
use Carbon\Carbon;
use Inertia\Inertia;

class QuizScheduleController extends Controller
{
    private UserQuizRepository $repository;
    private QuestionRepository $questionRepository;

    public function __construct(UserQuizRepository $repository, QuestionRepository $questionRepository)
    {
        $this->middleware(['role:guest|student|employee']);
        $this->repository = $repository;
        $this->questionRepository = $questionRepository;
    }

    /**
     * Load Quiz Schedule Instructions Page
     *
     * @param $slug
     * @param $schedule
     * @param LocalizationSettings $localization
     * @return \Inertia\Response
     */
    public function instructions($slug, $schedule, LocalizationSettings $localization)
    {
        $quizSchedule = QuizSchedule::with('userGroups:id,name')->where('code', $schedule)->firstOrFail();

        // Load quiz with unfinished sessions
        $quiz = Quiz::where('slug', $slug)
            ->published()
            ->with(['subCategory:id,name', 'quizType:id,name'])
            ->withCount(['sessions' => function ($query) use ($quizSchedule) {
                $query->where('user_id', auth()->user()->id)->where('quiz_schedule_id', $quizSchedule->id)->where('status', '=', 'started');
            }])
            ->firstOrFail();

        $scheduleUserGroups = $quizSchedule->userGroups()->pluck('id');
        $authUserGroups = auth()->user()->userGroups()->pluck('id');

        // check user exists in quiz schedule user groups
        $userHasAccess = count(array_intersect($scheduleUserGroups->toArray(), $authUserGroups->toArray())) > 0;

        // check access is open
        $allowAccess = false;
        $closesAt = '';
        $now = Carbon::now()->timezone($localization->default_timezone);

        if ($quizSchedule->schedule_type == 'fixed') {
            $grace = $quizSchedule->starts_at->addMinutes($quizSchedule->grace_period);
            $allowAccess = $now->between($quizSchedule->starts_at, $grace);
            $closesAt = $grace->toDayDateTimeString();
        }

        if ($quizSchedule->schedule_type == 'flexible') {
            $allowAccess = $now->between($quizSchedule->starts_at, $quizSchedule->ends_at);
            $closesAt = $quizSchedule->ends_at->toDayDateTimeString();
        }

        if ($quizSchedule->status == 'expired' || $quizSchedule->status == 'cancelled') {
            $allowAccess = false;
        }

        // Countdown timer
        $startsIn =  $now->diffInSeconds($quizSchedule->starts_at, false);

        return Inertia::render('User/QuizScheduleInstructions', [
            'quiz' => fractal($quiz, new QuizDetailTransformer())->toArray()['data'],
            'schedule' => fractal($quizSchedule, new QuizScheduleDetailTransformer())->toArray()['data'],
            'instructions' => $this->repository->getInstructions($quiz),
            'userHasAccess' => $userHasAccess,
            'startsIn' => $startsIn,
            'allowAccess' => $allowAccess,
            'closesAt' => $closesAt,
            'subscription' => request()->user()->hasActiveSubscription($quiz->sub_category_id, 'quizzes'),
            'errorMessage' => (auth()->user()->balance < $quiz->points_required)
                ? __('insufficient_points') . ' ' . str_replace('--', auth()->user()->balance . ' XP', __('wallet_balance_text')) . ' ' . str_replace('--', $quiz->points_required . ' XP', __('required_points_are'))
                : '',
        ]);
    }

    /**
     * Create or Load a Quiz Session of a schedule and redirect to quiz screen
     *
     * @param Quiz $quiz
     * @param $schedule
     * @param LocalizationSettings $localization
     * @return \Illuminate\Http\RedirectResponse
     */
    public function initQuizSchedule(Quiz $quiz, $schedule, LocalizationSettings $localization)
    {
        $quizSchedule = QuizSchedule::with('userGroups:id,name')->where('code', $schedule)->firstOrFail();
        $subscription = request()->user()->hasActiveSubscription($quiz->sub_category_id, 'quizzes');

        // Load completed quiz sessions in this schedule
        $quiz->loadCount(['sessions' => function ($query) use ($quizSchedule) {
            $query->where('user_id', auth()->user()->id)->where('quiz_schedule_id', $quizSchedule->id)->where('status', 'completed');
        }]);

        $scheduleUserGroups = $quizSchedule->userGroups()->pluck('id');
        $authUserGroups = auth()->user()->userGroups()->pluck('id');

        // check user exists in quiz schedule user groups
        $userHasAccess = count(array_intersect($scheduleUserGroups->toArray(), $authUserGroups->toArray())) > 0;
        if (!$userHasAccess) {
            return redirect()->back()->with('errorMessage', __('quiz_no_access_note'));
        }

        // check access is open
        $allowAccess = false;
        $now = Carbon::now()->timezone($localization->default_timezone);

        if ($quizSchedule->schedule_type == 'fixed') {
            $grace = $quizSchedule->starts_at->addMinutes($quizSchedule->grace_period);
            $allowAccess = $now->between($quizSchedule->starts_at, $grace);
        }

        if ($quizSchedule->schedule_type == 'flexible') {
            $allowAccess = $now->between($quizSchedule->starts_at, $quizSchedule->ends_at);
        }

        if ($quizSchedule->status == 'expired' || $quizSchedule->status == 'cancelled') {
            $allowAccess = false;
        }

        if (!$allowAccess) {
            return redirect()->back()->with('errorMessage', __('schedule_close_note'));
        }

        // Check if any uncompleted sessions
        if ($quiz->sessions()->where('user_id', auth()->user()->id)->where('status', '=', 'started')->where('quiz_schedule_id', $quizSchedule->id)->count() > 0) {
            $session = $this->repository->getScheduleSession($quiz, $quizSchedule->id);
        } else {
            // Restrict quiz schedule attempt to one time
            if ($quiz->sessions_count >= 1) {
                return redirect()->back()->with('errorMessage', __('schedule_completed_msg'));
            }

            if ($quiz->is_paid && !$subscription) {
                // check redeem eligibility
                if ($quiz->can_redeem) {
                    if (auth()->user()->balance < $quiz->points_required) {
                        $msg = __('insufficient_points') . ' ' . str_replace('--', auth()->user()->balance . ' XP', __('wallet_balance_text')) . ' ' . str_replace('--', $quiz->points_required . ' XP', __('required_points_are'));
                        return redirect()->back()->with('errorMessage', $msg);
                    }
                } else {
                    return redirect()->back()->with('errorMessage', __('You don\'t have an active plan to access this quiz. Please subscribe.'));
                }
            }

            $session = $this->repository->createScheduleSession($quiz, $quizSchedule, $this->questionRepository);

            // deduct wallet points in case of not having a subscription for a paid quiz
            if ($session) {
                if ($quiz->is_paid && !$subscription && $quiz->can_redeem) {
                    auth()->user()->withdraw($quiz->points_required, [
                        'session' => $session->code,
                        'description' => 'Attempt of Quiz ' . $quiz->title,
                    ]);
                }
            }
        }

        return redirect()->route('go_to_quiz', ['quiz' => $quiz->slug, 'session' => $session->code]);
    }
}
