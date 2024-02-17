<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\DB;
use Jackiedo\DotenvEditor\Exceptions\KeyNotFoundException;
use Jackiedo\DotenvEditor\Facades\DotenvEditor;
use Illuminate\Support\Facades\Artisan;

class AppUpdateController extends Controller
{
    public function __construct()
    {
        $this->middleware(['role:admin']);
    }

    /**
     * Update env file, configure storage and cache after update
     * The following logic may be different from version to version.
     *
     * @return \Illuminate\Http\RedirectResponse
     */
    public function onSuccessfulUpdate()
    {
        //Check app is installed properly
        $installed = file_exists(storage_path('installed'));
        $env = DotenvEditor::load();

        try {
            $currentVersion = $env->getValue('APP_VERSION');
        } catch (KeyNotFoundException $exception) {
            return redirect()->back()->with('errorMessage', 'Unable to find current version. Please check APP_VERSION in .env file is set to the current version.');
        }

        // check if app is already updated
        if($currentVersion == '1.4.0') {
            return redirect()->back()->with('successMessage', 'App is already up to date');
        }

        $canUpdate = $currentVersion == '1.3.0';

        // If installed and not updated, continue to update
        if($installed && $canUpdate) {
            //Update new app version
            $env->setKey('APP_VERSION', '1.4.0');
            $env->save();

            // Add exams to features table
            DB::table('features')->insert([
                'name' => 'Exams', 'code' => 'exams', 'sort_order' => 5, 'is_active' => 1
            ]);

            try {
                Artisan::call('config:clear');
                Artisan::call('cache:clear');
                Artisan::call('storage:link');
            } catch (\Exception $exception) {}

            return redirect()->back()->with('successMessage', 'App Successfully Updated');
        }

        return redirect()->back()->with('errorMessage', 'Nothing to update');
    }
}
