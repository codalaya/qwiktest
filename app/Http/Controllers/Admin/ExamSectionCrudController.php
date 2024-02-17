<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\StoreExamSectionRequest;
use App\Http\Requests\Admin\UpdateExamSectionRequest;
use App\Models\Exam;
use App\Models\ExamSection;
use App\Repositories\ExamRepository;
use App\Transformers\Admin\ExamSectionTransformer;
use Inertia\Inertia;

class ExamSectionCrudController extends Controller
{
    private ExamRepository $repository;

    public function __construct(ExamRepository $repository)
    {
        $this->repository = $repository;
    }

    /**
     * List all exam sections
     *
     * @param $exam
     * @return \Inertia\Response
     */
    public function index($exam)
    {
        $test = Exam::select(['id', 'title', 'settings'])->with(['examSections' => function($query) {
            $query->with('section:id,name')->orderBy('section_order');
        }])->findOrFail($exam);

        return Inertia::render('Admin/Exam/Sections', [
            'editFlag' => true,
            'exam' => $test->only(['id', 'title', 'settings']),
            'steps' => $this->repository->getSteps($exam, 'sections'),
            'sections' => function () use ($test) {
                return fractal($test->examSections, new ExamSectionTransformer())->toArray()['data'];
            },
        ]);
    }

    /**
     * Store an exam section
     *
     * @param StoreExamSectionRequest $request
     * @param $exam
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(StoreExamSectionRequest $request, Exam $exam)
    {
        $examSection = new ExamSection();
        $examSection->exam_id = $exam->id;
        $examSection->name = $request->name;
        $examSection->section_id = $request->section_id;
        $examSection->correct_marks = $request->correct_marks;
        $examSection->negative_marking_type = $request->negative_marking_type;
        $examSection->negative_marks = $request->negative_marks;
        $examSection->section_cutoff = $request->section_cutoff;
        $examSection->section_order = $request->section_order;

        if($exam->settings->get('auto_duration', true)) {
            $examSection->total_duration = $examSection->questions()->sum('default_time');
        } else {
            $examSection->total_duration = $request->total_duration * 60;
        }

        if($exam->settings->get('auto_grading', true)) {
            $examSection->total_marks = $examSection->questions()->sum('default_marks');
        } else {
            $examSection->total_marks = $examSection->questions()->count() * $request->correct_marks;
        }
        $examSection->save();

        $exam->updateMeta();

        return redirect()->back()
            ->with('successMessage', 'Exam Section was successfully added!');
    }

    /**
     * Edit a section
     *
     * @param $exam
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function edit($exam, $id)
    {
        $section = ExamSection::with(['section:id,name'])->findOrFail($id);
        return response()->json($section, 200);
    }

    /**
     * Update a section
     *
     * @param UpdateExamSectionRequest $request
     * @param Exam $exam
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(UpdateExamSectionRequest $request, Exam $exam, $id)
    {
        $examSection = ExamSection::findOrFail($id);
        $examSection->name = $request->name;
        $examSection->section_id = $request->section_id;
        $examSection->correct_marks = $request->correct_marks;
        $examSection->negative_marking_type = $request->negative_marking_type;
        $examSection->negative_marks = $request->negative_marks;
        $examSection->section_cutoff = $request->section_cutoff;
        $examSection->section_order = $request->section_order;

        if($exam->settings->get('auto_duration', true)) {
            $examSection->total_duration = $examSection->questions()->sum('default_time');
        } else {
            $examSection->total_duration = $request->total_duration * 60;
        }

        if($exam->settings->get('auto_grading', true)) {
            $examSection->total_marks = $examSection->questions()->sum('default_marks');
        } else {
            $examSection->total_marks = $examSection->questions()->count() * $request->correct_marks;
        }

        $examSection->update();
        $examSection->updateMeta();
        $exam->updateMeta();

        return redirect()->back()
            ->with('successMessage', 'Exam Section was successfully updated!');
    }

    /**
     * Delete a section
     *
     * @param Exam $exam
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy(Exam $exam, $id)
    {
        try {
            $examSection = ExamSection::find($id);
            if(!$examSection->canSecureDelete('examSessions')) {
                return redirect()->back()->with('errorMessage', 'Unable to delete exam section. Exam sessions exist and deleting section will disrupt analytics!');
            }
            $examSection->questions()->detach();

            $exam->updateMeta();
        }
        catch (\Illuminate\Database\QueryException $e){
            return redirect()->route('exams.sections.index', ['exam' => $exam])
                ->with('errorMessage', 'Unable to Delete Section . Remove all associations and Try again!');
        }
        return redirect()->route('exams.sections.index', ['exam' => $exam])
            ->with('successMessage', 'Section was successfully deleted!');
    }
}
