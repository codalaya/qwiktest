<?php

namespace App\Services;

use App\Models\QuizSession;
use App\Models\User;
use App\Settings\QuizPrizeSettings;
use Illuminate\Support\Facades\DB;

class CalculateCurrentRankingService
{
    public function calculateRank($userId, QuizSession $session)
    {
        return DB::table('quiz_session_questions')
            ->where('quiz_id', $session->quiz_id)
            ->groupBy('user_id')
            ->selectRaw('sum(marks_earned) as total_marks, user_id')
            ->orderBy('total_marks')
            ->get()->search(fn ($item) => $item->user_id === $userId) + 1;
    }

    public function calculateScore($userId, QuizSession $session)
    {
        return DB::table('quiz_session_questions')
            ->where('quiz_session_id', $session->id)
            ->sum('marks_earned');
    }

    public function giveReward(QuizSession $session)
    {
        $leaderboard = DB::table('quiz_session_questions')
            ->where('quiz_id', $session->quiz_id)
            ->groupBy('user_id')
            ->selectRaw('sum(marks_earned) as total_marks, user_id, quiz_session_id')
            ->orderBy('total_marks')
            ->take(20)
            ->get();

        $quizSessions = QuizSession::whereIn('id', $leaderboard->pluck('quiz_sesson_id'))->get();
        $users = User::whereIn('id', $leaderboard->pluck('user_id'))->get();

        $prizeSettins = resolve(QuizPrizeSettings::class);

        for ($i = 0; $i < 10; $i++) {
            if ($users->count() > $i) {
                $user = $users->first(fn ($item) => $item->id === $leaderboard[$i]->user_id);
                $session = $quizSessions->first(fn ($item) => $item->user_id === $leaderboard[$i]->user_id);
                if ($session->results['pass_or_fail'] === 'Passed') {
                    $field = 'rank' . ($i + 1);
                    $user->deposit($prizeSettins->$field);
                }
            }
        }

        for ($i = 10; $i < $users->count(); $i++) {
            $user = $users->first(fn ($item) => $item->id === $leaderboard[$i]->user_id);
            $session = $quizSessions->first(fn ($item) => $item->user_id === $leaderboard[$i]->user_id);
            if ($session->results['pass_or_fail'] === 'Passed') {
                $user->deposit($prizeSettins->rankUpto20);
            }
        }
    }
}
