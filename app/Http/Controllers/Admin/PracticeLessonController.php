<?php

namespace App\Http\Controllers\Admin;

use App\Filters\LessonFilters;
use App\Http\Controllers\Controller;
use App\Models\DifficultyLevel;
use App\Models\Lesson;
use App\Models\Skill;
use App\Models\SubCategory;
use App\Repositories\LessonRepository;
use App\Transformers\Admin\PracticeLessonTransformer;
use Illuminate\Http\Request;
use Inertia\Inertia;

class PracticeLessonController extends Controller
{
    private LessonRepository $repository;

    public function __construct(LessonRepository $repository)
    {
        $this->middleware(['role:admin|instructor'])->except('search');
        $this->repository = $repository;
    }

    /**
     * Go to Practice Lessons Screen
     *
     * @return \Inertia\Response
     */
    public function index()
    {
        return Inertia::render('Admin/Lesson/Configure', [
            'steps' => $this->repository->getSteps(),
        ]);
    }

    /**
     * Go to Practice Lessons Screen
     *
     * @param SubCategory $category
     * @param Skill $skill
     * @return \Inertia\Response
     */
    public function lessons(SubCategory $category, Skill $skill)
    {
        return Inertia::render('Admin/Lesson/PracticeLessons', [
            'subCategory' =>  $category,
            'skill' => $skill,
            'steps' => $this->repository->getSteps('lessons'),
            'difficultyLevels' => DifficultyLevel::select(['id', 'name'])->active()->get(),
        ]);
    }

    /**
     * Fetch practice lessons api endpoint
     *
     * @param SubCategory $category
     * @param Skill $skill
     * @param LessonFilters $filters
     * @return \Illuminate\Http\JsonResponse
     */
    public function fetchLessons(SubCategory $category, Skill $skill, LessonFilters $filters)
    {
        $lessons = $category->practiceLessons()->filter($filters)
            ->with(['difficultyLevel:id,name,code', 'skill:id,name'])
            ->where('practice_lessons.skill_id', '=', $skill->id)
            ->paginate(10);

        return response()->json([
            'lessons' => fractal($lessons, new PracticeLessonTransformer())->toArray()
        ], 200);
    }

    /**
     * Fetch practice lessons api endpoint
     *
     * @param SubCategory $category
     * @param Skill $skill
     * @param LessonFilters $filters
     * @return \Illuminate\Http\JsonResponse
     */
    public function fetchAvailableLessons(SubCategory $category, Skill $skill, LessonFilters $filters)
    {
        $lessons = $category->practiceLessons()
            ->where('practice_lessons.skill_id', '=', $skill->id)
            ->get();

        $availableLessons = Lesson::filter($filters)->whereNotIn('id', $lessons->pluck('id'))
            ->where('skill_id', '=', $skill->id)
            ->with(['difficultyLevel:id,name,code', 'skill:id,name'])
            ->paginate(10);

        return response()->json([
            'lessons' => fractal($availableLessons, new PracticeLessonTransformer())->toArray()
        ], 200);
    }

    /**
     * @param SubCategory $category
     * @param Skill $skill
     * @return \Illuminate\Http\JsonResponse
     */
    public function addLesson(SubCategory $category, Skill $skill)
    {
        try {
            $lesson = Lesson::findOrFail(request()->get('lesson_id'));

            $count = $category->practiceLessons()->where('practice_lessons.skill_id', '=', $skill->id)->count();

            if (!$category->practiceLessons->contains($lesson->id)) {
                $category->practiceLessons()->attach($lesson->id, [
                    'skill_id' => $skill->id,
                    'sort_order' => $count + 1
                ]);
            }

            return response()->json([
                'success' => true,
                'message' => 'Lesson Added Successfully!'
            ], 200);

        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => 'Something Went Wrong']);
        }

    }

    /**
     * @param SubCategory $category
     * @param Skill $skill
     * @return \Illuminate\Http\JsonResponse
     */
    public function removeLesson(SubCategory $category, Skill $skill)
    {
        try {
            $lesson = Lesson::findOrFail(request()->get('lesson_id'));

            $category->practiceLessons()->where('practice_lessons.skill_id', '=', $skill->id)->detach($lesson->id);

            return response()->json([
                'success' => true,
                'message' => 'Lesson Removed Successfully!'
            ], 200);

        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => 'Something Went Wrong']);
        }
    }
}
