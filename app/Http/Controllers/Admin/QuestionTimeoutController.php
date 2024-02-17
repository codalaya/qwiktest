<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;

class QuestionTimeoutController extends Controller
{
    public function __invoke(Request $request) {
        return inertia('Admin/QuestionTimeout');
    }

    public function store(Request $request) {

    }
}
