<?php


namespace App\Repositories;

use App\Models\Quiz;
use App\Models\QuizSession;
use Carbon\Carbon;
use Jenssegers\Agent\Agent;

class UserQuizRepository
{
    /**
     * Get the existing in-completed session
     *
     * @param Quiz $quiz
     * @return \Illuminate\Database\Eloquent\Model|\Illuminate\Database\Eloquent\Relations\HasMany|object|null
     */
    public function getSession(Quiz $quiz)
    {
        return $quiz->sessions()->where('user_id', auth()->user()->id)->latest()->first();
    }

    /**
     * Get the existing in-completed session of a quiz schedule
     *
     * @param Quiz $quiz
     * @param $scheduleId
     * @return \Illuminate\Database\Eloquent\Model|\Illuminate\Database\Eloquent\Relations\HasMany|object|null
     */
    public function getScheduleSession(Quiz $quiz, $scheduleId)
    {
        return $quiz->sessions()->where('user_id', auth()->user()->id)->where('quiz_schedule_id', '=', $scheduleId)->latest()->first();
    }

    /**
     * Create a new quiz session
     *
     * @param Quiz $quiz
     * @param QuestionRepository $questionRepository
     * @return |null
     */
    public function createSession(Quiz $quiz, QuestionRepository $questionRepository)
    {
        $now = Carbon::now();
        $questions = $quiz->questions()->with(['questionType:id,name,code'])->get();

        $session = QuizSession::create([
            'quiz_id' => $quiz->id,
            'user_id' => auth()->user()->id,
            'starts_at' => $now->toDateTimeString(),
            'ends_at' => $now->addSeconds($quiz->total_duration)->toDateTimeString(),
            'status' => 'started'
        ]);

        // Attach questions to quiz session
        if($session) {
            if($quiz->settings->get('shuffle_questions', false)) {
                $questions = $questions->shuffle();
            }
            $formattedQuestions = [];
            $sno = 1;
            foreach ($questions as $question) {
                $formattedQuestions[$question->id] = [
                    'sno' => $sno,
                    'original_question' => formatQuestionProperty($question->question, $question->questionType->code),
                    'options' => serialize(formatOptionsProperty($question->options, $question->questionType->code, $question->question)),
                    'correct_answer' => serialize($questionRepository->formatCorrectAnswer($question, [])),
                    'status' => 'not_visited',
                ];
                $sno++;
            }
            $session->questions()->attach($formattedQuestions);
            return $session;
        }

        return null;
    }

    /**
     * Create a new quiz session for a schedule
     *
     * @param Quiz $quiz
     * @param $schedule
     * @param QuestionRepository $questionRepository
     * @return |null
     */
    public function createScheduleSession(Quiz $quiz, $schedule, QuestionRepository $questionRepository)
    {
        $now = Carbon::now();
        $questions = $quiz->questions()->with(['questionType:id,name,code'])->get();

        if($schedule->schedule_type == 'fixed') {
            $starts_at = $now->toDateTimeString();
            $ends_at = $schedule->ends_at->timezone('UTC')->toDateTimeString();
        } else {
            $starts_at = $now->toDateTimeString();
            $ends_at = $now->addSeconds($quiz->total_duration)->toDateTimeString();
        }

        $session = QuizSession::create([
            'quiz_id' => $quiz->id,
            'quiz_schedule_id' => $schedule->id,
            'user_id' => auth()->user()->id,
            'starts_at' => $starts_at,
            'ends_at' => $ends_at,
            'status' => 'started',
        ]);

        // Attach questions to quiz session
        if($session) {
            if($quiz->settings->get('shuffle_questions', false)) {
                $questions = $questions->shuffle();
            }
            $formattedQuestions = [];
            $sno = 1;
            foreach ($questions as $question) {
                $formattedQuestions[$question->id] = [
                    'sno' => $sno,
                    'original_question' => formatQuestionProperty($question->question, $question->questionType->code),
                    'options' => serialize(formatOptionsProperty($question->options, $question->questionType->code, $question->question)),
                    'correct_answer' => serialize($questionRepository->formatCorrectAnswer($question, [])),
                    'status' => 'not_visited',
                ];
                $sno++;
            }
            $session->questions()->attach($formattedQuestions);
            return $session;
        }

        return null;
    }

