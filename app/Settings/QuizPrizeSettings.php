<?php

namespace App\Settings;

use Spatie\LaravelSettings\Settings;

class QuizPrizeSettings extends Settings
{
    public int $rankOne;

    public int $rankTwo;

    public int $rankThree;

    public int $above10Rank; // eg. 4,5,6,7,8,9,10

    public static function group(): string
    {
        return 'quiz-prize';
    }
}
