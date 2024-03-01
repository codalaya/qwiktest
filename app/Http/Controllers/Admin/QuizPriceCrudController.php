<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Settings\QuizPrizeSettings;
use Illuminate\Http\Request;

class QuizPriceCrudController extends Controller
{
    public function showForm()
    {
        $setting = resolve(QuizPrizeSettings::class);

        return inertia('Admin/QuizRewardSetting', [
            'rank1' => $setting->rank1 ?? 0,
            'rank2' => $setting->rank2 ?? 0,
            'rank3' => $setting->rank3 ?? 0,
            'rank4' => $setting->rank4 ?? 0,
            'rank5' => $setting->rank5 ?? 0,
            'rank6' => $setting->rank6 ?? 0,
            'rank7' => $setting->rank7 ?? 0,
            'rank8' => $setting->rank8 ?? 0,
            'rank9' => $setting->rank9 ?? 0,
            'rank10' => $setting->rank10 ?? 0,
            'rankUpto20' => $setting->rankUpto20 ?? 0,

        ]);
    }

    public function updateForm(Request $request, QuizPrizeSettings $quizPrizeSettings)
    {
        $validators = ['required', 'numeric', 'integer'];

        $request->validate([
            'rank1' => $validators,
            'rank2' => $validators,
            'rank3' => $validators,
            'rank4' => $validators,
            'rank5' => $validators,
            'rank6' => $validators,
            'rank7' => $validators,
            'rank8' => $validators,
            'rank9' => $validators,
            'rank10' => $validators,
            'rankUpto20' => $validators,
        ]);

        $quizPrizeSettings->rank1 = $request->rank1;
        $quizPrizeSettings->rank2 = $request->rank2;
        $quizPrizeSettings->rank3 = $request->rank3;
        $quizPrizeSettings->rank4 = $request->rank4;
        $quizPrizeSettings->rank5 = $request->rank5;
        $quizPrizeSettings->rank6 = $request->rank6;
        $quizPrizeSettings->rank7 = $request->rank7;
        $quizPrizeSettings->rank8 = $request->rank8;
        $quizPrizeSettings->rank9 = $request->rank9;
        $quizPrizeSettings->rank10 = $request->rank10;
        $quizPrizeSettings->rankUpto20 = $request->rankUpto20;
        $quizPrizeSettings->save();

        return redirect()->back();
    }
}
