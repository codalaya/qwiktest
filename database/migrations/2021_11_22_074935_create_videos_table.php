<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateVideosTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('videos', function (Blueprint $table) {
            $table->id();
            $table->string('code')->unique();
            $table->string('title');
            $table->string('video_type')->default('mp4');
            $table->string('video_link');
            $table->string('thumbnail', 2048)->nullable();
            $table->text('description')->nullable();
            $table->unsignedInteger('duration')->default(1);
            $table->unsignedBigInteger('skill_id');
            $table->unsignedBigInteger('topic_id')->nullable();
            $table->unsignedBigInteger('difficulty_level_id')->default(1);
            $table->json('preferences')->nullable();
            $table->integer('avg_watch_time')->default(0);
            $table->unsignedBigInteger('total_views')->default(0);
            $table->boolean('is_paid')->default(0);
            $table->boolean('is_active')->default(1);
            $table->timestamps();
            $table->softDeletes();

            $table->foreign('skill_id')
                ->references('id')->on('skills')
                ->onDelete('restrict');

            $table->foreign('topic_id')
                ->references('id')->on('topics')
                ->onDelete('restrict');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('videos');
    }
}
