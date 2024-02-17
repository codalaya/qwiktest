<?php

namespace App\Http\Controllers\Admin;

use App\Filters\VideoFilters;
use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\StoreVideoRequest;
use App\Http\Requests\Admin\UpdateVideoRequest;
use App\Models\DifficultyLevel;
use App\Models\Skill;
use App\Models\Topic;
use App\Models\Video;
use App\Models\Tag;
use App\Repositories\TagRepository;
use App\Transformers\Admin\VideoTransformer;
use App\Transformers\Admin\SkillSearchTransformer;
use App\Transformers\Admin\TopicSearchTransformer;
use Illuminate\Http\Request;
use Inertia\Inertia;

class VideoCrudController extends Controller
{
    public function __construct()
    {
        $this->middleware(['role:admin|instructor']);
    }

    /**
     * Display a listing of the resource.
     *
     * @param VideoFilters $filters
     * @return \Inertia\Response
     */
    public function index(VideoFilters $filters)
    {
        return Inertia::render('Admin/Videos', [
            'videos' => function () use ($filters) {
                return fractal(Video::with(['section:sections.id,sections.name', 'skill:id,name', 'topic:id,name'])->filter($filters)
                    ->paginate(request()->perPage != null ? request()->perPage : 10),
                    new VideoTransformer())->toArray();
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
        return Inertia::render('Admin/Video/Form', [
            'difficultyLevels' => DifficultyLevel::select(['name', 'id'])->get(),
        ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param StoreVideoRequest $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(StoreVideoRequest $request)
    {
        Video::create($request->validated());
        return redirect()->route('videos.index')->with('successMessage', 'Video created successfully!');
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
        $video = Video::with('tags')->findOrFail($id);
        return Inertia::render('Admin/Video/Form', [
            'video' => $video,
            'editFlag' => true,
            'videoId' => $video->id,
            'difficultyLevels' => DifficultyLevel::select(['name', 'id'])->get(),
            'initialSkills' => fractal(Skill::select(['id', 'name', 'section_id'])
                ->with('section:id,name')
                ->where('id', $video->skill_id)
                ->get(), new SkillSearchTransformer())
                ->toArray()['data'],
            'initialTopics' => fractal(Topic::select(['id', 'name', 'skill_id'])
                ->with('skill:id,name')
                ->where('skill_id', $video->skill_id)
                ->get(), new TopicSearchTransformer())
                ->toArray()['data'],
            'initialTags' => Tag::select(['id', 'name'])
                ->get(),
        ]);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param UpdateVideoRequest $request
     * @param int $id
     * @param TagRepository $tagRepository
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(UpdateVideoRequest $request, $id, TagRepository $tagRepository)
    {
        $video = Video::findOrFail($id);
        $video->update($request->validated());

        // Check if tags exists, otherwise create
        $tagRepository->createIfNotExists($request->tags);

        $tagData = Tag::whereIn('name', $request->tags)->pluck('id');
        $video->tags()->sync($tagData);

        return redirect()->route('videos.index')->with('successMessage', 'Video updated successfully!');
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
            $video = Video::find($id);
            $video->subCategories()->detach();
            $video->tags()->detach();
            $video->secureDelete();
        }
        catch (\Illuminate\Database\QueryException $e){
            return redirect()->back()->with('errorMessage', 'Unable to Delete Video . Remove all associations and Try again!');
        }
        return redirect()->back()->with('successMessage', 'Video was successfully deleted!');
    }
}
