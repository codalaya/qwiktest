<?php

namespace App\Repositories;

use App\Models\Exam;
use App\Models\ExamSession;
use Carbon\Carbon;
use Illuminate\Support\Facades\DB;
use Jenssegers\Agent\Agent;

class UserExamRepository
{
    /**
     * Get the existing in-completed session
     *
     * @param Exam $exam
     * @return \Illuminate\Database\Eloquent\Model|\Illuminate\Database\Eloquent\Relations\HasMany|object|null
     */
    public function getSession(Exam $exam)
    {
        return $exam->sessions()->where('user_id', auth()->user()->id)->latest()->first();
    }

    /**
     * Get the existing in-completed session of a exam schedule
     *
     * @param Exam $exam
     * @param $scheduleId
     * @return \Illuminate\Database\Eloquent\Model|\Illuminate\Database\Eloquent\Relations\HasMany|object|null
     */
    public function getScheduleSession(Exam $exam, $scheduleId)
    {
        return $exam->sessions()->where('user_id', auth()->user()->id)->where('exam_schedule_id', '=', $scheduleId)->latest()->first();
    }

    /**
     * Create a new exam session
     *
     * @param Exam $exam
     * @param QuestionRepository $questionRepository
     * @return |null
     */
    public function createSession(Exam $exam, QuestionRepository $questionRepository)
    {
        $now = Carbon::now();
        $questions = $exam->questions()->withPivot('exam_section_id')->with(['questionType:id,name,code'])->get()->groupBy('pivot.exam_section_id');
        $sections = $exam->examSections()->orderBy('section_order', 'asc')->get();

        $session = ExamSession::create([
            'exam_id' => $exam->id,
            'user_id' => auth()->user()->id,
            'starts_at' => $now->toDateTimeString(),
            'ends_at' => $now->addSeconds($exam->total_duration)->toDateTimeString(),
            'status' => 'started'
        ]);

        // Attach sections & questions to exam session
        if($session) {
            $formattedSections = [];
            $formattedQuestions = [];
            $sno = 1;
            $nowTime = Carbon::now();
            foreach ($sections as $section) {
                $formattedSections[$section->id] = [
                    'sno' => $section->section_order,
                    'name' => $section->name,
                    'section_id' => $section->section_id,
                    'status' => $sno == 1 ? 'started' : 'not_visited',
                    'starts_at' => $nowTime->toDateTimeString(),
                    'ends_at' => $nowTime->addSeconds($section->total_duration)->toDateTimeString(),
                ];
                $sno++;

                if($exam->settings->get('shuffle_questions', false)) {
                    $sectionQuestions = $questions[$section->id]->shuffle();
                } else {
                    $sectionQuestions = $questions[$section->id];
                }

                $qno = 1;
                foreach ($sectionQuestions as $question) {
                    $formattedQuestions[$question->id] = [
                        'sno' => $qno,
                        'original_question' => formatQuestionProperty($question->question, $question->questionType->code),
                        'options' => serialize(formatOptionsProperty($question->options, $question->questionType->code, $question->question)),
                        'correct_answer' => serialize($questionRepository->formatCorrectAnswer($question, [])),
                        'status' => 'not_visited',
                        'exam_section_id' => $section->id,
                    ];
                    $qno++;
                }
            }
            DB::transaction(function () use($session, $formattedSections, $formattedQuestions) {
                $session->sections()->attach($formattedSections);
                $session->questions()->attach($formattedQuestions);
            });
            return $session;
        }

        return null;
    }

