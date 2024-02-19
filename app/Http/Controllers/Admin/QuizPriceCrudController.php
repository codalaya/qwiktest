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
            'rankOne' => $setting->rankOne ?? 0,
            'rankTwo' => $setting->rankTwo ?? 0,
            'rankThree'  => $setting->rankThree ?? 0,
            'above10Rank' => $setting->above10Rank,
        ]);
    }

    public function updateForm(Request $request, QuizPrizeSettings $quizPrizeSettings)
    {
        $request->validate([
            'rankOne' => ['required', 'numeric', 'integer'],
            'rankTwo' => ['required', 'numeric', 'integer'],
            'rankThree' => ['required', 'numeric', 'integer'],
            'above10Rank' => ['required', 'numeric', 'integer'],
        ]);

        $quizPrizeSettings->rankOne = $request->rankOne;
        $quizPrizeSettings->rankTwo = $request->rankTwo;
        $quizPrizeSettings->rankThree = $request->rankThree;
        $quizPrizeSettings->above10Rank = $request->above10Rank;
        $quizPrizeSettings->save();

        return redirect()->back();
    }
}
