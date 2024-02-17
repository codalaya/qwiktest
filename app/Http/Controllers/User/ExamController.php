<?php


namespace App\Http\Controllers\User;

use App\Http\Controllers\Controller;
use App\Http\Requests\Platform\ExamUpdateAnswerRequest;
use App\Models\Exam;
use App\Models\ExamSection;
use App\Models\ExamSession;
use App\Models\Question;
use App\Repositories\QuestionRepository;
use App\Repositories\UserExamRepository;
use App\Settings\LocalizationSettings;
use App\Settings\SiteSettings;
use App\Transformers\Admin\ExamScoreReportTransformer;
use App\Transformers\Platform\ExamDetailTransformer;
use App\Transformers\Platform\ExamQuestionTransformer;
use App\Transformers\Platform\ExamResultSectionTransformer;
use App\Transformers\Platform\ExamSessionSectionTransformer;
use App\Transformers\Platform\QuizSolutionTransformer;
use App\Transformers\Platform\TopScorerTransformer;
use Barryvdh\DomPDF\Facade as PDF;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class ExamController extends Controller
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
     * Load Exam Instructions Page
     *
     * @param $slug
     * @return \Inertia\Response
     */
    public function instructions($slug)
    {
        $exam = Exam::where('slug', $slug)
            ->published()
            ->isPublic()
            ->with(['subCategory:id,name', 'examType:id,name', 'examSections:id,exam_id,name,total_questions,total_duration,total_marks'])
            ->withCount(['sessions' => function ($query) {
                $query->where('user_id', auth()->user()->id)->where('status', '=', 'started');
            }])
            ->firstOrFail();

        return Inertia::render('User/ExamInstructions', [
            'exam' => fractal($exam, new ExamDetailTransformer())->toArray()['data'],
            'instructions' => $this->repository->getInstructions($exam),
            'subscription' => request()->user()->hasActiveSubscription($exam->sub_category_id, 'exams'),
        ]);
    }

    /**
     * Create or Load a Exam Session and redirect to exam screen
     *
     * @param Exam $exam
     * @return \Illuminate\Http\RedirectResponse
     */
    public function initExam(Exam $exam)
    {
        $subscription = request()->user()->hasActiveSubscription($exam->sub_category_id, 'exams');

        // load completed exam sessions
        $exam->loadCount(['sessions' => function ($query) {
            $query->where('user_id', auth()->user()->id)->where('status', 'completed');
        }]);

        // check if any uncompleted sessions
        if ($exam->sessions()->where('user_id', auth()->user()->id)->where('status', '=', 'started')->count() > 0) {
            $session = $this->repository->getSession($exam);
        } else {
            // check restricted attempts
            if ($exam->settings->get('restrict_attempts')) {
                if ($exam->sessions_count >= $exam->settings->get('no_of_attempts')) {
                    return redirect()->back()->with('errorMessage', __('max_attempts_text'));
                }
            }

            if ($exam->is_paid && !$subscription) {
                // check redeem eligibility
                if ($exam->can_redeem) {
                    if (auth()->user()->balance < $exam->points_required) {
                        $msg = __('insufficient_points') . ' ' . str_replace('--', auth()->user()->balance . ' XP', __('wallet_balance_text')) . ' ' . str_replace('--', $exam->points_required . ' XP', __('required_points_are'));
                        return redirect()->back()->with('errorMessage', $msg);
                    }
                } else {
                    return redirect()->back()->with('errorMessage', __('You don\'t have an active plan to access this content. Please subscribe.'));
                }
            }

            $session = $this->repository->createSession($exam, $this->questionRepository);

            // deduct wallet points in case of not having a subscription for a paid exam
            if ($session) {
                if ($exam->is_paid && !$subscription && $exam->can_redeem) {
                    auth()->user()->withdraw($exam->points_required, [
                        'session' => $session->code,
                        'description' => 'Attempt of Exam ' . $exam->title,
                    ]);
                }
            }
        }

        return redirect()->route('go_to_exam', ['exam' => $exam->slug, 'session' => $session->code]);
    }

    /**
     * Go To Exam Screen
     *
     * @param Exam $exam
     * @param $session
     * @return \Illuminate\Http\RedirectResponse|\Inertia\Response
     */
    public function goToExam(Exam $exam, $session)
    {
        $session = ExamSession::with('sections', 'questions')->where('code', $session)->firstOrFail();

        $now = Carbon::now();

        $remainingTime =  $now->diffInSeconds($session->ends_at, false);

        if ($session->status !== 'completed' && $remainingTime < 15) {
            $session->results = $this->repository->sessionResults($session, $exam);
            $session->status = 'completed';
            $session->completed_at = Carbon::now()->toDateTimeString();
            $session->update();

            return redirect()->route('exam_thank_you', ['exam' => $exam->slug, 'session' => $session->code]);
        }

        return Inertia::render('User/ExamScreen', [
            'exam' => $exam->only('code', 'title', 'slug', 'total_questions', 'settings'),
            'session' => $session,
            'examSections' => fractal($session->sections, new ExamSessionSectionTransformer())->toArray()['data'],
            'remainingTime' => $remainingTime
        ]);
    }

    /**
     * Get exam section questions api endpoint
     *
     * @param Exam $exam
     * @param $session
     * @param $section
     * @return \Illuminate\Http\JsonResponse
     */
    public function getExamSectionQuestions(Exam $exam, $session, $section)
    {
        $session = ExamSession::with(['questions', 'sections'])->where('code', $session)->firstOrFail();

        $now = Carbon::now();
        $examSection = $session->sections()->wherePivot('exam_section_id', $section)->first();
        $remainingTime =  $now->diffInSeconds($examSection->pivot->ends_at, false);

        $questions = fractal(
            $session->questions()->with(['questionType:id,name,code', 'skill:id,name', 'comprehensionPassage:id,body'])
                ->withPivot('exam_section_id', 'sno')
                ->where('exam_section_id', $section)
                ->orderBy('sno')
                ->get(),
            new ExamQuestionTransformer()
        )->toArray();

        return response()->json([
            'questions' => $questions['data'],
            'answered' => $session->questions()->wherePivot('exam_section_id', $section)->wherePivotIn('status', ['answered', 'answered_mark_for_review'])->count(),
            'remainingTime' => $remainingTime
        ], 200);
    }

    /**
     * Check the user submitted answer is correct or not and update session accordingly
     *
     * @param ExamUpdateAnswerRequest $request
     * @param Exam $exam
     * @param $session
     * @param $section
     * @return \Illuminate\Http\JsonResponse
     */
    public function updateAnswer(ExamUpdateAnswerRequest $request, Exam $exam, $session, ExamSection $section)
    {
        $session = ExamSession::select(['id', 'code', 'exam_id', 'total_time_taken', 'current_section'])
            ->where('code', $session)
            ->firstOrFail();

        if ($session->status == 'completed') {
            return response()->json([
                'answered' => $session->questions()->wherePivotIn('status', ['answered', 'answered_mark_for_review'])->count()
            ], 200);
        }

        $question = Question::select(['id', 'question', 'options', 'correct_answer', 'default_marks', 'solution', 'question_type_id'])
            ->with(['questionType:id,name,code'])
            ->where('code', $request->question_id)
            ->firstOrFail();

        $isCorrect = false;
        $correctAnswer = null;
        $marksEarned = 0;
        $marksDeducted = 0;

        if ($request->status === 'answered' || $request->status === 'answered_mark_for_review') {
            $isCorrect = $this->questionRepository->evaluateAnswer($question, $request->user_answer);

            // Calculate Positive & Negative Marks based on preferences
            $marks = $exam->settings->get('auto_grading', true) ? $question->default_marks : $section->correct_marks;
            if ($isCorrect) {
                $marksEarned = $marks;
            } else {
                if ($exam->settings->get('enable_negative_marking', false)) {
                    if ($section->negative_marking_type == 'fixed') {
                        $marksDeducted = $section->negative_marks;
                    } else {
                        $marksDeducted = $section->negative_marks != 0 ? round(($marks * $section->negative_marks)  / 100, 2) : 0;
                    }
                }
            }
        }

        /*Insert or Update Session Question*/
        DB::table('exam_session_questions')->upsert(
            [
                'question_id' => $question->id,
                'original_question' => formatQuestionProperty($question->question, $question->questionType->code),
                'exam_session_id' => $session->id,
                'exam_section_id' => $section->id,
                'user_answer' => serialize($request->user_answer),
                'time_taken' => $request->time_taken,
                'is_correct' => $isCorrect,
                'status' => $request->status,
                'marks_earned' => $marksEarned,
                'marks_deducted' => $marksDeducted
            ],
            ['question_id', 'exam_session_id', 'exam_section_id'],
            ['user_answer', 'time_taken', 'is_correct', 'status', 'marks_earned', 'marks_deducted']
        );

        /*Update Session */
        $session->current_section = $request->current_section;
        $session->current_question = $request->current_question;
        $session->total_time_taken = $request->total_time_taken;
        $session->update();

        DB::table('exam_session_sections')
            ->where('exam_section_id', $section->id)
            ->where('exam_session_id', $session->id)
            ->update([
                'current_question' => $request->current_question,
                'total_time_taken' => $request->current_section_total_time_taken,
                'status' => 'visited'
            ]);

        return response()->json([
            'answered' => $session->questions()->wherePivot('exam_section_id', $section->id)->wherePivotIn('status', ['answered', 'answered_mark_for_review'])->count()
        ], 200);
    }

    /**
     * Finish the exam
     *
     * @param Request $request
     * @param Exam $exam
     * @param $session
     * @return \Illuminate\Http\RedirectResponse
     */
    public function finish(Request $request, Exam $exam, $session)
    {
        $session = ExamSession::with(['questions', 'sections'])->where('code', $session)->firstOrFail();

        if ($session->status == 'completed') {
            redirect()->route('exam_thank_you', ['exam' => $exam->slug, 'session' => $session->code]);
        }

        $session->total_time_taken = $request->get('total_time_taken');
        $session->status = 'completed';
        $session->completed_at = Carbon::now()->toDateTimeString();
        $session->update();

        foreach ($session->sections as $section) {
            $results = $this->repository->sectionResults($session, $exam, $section);
            DB::table('exam_session_sections')
                ->where('exam_section_id', $section->id)
                ->where('exam_session_id', $session->id)
                ->update([
                    'results' => $results,
                ]);
        }

        $session = ExamSession::with(['questions', 'sections'])->where('code', $session->code)->firstOrFail();

        $session->results = $this->repository->sessionResults($session, $exam);
        $session->update();

        return redirect()->route('exam_thank_you', ['exam' => $exam->slug, 'session' => $session->code]);
    }

    /**
     * Exam thank you screen
     *
     * @param Exam $exam
     * @param $session
     * @return \Inertia\Response
     */
    public function thankYou(Exam $exam, $session)
    {
        $session = ExamSession::where('code', $session)->firstOrFail();

        return Inertia::render('User/ExamThanksScreen', [
            'exam' => $exam->only('code', 'title', 'slug', 'total_marks'),
            'session' => $session,
        ]);
    }

    /**
     * Exam Session Analysis and Progress Status
     *
     * @param Exam $exam
     * @param $session
     * @return \Inertia\Response
     */
    public function results(Exam $exam, $session)
    {
        $session = ExamSession::where('code', $session)->firstOrFail();

        return Inertia::render('User/ExamResults', [
            'exam' => $exam->only('code', 'title', 'slug', 'total_questions', 'total_marks', 'settings'),
            'session' => $session->only('code', 'total_time_taken', 'results', 'status'),
            'sections' => fractal($session->sections, new ExamResultSectionTransformer())->toArray()['data'],
            'steps' => $this->repository->getExamProgressLinks($exam->slug, $session->code, 'exam_results'),
        ]);
    }

    /**
     * Exam session solutions page
     *
     * @param Exam $exam
     * @param $session
     * @return \Inertia\Response
     */
    public function solutions(Exam $exam, $session)
    {
        $session = ExamSession::with(['sections' => function ($query) {
            $query->orderBy('exam_session_sections.sno');
        }])->where('code', $session)->firstOrFail();

        return Inertia::render('User/ExamSolutions', [
            'exam' => $exam->only('code', 'title', 'slug', 'total_questions', 'total_marks', 'settings'),
            'sections' => fractal($session->sections, new ExamResultSectionTransformer())->toArray()['data'],
            'session' => $session->only('code', 'total_time_taken', 'results', 'status'),
            'steps' => $this->repository->getExamProgressLinks($exam->slug, $session->code, 'exam_solutions'),
        ]);
    }

    /**
     * Get exam solutions api endpoint
     *
     * @param Exam $exam
     * @param $session
     * @param $section
     * @return \Illuminate\Http\JsonResponse
     */
    public function fetchSolutions(Exam $exam, $session, $section)
    {
        $session = ExamSession::where('code', $session)->firstOrFail();

        $questions = fractal(
            $session->questions()->wherePivot('exam_section_id', $section)->with(['questionType:id,name,code', 'skill:id,name'])
                ->orderBy('sno')->get(['id', 'code', 'question', 'question_type_id', 'skill_id', 'solution', 'solution_video']),
            new QuizSolutionTransformer()
        )->toArray();

        return response()->json([
            'questions' => $questions['data'],
        ], 200);
    }

    /**
     * Exam Session Leaderboard
     *
     * @param Exam $exam
     * @param $session
     * @return \Inertia\Response
     */
    public function leaderboard(Exam $exam, $session)
    {
        $session = ExamSession::where('code', $session)->firstOrFail();

        $key = $session->exam_schedule_id ? 'exam_schedule_id' : 'exam_id';
        $value = $session->exam_schedule_id ? $session->exam_schedule_id : $exam->id;

        $topScorers = ExamSession::select('user_id', 'exam_id')
            ->with('user:id,first_name,last_name')
            ->selectRaw("max(CAST(JSON_EXTRACT(`results`, \"$.score\") AS DECIMAL(10,6))) as high_score")
            ->selectRaw("max(CAST(JSON_EXTRACT(`results`, \"$.percentage\") AS DECIMAL(10,6))) as high_percentage")
            ->where($key, $value)
            ->groupBy('user_id', 'exam_id')
            ->orderBy('high_score', 'desc')
            ->get();

        return Inertia::render('User/ExamLeaderBoard', [
            'exam' => $exam->only('code', 'title', 'slug', 'total_questions', 'total_marks', 'settings'),
            'session' => $session->only('code', 'total_time_taken', 'results', 'status'),
            'topScorers' => fractal($topScorers, new TopScorerTransformer())->toArray()['data'],
            'steps' => $this->repository->getExamProgressLinks($exam->slug, $session->code, 'exam_leaderboard'),
        ]);
    }

    /**
     * User Exam Session Export PDF
     *
     * @param Exam $exam
     * @param $session
     * @param LocalizationSettings $localization
     * @param SiteSettings $settings
     * @return \Illuminate\Http\Response
     */
    public function exportPDF(Exam $exam, $session, LocalizationSettings $localization, SiteSettings $settings)
    {
        $session = ExamSession::with('user')->where('code', $session)->firstOrFail();

        $now = Carbon::now()->timezone($localization->default_timezone);
        $user = auth()->user()->first_name . ' ' . auth()->user()->last_name;

        $pdf = PDF::loadView('pdf.exam-session-report', [
            'exam' => $exam->only('code', 'title'),
            'session' => fractal($session, new ExamScoreReportTransformer())->toArray()['data'],
            'footer' => "* Report Generated from {$settings->app_name} by {$user} on {$now->toDayDateTimeString()}",
            'logo' => url('storage/' . $settings->logo_path),
            'rtl' => $localization->default_direction == 'rtl'
        ]);

        return $pdf->download("report-{$session->code}.pdf");
    }
}
