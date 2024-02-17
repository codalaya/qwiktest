<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddSnoColumnToQuizSessionQuestionsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('quiz_session_questions', function (Blueprint $table) {
            $table->unsignedBigInteger('sno')
                ->after('quiz_session_id')
                ->default(1);
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
            $table->dropColumn('sno');
        });
    }
}
