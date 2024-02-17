<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateExamSessionSectionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('exam_session_sections', function (Blueprint $table) {
            $table->unsignedBigInteger('sno')->default(1)->index();
            $table->string('name');
            $table->unsignedBigInteger('exam_session_id');
            $table->unsignedBigInteger('exam_section_id');
            $table->unsignedBigInteger('section_id');
            $table->dateTime('starts_at')->nullable();
            $table->dateTime('ends_at')->nullable();
            $table->integer('total_time_taken')->default(0);
            $table->integer('current_question')->default(0);
            $table->json('results')->nullable();
            $table->string('status')->default('not_visited')->index();

            $table->primary(['exam_session_id', 'exam_section_id'], 'exam_session_sections_primary');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('exam_session_sections');
    }
}
