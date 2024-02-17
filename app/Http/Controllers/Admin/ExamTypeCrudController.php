<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Filters\ExamTypeFilters;
use App\Http\Requests\Admin\StoreExamTypeRequest;
use App\Http\Requests\Admin\UpdateExamTypeRequest;
use App\Models\ExamType;
use App\Transformers\Admin\ExamTypeTransformer;
use Inertia\Inertia;

class ExamTypeCrudController extends Controller
{
    public function __construct()
    {
        $this->middleware(['role:admin|instructor'])->except('search');
    }

    /**
     * List all Exam Types
     *
     * @param ExamTypeFilters $filters
     * @return \Inertia\Response
     */
    public function index(ExamTypeFilters $filters)
    {
        return Inertia::render('Admin/ExamTypes', [
            'examTypes' => function () use($filters) {
                return fractal(ExamType::filter($filters)
                    ->paginate(request()->perPage != null ? request()->perPage : 10),
                    new ExamTypeTransformer())->toArray();
            },
        ]);
    }

    /**
     * Store a ExamType
     *
     * @param StoreExamTypeRequest $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(StoreExamTypeRequest $request)
    {
        ExamType::create($request->validated());
        return redirect()->back()->with('successMessage', 'Exam Type was successfully added!');
    }

    /**
     * Show a ExamType
     *
     * @param $id
     * @return array
     */
    public function show($id)
    {
        return fractal(ExamType::find($id), new ExamTypeTransformer())->toArray();
    }

    /**
     * Edit a ExamType
     *
     * @param $id
     * @return ExamType|ExamType[]|\Illuminate\Database\Eloquent\Collection|\Illuminate\Database\Eloquent\Model|null
     */
    public function edit($id)
    {
        return ExamType::find($id);
    }

    /**
     * Update a ExamType
     *
     * @param UpdateExamTypeRequest $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(UpdateExamTypeRequest $request, $id)
    {
        $examType = ExamType::find($id);
        $examType->update($request->validated());
        return redirect()->back()->with('successMessage', 'Exam Type was successfully updated!');
    }
    /**
     * Delete a ExamType
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy($id)
    {
        try {
            $examType = ExamType::find($id);

            if(!$examType->canSecureDelete('exams')) {
                return redirect()->back()->with('errorMessage', 'Unable to Delete Exam Type . Remove all associations and Try again!');
            }

            $examType->secureDelete('exams');
        }
        catch (\Illuminate\Database\QueryException $e){
            return redirect()->back()->with('errorMessage', 'Unable to Delete Exam Type . Remove all associations and Try again!');
        }

        return redirect()->back()->with('successMessage', 'Exam Type was successfully deleted!');
    }
}
