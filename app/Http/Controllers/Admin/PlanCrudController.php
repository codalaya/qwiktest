<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Filters\PlanFilters;
use App\Http\Requests\Admin\StorePlanRequest;
use App\Http\Requests\Admin\UpdatePlanRequest;
use App\Models\Feature;
use App\Models\Plan;
use App\Models\SubCategory;
use App\Transformers\Admin\PlanSearchTransformer;
use App\Transformers\Admin\PlanTransformer;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;
use Inertia\Inertia;

class PlanCrudController extends Controller
{
    public function __construct()
    {
        $this->middleware(['role:admin']);
    }

    /**
     * List all plans
     *
     * @param PlanFilters $filters
     * @return \Inertia\Response
     */
    public function index(PlanFilters $filters)
    {
        return Inertia::render('Admin/Plans', [
            'plans' => function () use ($filters) {
                return fractal(
                    Plan::with('category:id,name')->filter($filters)
                        ->paginate(request()->perPage != null ? request()->perPage : 10),
                    new PlanTransformer()
                )->toArray();
            },
            'features' => Feature::select(['id', 'name'])->active()->get(),
            'subCategories' => SubCategory::select(['id', 'name'])->active()->get()
        ]);
    }

    /**
     * Search users api endpoint
     *
     * @param Request $request
     * @param PlanFilters $filters
     * @return \Illuminate\Http\JsonResponse
     */
    public function search(Request $request, PlanFilters $filters)
    {
        $query = $request->get('query');
        return response()->json([
            'plans' => fractal(Plan::filter($filters)
                ->where('name', 'like', '%' . $query . '%')->limit(20)
                ->get(), new PlanSearchTransformer())
                ->toArray()['data']
        ]);
    }

    /**
     * Store an plan
     *
     * @param StorePlanRequest $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(StorePlanRequest $request)
    {
        $plan = Plan::create($request->validated());

        if ($plan) {
            if ($plan->feature_restrictions) {
                $plan->features()->sync($request->features);
            } else {
                $plan->features()->sync(Feature::active()->pluck('id'));
            }
        }

        return redirect()->back()->with('successMessage', 'Plan was successfully added!');
    }

    /**
     * Show an plan
     *
     * @param $id
     * @return array
     */
    public function show($id)
    {
        $plan = Plan::find($id);
        return fractal($plan, new PlanTransformer())->toArray();
    }

    /**
     * Edit an plan
     *
     * @param $id
     * @return \Illuminate\Http\JsonResponse
     */
    public function edit($id)
    {
        $plan = Plan::find($id);
        return response()->json([
            'plan' => $plan,
            'features' => $plan->features()->pluck('id'),
        ]);
    }

    /**
     * Update an plan
     *
     * @param UpdatePlanRequest $request
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(UpdatePlanRequest $request, $id)
    {
        if (config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! Plans can\'t be changed.');
        }

        $plan = Plan::find($id);
        $plan->update($request->validated());

        if ($plan->feature_restrictions) {
            $plan->features()->sync($request->features);
        } else {
            $plan->features()->sync(Feature::active()->pluck('id'));
        }

        return redirect()->back()->with('successMessage', 'Plan was successfully updated!');
    }

    /**
     * Delete an plan
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy($id)
    {
        if (config('qwiktest.demo_mode')) {
            return redirect()->back()->with('errorMessage', 'Demo Mode! Plans can\'t be deleted.');
        }

        try {
            $plan = Plan::find($id);

            if (!$plan->canSecureDelete('subscriptions', 'payments')) {
                return redirect()->back()->with('errorMessage', 'Unable to Delete Plan! Subscriptions or Payments Exist.');
            }

            $plan->secureDelete('subscriptions', 'payments');
        } catch (\Illuminate\Database\QueryException $e) {
            return redirect()->back()->with('errorMessage', 'Unable to Delete Plan . Remove all associations and Try again!');
        }
        return redirect()->back()->with('successMessage', 'Plan was successfully deleted!');
    }
}
