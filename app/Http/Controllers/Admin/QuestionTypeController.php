<?php


namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\QuestionType;
use App\Transformers\Admin\QuestionTypeTransformer;
use Illuminate\Http\Request;
use Inertia\Inertia;

class QuestionTypeController extends Controller
{
    public function __construct()
    {
        $this->middleware(['role:admin|instructor']);
    }

    /**
     * List all question types
     *
     * @return \Inertia\Response
     */
    public function index()
    {
        return Inertia::render('Admin/QuestionTypes', [
            'questionTypes' => fractal(QuestionType::active()
                ->paginate(request()->perPage != null ? request()->perPage : 10),
            new QuestionTypeTransformer())->toArray()
        ]);
    }
}
