<?php

use Spatie\LaravelSettings\Migrations\SettingsMigration;

class QuizPrizeSettings extends SettingsMigration
{
    public function up(): void
    {
        $this->migrator->add('quiz-prize.rankOne', 100);
        $this->migrator->add('quiz-prize.rankTwo', 75);
        $this->migrator->add('quiz-prize.rankThree', 50);
        $this->migrator->add('quiz-prize.above10Rank', 10);
    }
}
