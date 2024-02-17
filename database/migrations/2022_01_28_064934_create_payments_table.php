<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePaymentsTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('payments', function (Blueprint $table) {
            $table->id();
            $table->string('payment_id')->unique();
            $table->unsignedBigInteger('plan_id');
            $table->unsignedBigInteger('user_id');
            $table->double('total_amount', 8, 2);
            $table->string('currency')->nullable();
            $table->string('transaction_id')->nullable();
            $table->dateTime('payment_date')->nullable();
            $table->string('invoice_id')->nullable()->index('invoice_id');
            $table->string('refund_id')->nullable();
            $table->string('reference_id')->nullable();
            $table->string('payment_processor');
            $table->json('data')->nullable();
            $table->enum('status', ['created', 'pending', 'success', 'failed', 'cancelled'])->default('created')->index('status');
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
        Schema::dropIfExists('payments');
    }
}
