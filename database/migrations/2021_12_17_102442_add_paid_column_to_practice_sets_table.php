<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddPaidColumnToPracticeSetsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('practice_sets', function (Blueprint $table) {
            $table->unsignedBigInteger('price')
                ->after('settings')
                ->nullable();
            $table->boolean('is_paid')
                ->after('settings')
                ->default(0);
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('practice_sets', function (Blueprint $table) {
            $table->dropColumn('is_paid');
            $table->dropColumn('price');
        });
    }
}
