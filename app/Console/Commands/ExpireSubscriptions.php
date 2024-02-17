<?php

namespace App\Console\Commands;

use App\Models\Subscription;
use App\Settings\LocalizationSettings;
use Carbon\Carbon;
use Illuminate\Console\Command;

class ExpireSubscriptions extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'expire:subscriptions';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Command to expire expire schedules after passing end date time';

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

        // fetch all the subscriptions that passed end date
        $subscriptions = Subscription::where('ends_at', '<=', $now->toDateTimeString())
            ->where('status', '=', 'active')->get();

        //set status as expired
        foreach ($subscriptions as $subscription) {
            $subscription->status = 'expired';
            $subscription->update();
        }
        return 1;
    }
}
