<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateExamSectionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('exam_sections', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->unsignedBigInteger('exam_id');
            $table->unsignedBigInteger('section_id');
            $table->unsignedInteger('total_questions')->default(0);
            $table->unsignedInteger('total_duration')->nullable();
            $table->double('correct_marks', 10, 2)->nullable();
            $table->double('total_marks', 10, 2)->nullable();
            $table->string('negative_marking_type')->default('fixed');
            $table->double('negative_marks', 10, 2)->nullable();
            $table->unsignedInteger('section_cutoff')->nullable();
            $table->unsignedInteger('section_order')->default(1);
            $table->unsignedInteger('assign_examiner')->default(0);
            $table->unsignedBigInteger('examiner_id')->nullable();
            $table->boolean('examined')->default(0);
            $table->dateTime('examined_at')->nullable();
            $table->boolean('approved')->default(0);
            $table->dateTime('approved_at')->nullable();
            $table->unsignedBigInteger('approved_by')->nullable();
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
        Schema::dropIfExists('exam_sections');
    }
}