    /**
     * Create a new exam session for a schedule
     *
     * @param Exam $exam
     * @param $schedule
     * @param QuestionRepository $questionRepository
     * @return |null
     */
    public function createScheduleSession(Exam $exam, $schedule, QuestionRepository $questionRepository)
    {
        $now = Carbon::now();
        $questions = $exam->questions()->with(['questionType:id,name,code'])->get();

        if($schedule->schedule_type == 'fixed') {
            $starts_at = $now->toDateTimeString();
            $ends_at = $schedule->ends_at->timezone('UTC')->toDateTimeString();
        } else {
            $starts_at = $now->toDateTimeString();
            $ends_at = $now->addSeconds($exam->total_duration)->toDateTimeString();
        }

        $session = ExamSession::create([
            'exam_id' => $exam->id,
            'exam_schedule_id' => $schedule->id,
            'user_id' => auth()->user()->id,
            'starts_at' => $starts_at,
            'ends_at' => $ends_at,
            'status' => 'started',
        ]);

        // Attach questions to exam session
        if($session) {
            if($exam->settings->get('shuffle_questions', false)) {
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
     * Get Exam Instructions
     *
     * @param Exam $exam
     * @return \string[][]
     */
    public function getInstructions(Exam $exam)
    {
        $duration = $exam->total_duration/60;
        $negativeMarksText= "";

        if($exam->settings->get('auto_grading', true)) {
            $marks = __('Random');
        } else {
            $marks = $exam->settings->get('correct_marks');
        }

        $marksText = str_replace("--", $marks ,__('quiz_marks_instruction'));

        if($exam->settings->get('enable_negative_marking', false)) {
            $negative_marks = $exam->settings->get('negative_marking_type', 'fixed') == 'fixed'
                ? $exam->settings->get('negative_marks', 0)
                : $exam->settings->get('negative_marks', 0)."%";
            $negativeMarksText .= str_replace("--", $negative_marks ,__('negative_marks_text'));
        } else {
            $negativeMarksText .= __('no_negative_marks_text');
        }

        return [
            'exam' => [
                str_replace("--", $duration ,__('quiz_duration_instruction')),
                str_replace("--", $exam->total_questions ,__('quiz_questions_instruction')),
                str_replace("--", $exam->settings->get('cutoff', 0).'%',__('quiz_percentage_instruction')),
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
     * @param $exam
     * @return array
     */
    public function sessionResults($session, $exam)
    {
        $questions = collect($session->questions);
        $answered = $questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->count();
        $correct = $questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->where('pivot.is_correct', '=', true)->count();
        $wrong = $questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->where('pivot.is_correct', '=', false)->count();
        $answered_time = $questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->sum('pivot.time_taken');
        $correctMarks = $questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->sum('pivot.marks_earned');
        $negativeMarks = $questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->sum('pivot.marks_deducted');
        $percentage = $exam->total_marks != 0 ? round(($correctMarks - $negativeMarks) * (100/$exam->total_marks), 2) : 0;
        $section_cutoff_cleared = true;
        if($exam->settings->get('enable_section_cutoff', false)) {
            $failed_count = 0;
            foreach ($session->sections as $section) {
                $results = json_decode($section->pivot->results, true);
                if($results['pass_or_fail'] == 'Failed') {
                    $failed_count++;
                }
            }
            $pass_or_fail = $failed_count > 0 ? 'Failed' : 'Passed';
            $section_cutoff_cleared = $failed_count > 0 ? false : true;
        } else {
            $pass_or_fail = $percentage >= $exam->settings->get('cutoff') ? 'Passed' : 'Failed';
        }
        $agent = new Agent();
        return [
            'score' => $correctMarks - $negativeMarks,
            'marks_earned' => $correctMarks,
            'marks_deducted' => $negativeMarks,
            'percentage' =>  $percentage,
            'cutoff' => $exam->settings->get('cutoff'),
            'section_cutoff' => $exam->settings->get('enable_section_cutoff'),
            'section_cutoff_cleared' => $section_cutoff_cleared,
            'pass_or_fail' => $pass_or_fail,
            'speed' => round(calculateSpeedPerHour($answered, $session->total_time_taken)),//que/hr
            'accuracy' => round(calculateAccuracy($correct, $answered), 2), //%
            'total_questions' => $exam->total_questions,
            'total_duration' => $exam->total_duration / 60,
            'total_marks' => $exam->total_marks,
            'answered_questions' => $answered,
            'unanswered_questions' => $exam->total_questions - $answered,
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
     * Get session section result object
     *
     * @param $session
     * @param $exam
     * @param $section
     * @return array
     */
    public function sectionResults($session, $exam, $section)
    {
        $questions = $session->questions()->where('exam_section_id', $section->id)->get();
        $answered = $questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->count();
        $correct = $questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->where('pivot.is_correct', '=', true)->count();
        $wrong = $questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->where('pivot.is_correct', '=', false)->count();
        $answered_time = $questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->sum('pivot.time_taken');
        $correctMarks = $questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->sum('pivot.marks_earned');
        $negativeMarks = $questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->sum('pivot.marks_deducted');
        $percentage = $section->total_marks != 0 ? round(($correctMarks - $negativeMarks) * (100/$section->total_marks), 2) : 0;
        return [
            'score' => $correctMarks - $negativeMarks,
            'marks_earned' => $correctMarks,
            'marks_deducted' => $negativeMarks,
            'percentage' =>  $percentage,
            'cutoff' => $exam->settings->get('enable_section_cutoff', false) ? $section->section_cutoff : 'No',
            'pass_or_fail' => $exam->settings->get('enable_section_cutoff', false) ? $percentage >= $section->section_cutoff ? 'Passed' : 'Failed' : 'N/A',
            'speed' => round(calculateSpeedPerHour($answered, $section->pivot->total_time_taken)),//que/hr
            'accuracy' => round(calculateAccuracy($correct, $answered), 2), //%
            'total_questions' => $section->total_questions,
            'total_duration' => $section->total_duration / 60,
            'total_marks' => $section->total_marks,
            'answered_questions' => $answered,
            'unanswered_questions' => $section->total_questions - $answered,
            'correct_answered_questions' => $correct,
            'wrong_answered_questions' => $wrong,
            'total_time_taken' => formattedSeconds($section->pivot->total_time_taken),
            'time_taken_for_answered' => formattedSeconds($answered_time),
            'time_taken_for_other' => formattedSeconds($section->pivot->total_time_taken - $answered_time),
            'time_taken_for_correct_answered' => formattedSeconds($questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->where('pivot.is_correct', '=', true)->sum('pivot.time_taken')),
            'time_taken_for_wrong_answered' => formattedSeconds($questions->whereIn('pivot.status', ['answered', 'answered_mark_for_review'])->where('pivot.is_correct', '=', false)->sum('pivot.time_taken')),
        ];
    }

    /**
     * Get exam progress links
     *
     * @param $slug
     * @param $session
     * @param $active
     * @return array[]
     */
    public function getExamProgressLinks($slug, $session, $active)
    {
        return [
            [
                'key' => 'analysis',
                'title' => __('Analysis'),
                'url' => route('exam_results', ['exam' => $slug, 'session' => $session]),
                'active' => $active == 'exam_results'
            ],
            [
                'key' => 'solutions',
                'title' => __('Solutions'),
                'url' => route('exam_solutions', ['exam' => $slug, 'session' => $session]),
                'active' => $active == 'exam_solutions'
            ],
            [
                'key' => 'leaderboard',
                'title' => __('Top Scorers'),
                'url' => route('exam_leaderboard', ['exam' => $slug, 'session' => $session]),
                'active' => $active == 'exam_leaderboard'
            ]
        ];
    }
}
