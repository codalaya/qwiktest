<?php

namespace App\Services;

use App\Models\QuizSession;

class CalculateCurrentRankingService
{
    public function calculate($userId, $sessionId, $quizId)
    {
        $session = QuizSession::where('code', $sessionId)->firstOrFail();

        $key = $session->quiz_schedule_id ? 'quiz_schedule_id' : 'quiz_id';
        $value = $session->quiz_schedule_id ? $session->quiz_schedule_id : $quizId;

        $leaderboard =  QuizSession::select('user_id', 'quiz_id')
            ->with('user:id,first_name,last_name')
            ->selectRaw("max(CAST(JSON_EXTRACT(`results`, \"$.score\") AS DECIMAL(10,6))) as high_score")
            ->selectRaw("max(CAST(JSON_EXTRACT(`results`, \"$.percentage\") AS DECIMAL(10,6))) as high_percentage")
            ->where($key, $value)
            ->groupBy('user_id', 'quiz_id')
            ->orderBy('high_score', 'desc')
            ->get();
        $rank = $leaderboard->search(fn ($item) => $item->user_id === $userId) + 1;
        $currentScore = $leaderboard->first(fn ($item) => $item->user_id === $userId)->high_score;

        return [
            'rank' => $rank,
            'score' => $currentScore
        ];
    }
}
