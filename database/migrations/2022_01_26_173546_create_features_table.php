<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;
use Illuminate\Support\Facades\DB;

class CreateFeaturesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('features', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('code')->unique();
            $table->string('description')->nullable();
            $table->integer('sort_order')->default(1);
            $table->boolean('is_active')->default(1);
            $table->timestamps();
        });

        DB::table('features')->insert(
            [
                ['name' => 'Practice Sets', 'code' => 'practice_sets', 'sort_order' => 1],
                ['name' => 'Quizzes', 'code' => 'quizzes', 'sort_order' => 2],
                ['name' => 'Lessons', 'code' => 'lessons', 'sort_order' => 3],
                ['name' => 'Videos', 'code' => 'videos', 'sort_order' => 4],
                ['name' => 'Exams', 'code' => 'exams', 'sort_order' => 5]
            ]
        );
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('features');
    }
}
