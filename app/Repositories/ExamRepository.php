<?php

namespace App\Repositories;

use Illuminate\Support\Facades\DB;

class ExamRepository
{
    /**
     * Exam Configuration Steps
     *
     * @param null $eId
     * @param string $active
     * @return array[]
     */
    public function getSteps($eId = null, $active = 'details')
    {
        return [
            [
                'step' => 1,
                'key' => 'details',
                'title' => __('Details'),
                'status' => $active == 'details' ? 'active' : 'inactive',
                'url' => $eId != null ? route('exams.edit', ['exam' => $eId]) : ''
            ],
            [
                'step' => 2,
                'key' => 'settings',
                'title' => __('Settings'),
                'status' => $active == 'settings' ? 'active' : 'inactive',
                'url' => $eId != null ? route('exams.settings', ['exam' => $eId]) : ''
            ],
            [
                'step' => 3,
                'key' => 'sections',
                'title' => __('Sections'),
                'status' => $active == 'sections' ? 'active' : 'inactive',
                'url' => $eId != null ? route('exams.sections.index', ['exam' => $eId]) : ''
            ],
            [
                'step' => 4,
                'key' => 'questions',
                'title' => __('Questions'),
                'status' => $active == 'questions' ? 'active' : 'inactive',
                'url' => $eId != null ? route('exams.questions', ['exam' => $eId]) : ''
            ],
            [
                'step' => 5,
                'key' => 'schedules',
                'title' => __('Schedules'),
                'status' => $active == 'schedules' ? 'active' : 'inactive',
                'url' => $eId != null ? route('exams.schedules.index', ['exam' => $eId]) : ''
            ]
        ];
    }

    /**
     * Exam Overall Stats Query
     *
     * @param $examId
     * @param $scheduleId
     * @return \Illuminate\Support\Collection
     */
    public function getExamSessionStats($examId, $scheduleId)
    {
        $key = $scheduleId ? 'exam_schedule_id' : 'exam_id';
        $value = $scheduleId ? $scheduleId : $examId;
        return DB::table('exam_sessions')
            ->where($key, '=', $value)
            ->selectRaw("count(case when status = 'completed' then 1 end) as total_attempts")
            ->selectRaw("count(case when JSON_EXTRACT(`results`, \"$.pass_or_fail\") = 'Passed' then 1 end) as pass_count")
            ->selectRaw("count(case when JSON_EXTRACT(`results`, \"$.pass_or_fail\") = 'Failed' then 1 end) as failed_count")
            ->selectRaw("count(DISTINCT(user_id)) as unique_test_takers")
            ->selectRaw("avg(total_time_taken) as avg_time")
            ->selectRaw("avg(JSON_EXTRACT(`results`, \"$.score\")) as avg_score")
            ->selectRaw("avg(JSON_EXTRACT(`results`, \"$.percentage\")) as avg_percentage")
            ->selectRaw("avg(JSON_EXTRACT(`results`, \"$.accuracy\")) as avg_accuracy")
            ->selectRaw("avg(JSON_EXTRACT(`results`, \"$.speed\")) as avg_speed")
            ->selectRaw("max(CAST(JSON_EXTRACT(`results`, \"$.score\") AS DECIMAL(10,6))) as high_score")
            ->selectRaw("min(CAST(JSON_EXTRACT(`results`, \"$.score\") AS DECIMAL(10,6))) as low_score")
            ->selectRaw("sum(JSON_EXTRACT(`results`, \"$.answered_questions\")) as sum_answered")
            ->selectRaw("sum(JSON_EXTRACT(`results`, \"$.total_questions\")) as sum_questions")
            ->get();
    }
}
