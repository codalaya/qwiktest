<?php


namespace App\Console\Commands;

use App\Models\ExamSchedule;
use App\Models\QuizSchedule;
use App\Settings\LocalizationSettings;
use Carbon\Carbon;
use Illuminate\Console\Command;

class ExpireSchedules extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'expire:schedules';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command to expire quiz/exam schedules after passing end date time';

    /**
     * Create a new command instance.
     *
     * @return void
     */
    public function __construct()
    {
        parent::__construct();
    }

    /**
     * Execute the console command.
     *
     * @return int
     */
    public function handle()
    {
        $localization = app(LocalizationSettings::class);
        $now = Carbon::now()->timezone($localization->default_timezone);

        // fetch all the quiz schedules that passed end date
        $quizSchedules = QuizSchedule::where('end_date', '<=', $now->toDateString())
            ->where('end_time', '<=', $now->toTimeString())
            ->where('status', '=', 'active')->get();

        //set status as expired
        foreach ($quizSchedules as $schedule) {
            $schedule->status = 'expired';
            $schedule->update();
        }

        // fetch all the exam schedules that passed end date
        $examSchedules = ExamSchedule::where('end_date', '<=', $now->toDateString())
            ->where('end_time', '<=', $now->toTimeString())
            ->where('status', '=', 'active')->get();

        //set status as expired
        foreach ($examSchedules as $schedule) {
            $schedule->status = 'expired';
            $schedule->update();
        }
        return 1;
    }
}
