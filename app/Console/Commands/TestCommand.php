<?php

namespace App\Console\Commands;

use App\Models\Category;
use App\Models\ExamSession;
use App\Models\Payment;
use App\Models\Plan;
use App\Models\Question;
use App\Models\Quiz;
use App\Models\QuizSchedule;
use App\Models\QuizSession;
use App\Models\Skill;
use App\Models\SubCategory;
use App\Models\SubCategoryType;
use App\Models\Subscription;
use App\Models\Tag;
use App\Models\User;
use App\Models\UserGroup;
use App\Services\CalculateCurrentRankingService;
use App\Settings\LocalizationSettings;
use App\Settings\QuizPrizeSettings;
use App\Settings\RazorpaySettings;
use App\Settings\SiteSettings;
use Bavix\Wallet\Models\Transaction;
use Illuminate\Console\Command;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Str;
use Illuminate\Support\Facades\File;
use Illuminate\Support\Facades\Schema;
use Laravel\Fortify\Contracts\LogoutResponse;
use Spatie\LaravelSettings\Models\SettingsProperty;

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
        $d = DB::table('quiz_session_questions')->first();
        // $q = QuizSession::find(143);
        // dd($q->results->pass_or_fail);

        $d =   QuizSession::first();
        dd($d->toArray());
    }


    public function something()
    {

        $dp  = User::where('email', 'ritik@gmail.com')->first();
        dd($dp->toArray());
        // dd($user->subscriptions()->latest()->first()->remained_game_play);
        // dd(QuizSession::where('code', '24e1f7f8-14e1-45a8-9ea9-59fd3f714fc3')->first());
        // $usergroups = UserGroup::all();
        // $user->userGroups()->sync([2]);
        // dd($user->userGroups->toArray());
        // $subscription = Subscription::all();
        // dump($subscription->toArray());

        // $subcategory = SubCategory::all();
        // dd($subcategory->toArray());
        // $subscription = $user->subscriptions()->latest()->first();
        // dump($subscription->remained_game_play);
        // $subscription->update([
        //     'remained_game_play' => DB::raw('GREATEST(remained_game_play, 10)')
        // ]);

        $this->eraseQuizPlay();
    }

    public function eraseQuizPlay()
    {
        return DB::table('quiz_session_questions')->delete();
    }

    public function getS()
    {
        return resolve(QuizPrizeSettings::class);
    }

    public function getRank()
    {
        $sessionId = QuizSession::latest()->first()->id;
        $user = User::firstWhere('email', 'ritik@gmail.com');
        $quizId = 1;
        $value = DB::table('quiz_session_questions')
            ->where('quiz_id', $quizId)
            ->groupBy('user_id')
            ->selectRaw('sum(marks_earned) as total_marks, user_id')
            ->orderBy('total_marks')
            ->get();

        dd($value);
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
