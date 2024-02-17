<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddColumnsToQuizTypesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('quiz_types', function (Blueprint $table) {
            $table->string('image_path')
                ->after('description')
                ->default('http://placehold.it/100x100')
                ->nullable();

            $table->string('color')
                ->after('description')
                ->default('444444')
                ->nullable();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('quiz_types', function (Blueprint $table) {
            $table->dropColumn('image_path', 'color');
        });
    }
}
