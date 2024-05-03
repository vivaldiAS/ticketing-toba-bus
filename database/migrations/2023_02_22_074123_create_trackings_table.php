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
        Schema::create('trackings', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('bus_id'); // kolom ini menunjukkan ID bus yang sedang dilacak
            $table->foreign('bus_id')->references('id')->on('buses');
            $table->decimal('latitude', 10, 8); // kolom ini menunjukkan koordinat latitude bus
            $table->decimal('longitude');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('trackings');
    }
};
