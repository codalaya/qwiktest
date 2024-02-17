<?php

namespace App\Http\Controllers\Admin;

use App\Filters\TagFilters;
use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\StoreTagRequest;
use App\Models\Tag;
use App\Transformers\Admin\TagTransformer;
use Illuminate\Http\Request;
use Inertia\Inertia;

class TagCrudController extends Controller
{
    public function __construct()
    {
        $this->middleware(['role:admin|instructor'])->except('search');
    }

    /**
     * Display a listing of the resource.
     *
     * @param TagFilters $filters
     * @return \Inertia\Response
     */
    public function index(TagFilters $filters)
    {
        return Inertia::render('Admin/Tags', [
            'tags' => function () use ($filters) {
                return fractal(Tag::filter($filters)
                    ->paginate(request()->perPage != null ? request()->perPage : 10),
                    new TagTransformer())->toArray();
            },
        ]);
    }

    /**
     * Search topics api endpoint
     *
     * @param Request $request
     * @param TagFilters $filters
     * @return \Illuminate\Http\JsonResponse
     */
    public function search(Request $request, TagFilters $filters)
    {
        $query = $request->get('query');
        return response()->json([
            'tags' => Tag::select(['id', 'name'])
                ->filter($filters)
                ->where('name', 'like', '%'.$query.'%')
                ->limit(20)
                ->get()
        ]);
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param Request $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(StoreTagRequest $request)
    {
        Tag::create($request->validated());

        return redirect()->back()->with('successMessage', 'Tag saved successfully!');
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        return Tag::find($id);
    }

    /**
     * Update the specified resource in storage.
     *
     * @param StoreTagRequest $request
     * @param int $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(StoreTagRequest $request, $id)
    {
        $tag = Tag::find($id);
        $tag->update($request->validated());

        return redirect()->back()->with('successMessage', 'Tag updated successfully!');
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
            $tag = Tag::find($id);
            $tag->questions()->detach();
            $tag->lessons()->detach();
            $tag->videos()->detach();
            $tag->secureDelete();
        }
        catch (\Illuminate\Database\QueryException $e){
            return redirect()->back()->with('errorMessage', 'Unable to Delete Tag . Remove all associations and Try again!');
        }

        return back()->with('successMessage', 'Tag Deleted Successfully');
    }
}
