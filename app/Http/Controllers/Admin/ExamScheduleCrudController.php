<?php


namespace App\Http\Controllers\Admin;

use App\Filters\ExamScheduleFilters;
use App\Http\Controllers\Controller;
use App\Http\Requests\Admin\StoreExamScheduleRequest;
use App\Http\Requests\Admin\UpdateExamScheduleRequest;
use App\Models\Exam;
use App\Models\ExamSchedule;
use App\Models\UserGroup;
use App\Repositories\ExamRepository;
use App\Settings\LocalizationSettings;
use App\Transformers\Admin\ExamScheduleTransformer;
use Carbon\Carbon;
use Inertia\Inertia;

class ExamScheduleCrudController extends Controller
{
    private ExamRepository $repository;

    public function __construct(ExamRepository $repository)
    {
        $this->middleware(['role:admin|instructor']);
        $this->repository = $repository;
    }

    /**
     * List all exam schedules of a exam
     *
     * @param $id
     * @param ExamScheduleFilters $filters
     * @return \Illuminate\Http\RedirectResponse|\Inertia\Response
     */
    public function index($id, ExamScheduleFilters $filters)
    {
        $exam = Exam::findOrFail($id);

        if(!$exam->is_active) {
            return redirect()->back()->with('errorMessage', 'Exam is in draft mode. Kindly publish exam before scheduling it to users');
        }

        return Inertia::render('Admin/ExamSchedules', [
            'exam' => $exam->only(['id', 'title']),
            'steps' => $this->repository->getSteps($exam->id, 'schedules'),
            'editFlag' => true,
            'examSchedules' => function () use($filters, $exam) {
                return fractal(ExamSchedule::filter($filters)
                    ->with('exam:id,title')
                    ->where('exam_id', $exam->id)
                    ->paginate(request()->perPage != null ? request()->perPage : 10),
                    new ExamScheduleTransformer())->toArray();
            },
            'userGroups' => UserGroup::select(['id', 'name'])->active()->get()
        ]);
    }

    /**
     * Store a exam schedule
     *
     * @param StoreExamScheduleRequest $request
     * @return \Illuminate\Http\RedirectResponse
     */
    public function store(StoreExamScheduleRequest $request)
    {
        $exam = Exam::findOrFail($request->exam_id);
        $schedule = new ExamSchedule();

        if($request->schedule_type == 'fixed') {
            $startDate = Carbon::createFromFormat('Y-m-d H:i:s', $request->start_date.' '.$request->start_time);
            $schedule->start_date = $startDate->toDateString();
            $schedule->start_time = $startDate->toTimeString();

            $endDate = $startDate->addSeconds($exam->total_duration);
            $schedule->end_date = $endDate->toDateString();
            $schedule->end_time = $endDate->toTimeString();

            $schedule->grace_period = $request->grace_period;
        }

        if($request->schedule_type == 'flexible') {
            $startDate = Carbon::createFromFormat('Y-m-d H:i:s', $request->start_date.' '.$request->start_time);
            $schedule->start_date = $startDate->toDateString();
            $schedule->start_time = $startDate->toTimeString();

            $endDate = Carbon::createFromFormat('Y-m-d H:i:s', $request->end_date.' '.$request->end_time);
            $schedule->end_date = $endDate->toDateString();
            $schedule->end_time = $endDate->toTimeString();
        }

        $schedule->exam_id = $request->exam_id;
        $schedule->schedule_type = $request->schedule_type;
        $schedule->status = $request->status;
        $schedule->save();

        if($schedule) {
            $schedule->userGroups()->sync($request->user_groups);
        }

        return redirect()->back()->with('successMessage', 'Exam Schedule was successfully added!');
    }

    /**
     * Show a exam schedule
     *
     * @param $id
     * @return array
     */
    public function show($id)
    {
        $examSchedule = ExamSchedule::find($id);
        return fractal($examSchedule, new ExamScheduleTransformer())->toArray();
    }

    /**
     * Edit a exam schedule
     *
     * @param Exam $exam
     * @param $id
     * @param LocalizationSettings $localization
     * @return \Illuminate\Http\JsonResponse
     */
    public function edit(Exam $exam, $id, LocalizationSettings $localization)
    {
        $schedule = ExamSchedule::with(['userGroups:id'])->find($id);
        $now = Carbon::now()->timezone($localization->default_timezone);
        $startsIn =  $now->diffInSeconds($schedule->starts_at, false);
        return response()->json([
            'schedule' => $schedule,
            'userGroups' => $schedule->userGroups()->pluck('id'),
            'disableFlag' => $schedule->status == 'expired' || $startsIn < 15
        ]);
    }

    /**
     * Update a exam schedule
     *
     * @param UpdateExamScheduleRequest $request
     * @param Exam $exam
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function update(UpdateExamScheduleRequest $request, Exam $exam, $id)
    {
        $schedule = ExamSchedule::with('exam:id,total_duration')->find($id);

        if($schedule->status == 'expired') {
            return redirect()->back()->with('errorMessage', 'You can\'t update once exam schedule starts or expired. Please create a new schedule.');
        }

        if($schedule->schedule_type == 'fixed') {
            $startDate = Carbon::createFromFormat('Y-m-d H:i:s', $request->start_date.' '.$request->start_time);
            $schedule->start_date = $startDate->toDateString();
            $schedule->start_time = $startDate->toTimeString();

            $endDate = $startDate->addSeconds($schedule->exam->total_duration);
            $schedule->end_date = $endDate->toDateString();
            $schedule->end_time = $endDate->toTimeString();

            $schedule->grace_period = $request->grace_period;
        }

        if($schedule->schedule_type == 'flexible') {
            $startDate = Carbon::createFromFormat('Y-m-d H:i:s', $request->start_date.' '.$request->start_time);
            $schedule->start_date = $startDate->toDateString();
            $schedule->start_time = $startDate->toTimeString();

            $endDate = Carbon::createFromFormat('Y-m-d H:i:s', $request->end_date.' '.$request->end_time);
            $schedule->end_date = $endDate->toDateString();
            $schedule->end_time = $endDate->toTimeString();
        }

        $schedule->status = $request->status;
        $schedule->update();

        if($schedule) {
            $schedule->userGroups()->sync($request->user_groups);
        }

        return redirect()->back()->with('successMessage', 'Exam Schedule was successfully updated!');
    }

    /**
     * Delete a exam schedule
     *
     * @param $id
     * @return \Illuminate\Http\RedirectResponse
     */
    public function destroy(Exam $exam, $id)
    {
        try {
            $examSchedule = ExamSchedule::find($id);
            $examSchedule->userGroups()->detach();
            $examSchedule->secureDelete('sessions');
        }
        catch (\Illuminate\Database\QueryException $e){
            return redirect()->back()->with('errorMessage', 'Unable to Delete Exam Schedule . Remove all associations and Try again!');
        }
        return redirect()->back()->with('successMessage', 'Exam Schedule was successfully deleted!');
    }
}
