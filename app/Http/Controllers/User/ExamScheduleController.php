<?php


namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Models\Exam;
use App\Models\ExamSchedule;
use App\Repositories\QuestionRepository;
use App\Repositories\UserExamRepository;
use App\Settings\LocalizationSettings;
use App\Transformers\Platform\ExamDetailTransformer;
use App\Transformers\Platform\ExamScheduleDetailTransformer;
use Carbon\Carbon;
use Inertia\Inertia;

class ExamScheduleController extends Controller
{
    private UserExamRepository $repository;
    private QuestionRepository $questionRepository;

    public function __construct(UserExamRepository $repository, QuestionRepository $questionRepository)
    {
        $this->middleware(['role:guest|student|employee']);
        $this->repository = $repository;
        $this->questionRepository = $questionRepository;
    }

    /**
     * Load Exam Schedule Instructions Page
     *
     * @param $slug
     * @param $schedule
     * @param LocalizationSettings $localization
     * @return \Inertia\Response
     */
    public function instructions($slug, $schedule, LocalizationSettings $localization)
    {
        $examSchedule = ExamSchedule::with('userGroups:id,name')->where('code', $schedule)->firstOrFail();

        // Load exam with unfinished sessions
        $exam = Exam::where('slug', $slug)
            ->published()
            ->with(['subCategory:id,name', 'examType:id,name', 'examSections:id,exam_id,name,total_questions,total_duration,total_marks'])
            ->withCount(['sessions' => function ($query) use ($examSchedule) {
                $query->where('user_id', auth()->user()->id)->where('exam_schedule_id', $examSchedule->id)->where('status', '=', 'started');
            }])
            ->firstOrFail();

        $scheduleUserGroups = $examSchedule->userGroups()->pluck('id');
        $authUserGroups = auth()->user()->userGroups()->pluck('id');

        // check user exists in exam schedule user groups
        $userHasAccess = count(array_intersect($scheduleUserGroups->toArray(), $authUserGroups->toArray())) > 0;

        // check access is open
        $allowAccess = false;
        $closesAt = '';
        $now = Carbon::now()->timezone($localization->default_timezone);

        if($examSchedule->schedule_type == 'fixed') {
            $grace = $examSchedule->starts_at->addMinutes($examSchedule->grace_period);
            $allowAccess = $now->between($examSchedule->starts_at, $grace);
            $closesAt = $grace->toDayDateTimeString();
        }

        if($examSchedule->schedule_type == 'flexible') {
            $allowAccess = $now->between($examSchedule->starts_at, $examSchedule->ends_at);
            $closesAt = $examSchedule->ends_at->toDayDateTimeString();
        }

        if($examSchedule->status == 'expired' || $examSchedule->status == 'cancelled') {
            $allowAccess = false;
        }

        // Countdown timer
        $startsIn =  $now->diffInSeconds($examSchedule->starts_at, false);

        return Inertia::render('User/ExamScheduleInstructions', [
            'exam' => fractal($exam, new ExamDetailTransformer())->toArray()['data'],
            'schedule' => fractal($examSchedule, new ExamScheduleDetailTransformer())->toArray()['data'],
            'instructions' => $this->repository->getInstructions($exam),
            'userHasAccess' => $userHasAccess,
            'startsIn' => $startsIn,
            'allowAccess' => $allowAccess,
            'closesAt' => $closesAt,
            'subscription' => request()->user()->hasActiveSubscription($exam->sub_category_id, 'exams'),
        ]);
    }

    /**
     * Create or Load a Exam Session of a schedule and redirect to exam screen
     *
     * @param Exam $exam
     * @param $schedule
     * @param LocalizationSettings $localization
     * @return \Illuminate\Http\RedirectResponse
     */
    public function initExamSchedule(Exam $exam, $schedule, LocalizationSettings $localization)
    {
        $examSchedule = ExamSchedule::with('userGroups:id,name')->where('code', $schedule)->firstOrFail();
        $subscription = request()->user()->hasActiveSubscription($exam->sub_category_id, 'exams');

        // Load completed exam sessions in this schedule
        $exam->loadCount(['sessions' => function ($query) use ($examSchedule) {
            $query->where('user_id', auth()->user()->id)->where('exam_schedule_id', $examSchedule->id)->where('status', 'completed');
        }]);

        $scheduleUserGroups = $examSchedule->userGroups()->pluck('id');
        $authUserGroups = auth()->user()->userGroups()->pluck('id');

        // check user exists in exam schedule user groups
        $userHasAccess = count(array_intersect($scheduleUserGroups->toArray(), $authUserGroups->toArray())) > 0;
        if(!$userHasAccess) {
            return redirect()->back()->with('errorMessage', __('exam_no_access_note'));
        }

        // check access is open
        $allowAccess = false;
        $now = Carbon::now()->timezone($localization->default_timezone);

        if($examSchedule->schedule_type == 'fixed') {
            $grace = $examSchedule->starts_at->addMinutes($examSchedule->grace_period);
            $allowAccess = $now->between($examSchedule->starts_at, $grace);
        }

        if($examSchedule->schedule_type == 'flexible') {
            $allowAccess = $now->between($examSchedule->starts_at, $examSchedule->ends_at);
        }

        if($examSchedule->status == 'expired' || $examSchedule->status == 'cancelled') {
            $allowAccess = false;
        }

        if(!$allowAccess) {
            return redirect()->back()->with('errorMessage', __('schedule_close_note'));
        }

        // Check if any uncompleted sessions
        if($exam->sessions()->where('user_id', auth()->user()->id)->where('status', '=', 'started')->where('exam_schedule_id', $examSchedule->id)->count() > 0) {
            $session = $this->repository->getScheduleSession($exam, $examSchedule->id);
        } else {
            // Restrict exam schedule attempt to one time
            if($exam->sessions_count >= 1) {
                return redirect()->back()->with('errorMessage', __('schedule_completed_msg'));
            }

            if($exam->is_paid && !$subscription) {
                // check redeem eligibility
                if($exam->can_redeem) {
                    if(auth()->user()->balance < $exam->points_required) {
                        $msg = __('insufficient_points').' '.str_replace('--', auth()->user()->balance.' XP', __('wallet_balance_text')).' '.str_replace('--',$exam->points_required.' XP',__('required_points_are'));
                        return redirect()->back()->with('errorMessage', $msg);
                    }
                } else {
                    return redirect()->back()->with('errorMessage', __('You don\'t have an active plan to access this exam. Please subscribe.'));
                }
            }

            $session = $this->repository->createScheduleSession($exam, $examSchedule, $this->questionRepository);

            // deduct wallet points in case of not having a subscription for a paid exam
            if($session) {
                if($exam->is_paid && !$subscription && $exam->can_redeem) {
                    auth()->user()->withdraw($exam->points_required, [
                        'session' => $session->code,
                        'description' => 'Attempt of Exam ' . $exam->title,
                    ]);
                }
            }
        }

        return redirect()->route('go_to_exam', ['exam' => $exam->slug, 'session' => $session->code]);
    }
}
