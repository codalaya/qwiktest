<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateExamsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('exams', function (Blueprint $table) {
            $table->id();
            $table->string('title');
            $table->string('slug')->unique();
            $table->string('code')->unique();
            $table->text('description')->nullable();
            $table->integer('exam_type_id');
            $table->enum('exam_mode', ['objective', 'subjective', 'mixed'])->default('objective');
            $table->unsignedBigInteger('sub_category_id');
            $table->unsignedBigInteger('exam_template_id')->nullable();
            $table->double('total_marks', 10, 2)->nullable();
            $table->unsignedInteger('total_duration')->default(0);
            $table->unsignedInteger('total_questions')->default(0);
            $table->boolean('is_paid')->default(0);
            $table->unsignedBigInteger('price')->nullable();
            $table->boolean('can_redeem')->default(0);
            $table->unsignedInteger('points_required')->nullable();
            $table->json('settings')->nullable();
            $table->boolean('is_private')->default(0);
            $table->boolean('is_active')->default(0);
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
        Schema::dropIfExists('exams');
    }
}
