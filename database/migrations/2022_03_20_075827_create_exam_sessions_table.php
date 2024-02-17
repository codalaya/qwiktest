<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateExamSessionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('exam_sessions', function (Blueprint $table) {
            $table->id();
            $table->uuid('code')->unique();
            $table->unsignedBigInteger('exam_id');
            $table->unsignedBigInteger('user_id');
            $table->unsignedBigInteger('exam_schedule_id')->nullable();
            $table->dateTime('starts_at');
            $table->dateTime('ends_at');
            $table->integer('total_time_taken')->default(0);
            $table->integer('current_section')->default(0);
            $table->integer('current_question')->default(0);
            $table->json('results')->nullable();
            $table->string('status')->default('started')->index();
            $table->dateTime('completed_at')->nullable();
            $table->timestamps();
            $table->softDeletes();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('exam_sessions');
    }
}
