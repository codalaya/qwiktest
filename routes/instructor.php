<?php


use App\Http\Controllers\Instructor\DashboardController;

Route::middleware(['auth:sanctum', 'verified'])->prefix('instructor')->group(function () {
    Route::get('/dashboard', [DashboardController::class, 'index'])->name('instructor_dashboard');
});
