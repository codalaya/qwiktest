<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class AddBankFieldsInUsersTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::table('users', function (Blueprint $table) {
            $table->after('mobile', function () use ($table) {
                $table->string('bank_account_no')->nullable();
                $table->string('account_owner_name')->nullable();
                $table->string('bank_account_ifsc')->nullable();
                $table->string('upi_id')->nullable();
                $table->string('preferred_payment_method')->nullable();
            });
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::table('users', function (Blueprint $table) {
            $fields = ['bank_account_no', 'account_owner_name', 'bank_account_ifsc', 'upi_id', 'preferred_payment_method'];
            $table->dropColumn($fields);
        });
    }
}
