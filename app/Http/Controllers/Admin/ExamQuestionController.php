<?php

namespace App\Http\Controllers\Admin;

use App\Filters\QuestionFilters;
use App\Http\Controllers\Controller;
use App\Models\DifficultyLevel;
use App\Models\Exam;
use App\Models\ExamSection;
use App\Models\Question;
use App\Models\QuestionType;
use App\Repositories\ExamRepository;
use App\Repositories\QuestionRepository;
use App\Transformers\Admin\ExamSectionTransformer;
use App\Transformers\Admin\QuestionPreviewTransformer;
use Inertia\Inertia;

class ExamQuestionController extends Controller
{
    private QuestionRepository $questionRepository;
    private ExamRepository $repository;

    public function __construct(ExamRepository $repository, QuestionRepository $questionRepository)
    {
        $this->middleware(['role:admin|instructor']);
        $this->repository = $repository;
        $this->questionRepository = $questionRepository;
    }

    /**
     * Quiz questions page
     *
     * @param $exam
     * @return \Illuminate\Http\RedirectResponse|\Inertia\Response
     */
    public function index($exam)
    {
        $exam = Exam::select(['id', 'title'])->with(['examSections' => function($query) {
            $query->with('section:id,name');
        }])->withCount(['examSections'])->findOrFail($exam);

        if($exam->exam_sections_count == 0) {
            return redirect()->back()->with('errorMessage', 'Please add at least one section to the exam.');
        }

        return Inertia::render('Admin/Exam/Questions', [
            'exam' => $exam->only(['id', 'title']),
            'steps' => $this->repository->getSteps($exam->id, 'questions'),
            'editFlag' => true,
            'difficultyLevels' => DifficultyLevel::select(['id', 'name'])->active()->get(),
            'questionTypes' => QuestionType::select(['id', 'name'])->active()->get(),
            'sections' => function () use($exam) {
                return fractal($exam->examSections, new ExamSectionTransformer())->toArray()['data'];
            },
        ]);
    }

    /**
     * Fetch exam section questions api endpoint
     *
     * @param $exam
     * @param $section
     * @param QuestionFilters $filters
     * @return \Illuminate\Http\JsonResponse
     */
    public function fetchQuestions($exam, $section, QuestionFilters $filters)
    {
        $exam = Exam::select(['id', 'title'])->findOrFail($exam);

        $questions = $exam->questions()->filter($filters)
            ->where('exam_section_id', '=', $section)
            ->with(['questionType:id,name,code', 'difficultyLevel:id,name,code', 'skill:id,name'])
            ->paginate(10);

       return response()->json([
            'questions' => fractal($questions, new QuestionPreviewTransformer())->toArray(),
        ], 200);
    }

    /**
     * Fetch available questions api endpoint
     *
     * @param $exam
     * @param $section
     * @param QuestionFilters $filters
     * @return \Illuminate\Http\JsonResponse
     */
    public function fetchAvailableQuestions($exam, $section, QuestionFilters $filters)
    {
        $exam = Exam::select(['id', 'title'])->findOrFail($exam);

        $questions = Question::filter($filters)->whereNotIn('id', $exam->questions->pluck('id'))
            ->with(['questionType:id,name,code', 'difficultyLevel:id,name,code', 'skill:id,name'])
            ->whereHas('section', function ($q) use ($section) {
                $q->where('sections.id', '=', $section);
            })->paginate(10);

        return response()->json([
            'questions' => fractal($questions, new QuestionPreviewTransformer())->toArray()
        ], 200);
    }

    /**
     * Add question to exam section
     *
     * @param $exam
     * @param $section
     * @return \Illuminate\Http\JsonResponse
     */
    public function addQuestion(Exam $exam, ExamSection $section)
    {
        try {
            $question = Question::with('questionType:id,code')->findOrFail(request()->get('question_id'));

            if($exam->settings->auto_evaluation == false) {
                if(!$this->questionRepository->checkAutoEvaluationEligibility($question->questionType->code)) {
                    return response()->json([
                        'status' => 'warning',
                        'message' => 'This question type does not supports auto evaluation.'
                    ], 200);
                }
            }

            if (!$section->questions->contains($question->id)) {
                $section->questions()->attach([
                    $question->id => ['exam_id' => $exam->id]
                ]);
            }

            $section->updateMeta();
            $exam->updateMeta();

            return response()->json(['status' => 'success', 'message' => 'Question Added Successfully'], 200);

        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => 'Something Went Wrong']);
        }
    }

    /**
     * Remove question from exam section
     *
     * @param $exam
     * @param $section
     * @return \Illuminate\Http\JsonResponse
     */
    public function removeQuestion(Exam $exam, ExamSection $section)
    {
        try {
            $question = Question::with('questionType:id,type')->findOrFail(request()->get('question_id'));

            $section->questions()->detach($question->id);

            $section->updateMeta();
            $exam->updateMeta();

            return response()->json(['status' => 'success', 'message' => 'Question Removed Successfully'], 200);

        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => $e]);
        }
    }
}
