<?php

namespace App\Settings;

use Spatie\LaravelSettings\Settings;

class QuizPrizeSettings extends Settings
{
    public int $rank1;

    public int $rank2;

    public int $rank3;
    public int $rank4;
    public int $rank5;
    public int $rank6;
    public int $rank7;
    public int $rank8;
    public int $rank9;
    public int $rank10;

    public int $rankUpto20; // eg. 4,5,6,7,8,9,10

    public static function group(): string
    {
        return 'quiz-prize';
    }
}
