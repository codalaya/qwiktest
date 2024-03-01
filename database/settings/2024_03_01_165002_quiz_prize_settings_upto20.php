<?php

use Spatie\LaravelSettings\Migrations\SettingsMigration;

class QuizPrizeSettingsUpto20 extends SettingsMigration
{
    public function up(): void
    {
        $this->migrator->delete('quiz-prize.rankOne');
        $this->migrator->delete('quiz-prize.rankTwo',);
        $this->migrator->delete('quiz-prize.rankThree',);
        $this->migrator->delete('quiz-prize.above10Rank');

        $this->migrator->add('quiz-prize.rank1', 100);
        $this->migrator->add('quiz-prize.rank2', 90);
        $this->migrator->add('quiz-prize.rank3', 80);
        $this->migrator->add('quiz-prize.rank4', 70);
        $this->migrator->add('quiz-prize.rank5', 60);
        $this->migrator->add('quiz-prize.rank6', 50);
        $this->migrator->add('quiz-prize.rank7', 40);
        $this->migrator->add('quiz-prize.rank8', 30);
        $this->migrator->add('quiz-prize.rank9', 20);
        $this->migrator->add('quiz-prize.rank10', 10);
        $this->migrator->add('quiz-prize.rankUpto20', 5);
    }

    public function down(): void
    {
        $this->migrator->delete('quiz-prize.rank1');
        $this->migrator->delete('quiz-prize.rank2');
        $this->migrator->delete('quiz-prize.rank3');
        $this->migrator->delete('quiz-prize.rank4');
        $this->migrator->delete('quiz-prize.rank5');
        $this->migrator->delete('quiz-prize.rank6');
        $this->migrator->delete('quiz-prize.rank7');
        $this->migrator->delete('quiz-prize.rank8');
        $this->migrator->delete('quiz-prize.rank9');
        $this->migrator->delete('quiz-prize.rank10');
        $this->migrator->delete('quiz-prize.rankUpto20');

        $this->migrator->add('quiz-prize.rankOne', 100);
        $this->migrator->add('quiz-prize.rankTwo', 75);
        $this->migrator->add('quiz-prize.rankThree', 50);
        $this->migrator->add('quiz-prize.above10Rank', 10);
    }
}
