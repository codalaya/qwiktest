<?php

namespace App\Console\Commands;

use App\Models\ExamSession;
use App\Models\Question;
use App\Models\Quiz;
use App\Models\QuizSession;
use App\Models\User;
use App\Services\CalculateCurrentRankingService;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Schema;

class TestCommand extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'tc';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command description';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }


    public function handle()
    {
        dd(User::all()->pluck('email'));
        // $co = collect(['rame', 'esh', 'kum', 'ar']);
        // // dd($co->search(fn ($item) => $item === 'ar'));

        $latestSessionId = QuizSession::latest()->first();
        dd($latestSessionId->results->score);
        // $quizId = Quiz::latest()->first()->id;
        // $userId = User::firstWhere('email', 'ritik@gmail.com')->id;

        // $ranking = resolve(CalculateCurrentRankingService::class)->calculate($userId, $latestSessionId, $quizId);
        // dd($ranking);

    }

    protected function getCheckout()
    {
        $session = QuizSession::latest()->first();
        $userId = 2;
        $quizId = 1;
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
        $currentScore = $leaderboard->first(fn ($item) => $item->user_id == $userId);
        dd($currentScore->high_score, $rank);
    }

    public function getTableColumns(string $modal)
    {
        return (Schema::getColumnListing(resolve($modal)->getTable()));
    }

    public function removeNearcraft()
    {
        $regex = '/\/\*\*\s+\*\s+File\s+name:(.*)\s+\*\s+Last\s+modified:\s+(.*)\s+\*\s+Author:\s+NearCraft\s+-\s+https:\/\/codecanyon\.net\/user\/nearcraft\s+\*\s+Copyright\s+\(c\)\s+(.*)\s+\*\//';
        $count = 0;
        foreach (['app', 'resources/css', 'config', 'routes'] as $folder) {
            $files = File::allFiles($folder);

            foreach ($files as $file) {
                $path = "{$folder}/{$file->getRelativePathname()}";
                // dump($path, FacadesFile::exists($path));
                $content = $file->getContents();

                if (Str::of($content)->match($regex)) {
                    $content = Str::of($content)->replaceMatches($regex, '');
                    File::put($path, (string)$content);
                }
            }
        }

        dump($count);
    }
}
