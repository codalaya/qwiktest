<?php

namespace App\Http\Controllers\Admin;

use App\Filters\VideoFilters;
use App\Http\Controllers\Controller;
use App\Models\DifficultyLevel;
use App\Models\Video;
use App\Models\Skill;
use App\Models\SubCategory;
use App\Repositories\VideoRepository;
use App\Transformers\Admin\PracticeVideoTransformer;
use Inertia\Inertia;

class PracticeVideoController extends Controller
{
    private VideoRepository $repository;

    public function __construct(VideoRepository $repository)
    {
        $this->middleware(['role:admin|instructor'])->except('search');
        $this->repository = $repository;
    }

    /**
     * Go to Practice Videos Screen
     *
     * @return \Inertia\Response
     */
    public function index()
    {
        return Inertia::render('Admin/Video/Configure', [
            'steps' => $this->repository->getSteps(),
        ]);
    }

    /**
     * Go to Practice Videos Screen
     *
     * @param SubCategory $category
     * @param Skill $skill
     * @return \Inertia\Response
     */
    public function videos(SubCategory $category, Skill $skill)
    {
        return Inertia::render('Admin/Video/PracticeVideos', [
            'subCategory' =>  $category,
            'skill' => $skill,
            'steps' => $this->repository->getSteps('videos'),
            'difficultyLevels' => DifficultyLevel::select(['id', 'name'])->active()->get(),
        ]);
    }

    /**
     * Fetch practice videos api endpoint
     *
     * @param SubCategory $category
     * @param Skill $skill
     * @param VideoFilters $filters
     * @return \Illuminate\Http\JsonResponse
     */
    public function fetchVideos(SubCategory $category, Skill $skill, VideoFilters $filters)
    {
        $videos = $category->practiceVideos()->filter($filters)
            ->with(['difficultyLevel:id,name,code', 'skill:id,name'])
            ->where('practice_videos.skill_id', '=', $skill->id)
            ->paginate(10);

        return response()->json([
            'videos' => fractal($videos, new PracticeVideoTransformer())->toArray()
        ], 200);
    }

    /**
     * Fetch practice videos api endpoint
     *
     * @param SubCategory $category
     * @param Skill $skill
     * @param VideoFilters $filters
     * @return \Illuminate\Http\JsonResponse
     */
    public function fetchAvailableVideos(SubCategory $category, Skill $skill, VideoFilters $filters)
    {
        $videos = $category->practiceVideos()
            ->where('practice_videos.skill_id', '=', $skill->id)
            ->get();

        $availableVideos = Video::filter($filters)->whereNotIn('id', $videos->pluck('id'))
            ->where('skill_id', '=', $skill->id)
            ->with(['difficultyLevel:id,name,code', 'skill:id,name'])
            ->paginate(10);

        return response()->json([
            'videos' => fractal($availableVideos, new PracticeVideoTransformer())->toArray()
        ], 200);
    }

    /**
     * @param SubCategory $category
     * @param Skill $skill
     * @return \Illuminate\Http\JsonResponse
     */
    public function addVideo(SubCategory $category, Skill $skill)
    {
        try {
            $video = Video::findOrFail(request()->get('video_id'));

            $count = $category->practiceVideos()->where('practice_videos.skill_id', '=', $skill->id)->count();

            if (!$category->practiceVideos->contains($video->id)) {
                $category->practiceVideos()->attach($video->id, [
                    'skill_id' => $skill->id,
                    'sort_order' => $count + 1
                ]);
            }

            return response()->json([
                'success' => true,
                'message' => 'Video Added Successfully!'
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
    public function removeVideo(SubCategory $category, Skill $skill)
    {
        try {
            $video = Video::findOrFail(request()->get('video_id'));

            $category->practiceVideos()->where('practice_videos.skill_id', '=', $skill->id)->detach($video->id);

            return response()->json([
                'success' => true,
                'message' => 'Video Removed Successfully!'
            ], 200);

        } catch (\Exception $e) {
            return response()->json(['status' => 'error', 'message' => 'Something Went Wrong']);
        }
    }
}
