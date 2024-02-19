<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddQuizIdFieldInQuizSessionQuestionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('quiz_session_questions', function (Blueprint $table) {
            $table->unsignedBigInteger('quiz_id')->nullable()->after('quiz_session_id');
            $table->unsignedBigInteger('user_id')->nullable()->after('quiz_session_id');

            $table->foreign('quiz_id')->references('id')->on('quizzes')->onDelete('set null');
            $table->foreign('user_id')->references('id')->on('users')->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('quiz_session_questions', function (Blueprint $table) {
            $table->dropColumn(['quiz_id', 'user_id']);
        });
    }
}
