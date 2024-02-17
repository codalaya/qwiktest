<?php

namespace App\Http\Controllers\Admin;

use App\Filters\LessonFilters;
use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\StoreLessonRequest;
use App\Http\Requests\Admin\UpdateLessonRequest;
use App\Models\DifficultyLevel;
use App\Models\Lesson;
use App\Models\Skill;
use App\Models\Tag;
use App\Models\Topic;
use App\Repositories\TagRepository;
use App\Transformers\Admin\LessonTransformer;
use App\Transformers\Admin\SkillSearchTransformer;
use App\Transformers\Admin\TopicSearchTransformer;
use Inertia\Inertia;

class LessonCrudController extends Controller
{
    public function __construct()
    {
        $this->middleware(['role:admin|instructor']);
    }

    /**
     * Display a listing of the resource.
     *
     * @param LessonFilters $filters
     * @return \Inertia\Response
     */
    public function index(LessonFilters $filters)
    {
        return Inertia::render('Admin/Lessons', [
            'lessons' => function () use ($filters) {
                return fractal(Lesson::with(['section:sections.id,sections.name', 'skill:id,name', 'topic:id,name'])->filter($filters)
                    ->paginate(request()->perPage != null ? request()->perPage : 10),
                    new LessonTransformer())->toArray();
            },
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Inertia\Response
     */
    public function create()
    {
        return Inertia::render('Admin/Lesson/Form', [
            'difficultyLevels' => DifficultyLevel::select(['name', 'id'])->get(),
        ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param StoreLessonRequest $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(StoreLessonRequest $request)
    {
        Lesson::create($request->validated());
        return redirect()->route('lessons.index')->with('successMessage', 'Lesson created successfully!');
    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Inertia\Response
     */
    public function edit($id)
    {
        $lesson = Lesson::with('tags')->findOrFail($id);
        return Inertia::render('Admin/Lesson/Form', [
            'lesson' => $lesson,
            'editFlag' => true,
            'lessonId' => $lesson->id,
            'difficultyLevels' => DifficultyLevel::select(['name', 'id'])->get(),
            'initialSkills' => fractal(Skill::select(['id', 'name', 'section_id'])
                ->with('section:id,name')
                ->where('id', $lesson->skill_id)
                ->get(), new SkillSearchTransformer())
                ->toArray()['data'],
            'initialTopics' => fractal(Topic::select(['id', 'name', 'skill_id'])
                ->with('skill:id,name')
                ->where('skill_id', $lesson->skill_id)
                ->get(), new TopicSearchTransformer())
                ->toArray()['data'],
            'initialTags' => Tag::select(['id', 'name'])
                ->get(),
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param UpdateLessonRequest $request
     * @param int $id
     * @param TagRepository $tagRepository
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(UpdateLessonRequest $request, $id, TagRepository $tagRepository)
    {
        $lesson = Lesson::findOrFail($id);
        $lesson->update($request->validated());

        // Check if tags exists, otherwise create
        $tagRepository->createIfNotExists($request->tags);

        $tagData = Tag::whereIn('name', $request->tags)->pluck('id');
        $lesson->tags()->sync($tagData);

        return redirect()->route('lessons.index')->with('successMessage', 'Lesson updated successfully!');
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy($id)
    {
        try {
            $lesson = Lesson::find($id);
            $lesson->subCategories()->detach();
            $lesson->tags()->detach();
            $lesson->secureDelete();
        }
        catch (\Illuminate\Database\QueryException $e){
            return redirect()->back()->with('errorMessage', 'Unable to Delete Lesson . Remove all associations and Try again!');
        }
        return redirect()->back()->with('successMessage', 'Lesson was successfully deleted!');
    }
}
