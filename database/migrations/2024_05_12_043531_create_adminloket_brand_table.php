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
        Schema::create('adminloket_brand', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('id_adminloket');
            $table->unsignedBigInteger('brand_id');
            $table->foreign('id_adminloket')->references('id')->on('users');
            $table->foreign('brand_id')->references('id')->on('brands');
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('adminloket_brand');
    }
};
