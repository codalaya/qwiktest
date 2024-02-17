<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePlansTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('plans', function (Blueprint $table) {
            $table->id();
            $table->string('code')->unique();
            $table->string('name');
            $table->morphs('category');
            $table->integer('duration');
            $table->unsignedBigInteger('price')->default(0);
            $table->string('currency')->nullable();
            $table->boolean('has_discount')->default(0);
            $table->integer('discount_percentage')->default(0);
            $table->boolean('has_trial')->default(0);
            $table->integer('trial_days')->default(0);
            $table->string('icon', 2048)->nullable();
            $table->string('description')->nullable();
            $table->boolean('feature_restrictions')->default(0);
            $table->json('settings')->nullable();
            $table->unsignedBigInteger('sort_order')->default(1);
            $table->boolean('is_popular')->default(0);
            $table->boolean('is_active')->default(1);
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
        Schema::dropIfExists('plans');
    }
}
