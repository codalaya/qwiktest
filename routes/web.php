<?php


use Illuminate\Support\Facades\Route;
use App\Http\Controllers\HomeController;
use App\Http\Controllers\SiteController;
use App\Http\Controllers\AppInstallController;
use App\Http\Controllers\WebHookController;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', [SiteController::class, 'index'])->name('welcome');
Route::get('/explore/{category}', [SiteController::class, 'explore'])->name('explore');
Route::get('/pricing', [SiteController::class, 'pricing'])->name('pricing');

Route::get('set-locale/{locale}', [HomeController::class, 'setLocale'])->name('locale');
Route::middleware(['auth:sanctum', 'verified'])->get('/home', [HomeController::class, 'index'])->name('home');

Route::get('install-success', [AppInstallController::class, 'onSuccessfulInstall'])->name('install_success');
Route::get('migrate', [AppInstallController::class, 'migrate'])->name('migrate');
Route::get('run-migrations', [AppInstallController::class, 'runMigrations'])->name('run_migrations');

/*
|--------------------------------------------------------------------------
| Webhook Routes
|--------------------------------------------------------------------------
*/
Route::post('webhooks/razorpay', [WebHookController::class, 'razorpay'])->name('webhooks.razorpay');

