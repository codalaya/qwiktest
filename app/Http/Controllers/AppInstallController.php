<?php


namespace App\Http\Controllers;

use Jackiedo\DotenvEditor\Facades\DotenvEditor;
use Illuminate\Support\Facades\Artisan;

class AppInstallController extends Controller
{
    /**
     * Update env file, configure storage and cache after installation
     *
     * @return \Illuminate\Http\RedirectResponse
     */
    public function onSuccessfulInstall()
    {
        $installed = file_exists(storage_path('installed'));

        if($installed) {
            $env = DotenvEditor::load();
            $env->addEmpty();
            $env->setKey('APP_INSTALLED', 'true');
            $env->setKey('APP_VERSION', '1.4.0');
            $env->setKey('SESSION_DRIVER', 'database');
            $env->setKey('SESSION_LIFETIME', '43200');
            $env->save();

            try {
                Artisan::call('config:clear');
                Artisan::call('cache:clear');
                Artisan::call('storage:link');
            } catch (\Exception $exception) {}
        }

        return redirect()->route('welcome');
    }

    /**
     * Go to migration screen
     *
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View|\Illuminate\Http\JsonResponse
     */
    public function migrate()
    {
        if(config('qwiktest.version') == '1.4.0') {
            return response()->json([
                'error' => 404,
                'message' => 'Nothing to migrate. App is already up to date.'
            ], 404);
        }
        return view('migration', [
            'success' => false,
            'message' => 'If you updated the app with latest files, run migrations by clicking Migrate Now button.'
        ]);
    }

    /**
     * Force run migrations after update
     *
     * @return \Illuminate\Contracts\Foundation\Application|\Illuminate\Contracts\View\Factory|\Illuminate\Contracts\View\View|\Illuminate\Http\JsonResponse|\Illuminate\Http\RedirectResponse
     */
    public function runMigrations()
    {
        $installed = file_exists(storage_path('installed'));

        if($installed) {
            if(config('qwiktest.version') == '1.4.0') {
                return response()->json([
                    'error' => 404,
                    'message' => 'Nothing to migrate. App is already up to date.'
                ], 404);
            }
            \Illuminate\Support\Facades\Artisan::call('migrate', ['--force'=> true]);
            return view('migration', [
                'success' => true,
                'message' => 'Migration successful. Now, login and fix updates in the maintenance settings.'
            ]);
        }

        return response()->json([
            'error' => 404,
            'message' => 'App is not yet installed.'
        ], 404);
    }
}
