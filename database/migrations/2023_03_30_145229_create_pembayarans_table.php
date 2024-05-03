<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
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
            $table->unsignedBigInteger('schedules_id');
            $table->foreign('schedules_id')->references('id')->on('schedules');
            $table->unsignedBigInteger('bookings_id');
            $table->foreign('bookings_id')->references('id')->on('bookings');
            $table->string('method');
            $table->string('status');
            $table->string('date');
            $table->string('invoice_number');
            $table->bigInteger('amount');
            $table->string('virtual_account_number');
            $table->timestamps();
            $table->integer('active');
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
};
