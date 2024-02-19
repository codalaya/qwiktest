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
            ->selectRaw('sum(marks_earned) as total_marks, user_id')
            ->orderBy('total_marks')
            ->take(10)
            ->get();

        $users = User::whereIn('id', $leaderboard->pluck('user_id'))->get();

        $prizeSettins = resolve(QuizPrizeSettings::class);

        if ($users->count() > 0) {
            $user = $users->first(fn ($item) => $item->id === $leaderboard[0]->user_id);
            $user->deposit($prizeSettins->rankOne);
        }

        if ($users->count() > 1) {
            $user = $users->first(fn ($item) => $item->id === $leaderboard[1]->user_id);
            $user->deposit($prizeSettins->rankTwo);
        }
        if ($users->count() > 2) {
            $user = $users->first(fn ($item) => $item->id === $leaderboard[2]->user_id);
            $user->deposit($prizeSettins->rankThree);
        }

        for ($i = 3; $i < $users->count(); $i++) {
            $user = $users->first(fn ($item) => $item->id === $leaderboard[$i]->user_id);
            $users[$i]->deposit($prizeSettins->above10Rank);
        }
    }
}