    /**
     * Get Quiz Instructions
     *
     * @param Quiz $quiz
     * @return \string[][]
     */
    public function getInstructions(Quiz $quiz)
    {
        $duration = $quiz->total_duration/60;
        $negativeMarksText= "";

        if($quiz->settings->get('auto_grading', true)) {
            $marks = __('Random');
        } else {
            $marks = $quiz->settings->get('correct_marks');
        }

        $marksText = str_replace("--", $marks ,__('quiz_marks_instruction'));

        if($quiz->settings->get('enable_negative_marking', false)) {
            $negative_marks = $quiz->settings->get('negative_marking_type', 'fixed') == 'fixed'
                ? $quiz->settings->get('negative_marks', 0)
                : $quiz->settings->get('negative_marks', 0)."%";
            $negativeMarksText .= str_replace("--", $negative_marks ,__('negative_marks_text'));
        } else {
            $negativeMarksText .= __('no_negative_marks_text');
        }

        return [
            'quiz' => [
                str_replace("--", $duration ,__('quiz_duration_instruction')),
                str_replace("--", $quiz->total_questions ,__('quiz_questions_instruction')),
                $marksText,
                $negativeMarksText,
                str_replace("--", $quiz->settings->get('cutoff', 0).'%',__('quiz_percentage_instruction')),
            ],
            "standard" => [
                __('quiz_clock_instruction'),
                __('question_navigation_instruction'),
                __('question_save_instruction'),
                __('question_palette_instruction')
            ]
        ];
    }

    /**
     * Get session result object
     *
     * @param $session
     * @param $quiz
     * @return array
     */
    public function sessionResults($session, $quiz)
    {
        $questions = collect($session->questions);
        $answered = $questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->count();
        $correct = $questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->where('pivot.is_correct', '=', true)->count();
        $wrong = $questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->where('pivot.is_correct', '=', false)->count();
        $answered_time = $questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->sum('pivot.time_taken');
        $correctMarks = $questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->sum('pivot.marks_earned');
        $negativeMarks = $questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->sum('pivot.marks_deducted');
        $percentage = $quiz->total_marks != 0 ? round(($correctMarks - $negativeMarks) * (100/$quiz->total_marks), 2) : 0;
        $agent = new Agent();
        return [
            'score' => $correctMarks - $negativeMarks,
            'marks_earned' => $correctMarks,
            'marks_deducted' => $negativeMarks,
            'percentage' =>  $percentage,
            'cutoff' => $quiz->settings->get('cutoff'),
            'pass_or_fail' => $percentage >= $quiz->settings->get('cutoff') ? 'Passed' : 'Failed',
            'speed' => round(calculateSpeedPerHour($answered, $session->total_time_taken)),//que/hr
            'accuracy' => round(calculateAccuracy($correct, $answered), 2), //%
            'total_questions' => $quiz->total_questions,
            'total_duration' => $quiz->total_duration / 60,
            'total_marks' => $quiz->total_marks,
            'answered_questions' => $answered,
            'unanswered_questions' => $quiz->total_questions - $answered,
            'correct_answered_questions' => $correct,
            'wrong_answered_questions' => $wrong,
            'total_time_taken' => formattedSeconds($session->total_time_taken),
            'time_taken_for_answered' => formattedSeconds($answered_time),
            'time_taken_for_other' => formattedSeconds($session->total_time_taken - $answered_time),
            'time_taken_for_correct_answered' => formattedSeconds($questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->where('pivot.is_correct', '=', true)->sum('pivot.time_taken')),
            'time_taken_for_wrong_answered' => formattedSeconds($questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->where('pivot.is_correct', '=', false)->sum('pivot.time_taken')),
            'user_agent' => $agent->getUserAgent(),
            'ip_address' => request()->getClientIp()
        ];
    }

    /**
     * Get quiz progress links
     *
     * @param $slug
     * @param $session
     * @param $active
     * @return array[]
     */
    public function getQuizProgressLinks($slug, $session, $active)
    {
        return [
            [
                'key' => 'analysis',
                'title' => __('Analysis'),
                'url' => route('quiz_results', ['quiz' => $slug, 'session' => $session]),
                'active' => $active == 'quiz_results'
            ],
            [
                'key' => 'solutions',
                'title' => __('Solutions'),
                'url' => route('quiz_solutions', ['quiz' => $slug, 'session' => $session]),
                'active' => $active == 'quiz_solutions'
            ],
            [
                'key' => 'leaderboard',
                'title' => __('Top Scorers'),
                'url' => route('quiz_leaderboard', ['quiz' => $slug, 'session' => $session]),
                'active' => $active == 'quiz_leaderboard'
            ]
        ];
    }
}
