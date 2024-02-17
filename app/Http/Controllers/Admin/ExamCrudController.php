<?php

namespace App\Http\Controllers\Admin;

use App\Filters\ExamFilters;
use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\StoreExamRequest;
use App\Http\Requests\Admin\UpdateExamRequest;
use App\Http\Requests\Admin\UpdateExamSettingsRequest;
use App\Models\Exam;
use App\Models\ExamType;
use App\Models\SubCategory;
use App\Repositories\ExamRepository;
use App\Transformers\Admin\ExamSearchTransformer;
use App\Transformers\Admin\ExamTransformer;
use App\Transformers\Admin\SubCategorySearchTransformer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Inertia\Inertia;

class ExamCrudController extends Controller
{
    private ExamRepository $repository;

    public function __construct(ExamRepository $repository)
    {
        $this->middleware(['role:admin|instructor'])->except('search');
        $this->repository = $repository;
    }

    /**
     * List all exams
     *
     * @param ExamFilters $filters
     * @return \Inertia\Response
     */
    public function index(ExamFilters $filters)
    {
        return Inertia::render('Admin/Exams', [
            'examTypes' => ExamType::select(['id as value', 'name as text'])->active()->get(),
            'exams' => function () use($filters) {
                return fractal(Exam::filter($filters)->with(['subCategory:id,name', 'examType:id,name'])
                    ->withCount(['examSections'])
                    ->orderBy('id', 'desc')
                    ->paginate(request()->perPage != null ? request()->perPage : 10),
                    new ExamTransformer())->toArray();
            }
        ]);
    }

    /**
     * Search exams api endpoint
     *
     * @param Request $request
     * @param ExamFilters $filters
     * @return \Illuminate\Http\JsonResponse
     */
    public function search(Request $request, ExamFilters $filters)
    {
        $query = $request->get('query');
        return response()->json([
            'exams' => fractal(Exam::select(['id', 'title'])->filter($filters)
                ->where('title', 'like', '%'.$query.'%')->published()->limit(20)
                ->get(), new ExamSearchTransformer())
                ->toArray()['data']
        ]);
    }

    /**
     * Create an exam
     *
     * @return \Inertia\Response
     */
    public function create()
    {
        return Inertia::render('Admin/Exam/Details', [
            'steps' => $this->repository->getSteps(),
            'examTypes' => ExamType::select(['id', 'name'])->get(),
            'initialSubCategories' => fractal(SubCategory::select(['id', 'name', 'category_id'])->latest()->take(10)->get(),
                new SubCategorySearchTransformer())->toArray()['data']
        ]);
    }

    /**
     * Store an exam
     *
     * @param StoreExamRequest $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(StoreExamRequest $request)
    {
        $exam = Exam::create($request->validated());
        return redirect()->route('exams.settings', ['exam' => $exam->id])
            ->with('successMessage', 'Exam was successfully added!');
    }

    /**
     * Show an exam
     *
     * @param $id
     * @return array
     */
    public function show($id)
    {
        $exam = Exam::find($id);
        return fractal($exam, new ExamTransformer())->toArray();
    }

    /**
     * Edit an exam
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse|\Inertia\Response
     */
    public function edit($id)
    {
        $exam = Exam::findOrFail($id);

        return Inertia::render('Admin/Exam/Details', [
            'steps' => $this->repository->getSteps($exam->id, 'details'),
            'editFlag' => true,
            'exam' => $exam,
            'examId' => $exam->id,
            'examTypes' => ExamType::select(['id', 'name'])->get(),
            'initialSubCategories' => fractal(SubCategory::select(['id', 'name', 'category_id'])
                ->with('category:id,name')
                ->where('id', $exam->sub_category_id)
                ->get(), new SubCategorySearchTransformer())
                ->toArray()['data'],
        ]);
    }

    /**
     * Update an exam
     *
     * @param UpdateExamRequest $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(UpdateExamRequest $request, $id)
    {
        $exam = Exam::find($id);
        $exam->update($request->validated());

        return redirect()->route('exams.settings', ['exam' => $exam->id])->with('successMessage', 'Exam was successfully updated!');
    }

    /**
     * Exam settings page
     *
     * @param $id
     * @return \Inertia\Response
     */
    public function settings($id)
    {
        $exam = Exam::findOrFail($id);
        return Inertia::render('Admin/Exam/Settings', [
            'exam' => $exam,
            'steps' => $this->repository->getSteps($exam->id, 'settings'),
            'editFlag' => true,
            'settings' => [
                'auto_duration' => $exam->settings->get('auto_duration', true),
                'auto_grading' => $exam->settings->get('auto_grading', true),
                'cutoff' => $exam->settings->get('cutoff', 60),
                'enable_section_cutoff' => $exam->settings->get('enable_section_cutoff', false),
                'enable_negative_marking' => $exam->settings->get('enable_negative_marking', false),
                'restrict_attempts' =>  $exam->settings->get('restrict_attempts', false),
                'no_of_attempts' => $exam->settings->get('no_of_attempts', null),
                'disable_section_navigation' => $exam->settings->get('disable_section_navigation', false),
                'disable_question_navigation' => $exam->settings->get('disable_question_navigation', false),
                'disable_finish_button' => $exam->settings->get('disable_finish_button', false),
                'hide_solutions' => $exam->settings->get('hide_solutions', false),
                'list_questions' => $exam->settings->get('list_questions', true),
                'shuffle_questions' => $exam->settings->get('shuffle_questions', false),
            ],
        ]);
    }

    /**
     * Update exam settings
     *
     * @param UpdateExamSettingsRequest $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function updateSettings(UpdateExamSettingsRequest $request, $id)
    {
        $exam = Exam::with('examSections')->find($id);
        $exam->settings = $request->validated();
        $exam->update();

        foreach ($exam->examSections as $examSection) {
            $examSection->updateMeta();
        }

        $exam->updateMeta();

        return redirect()->route('exams.sections.index', ['exam' => $exam->id])->with('successMessage', 'Exam Settings Successfully Updated.');
    }

    /**
     * Delete an exam
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy($id)
    {
        try {
            $exam = Exam::with('examSchedules')->find($id);
            if(!$exam->canSecureDelete('examSchedules', 'sessions')) {
                return redirect()->route('exams.index')
                    ->with('errorMessage', 'Unable to Delete Exam . Exam schedules or sessions exist.');
            }
            DB::transaction(function () use ($exam) {
                foreach ($exam->examSections as $examSection) {
                    $examSection->questions()->detach();
                    $examSection->secureDelete();
                }
                $exam->secureDelete('sessions', 'examSchedules');
            });
        }
        catch (\Illuminate\Database\QueryException $e){
            return redirect()->route('exams.index')
                ->with('errorMessage', 'Unable to Delete Exam . Remove all associations and Try again!');
        }
        return redirect()->route('exams.index')
            ->with('successMessage', 'Exam was successfully deleted!');
    }
}
