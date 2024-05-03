<?php

namespace App\Http\Controllers;

use App\Models\Pembayaran;
use Illuminate\Http\Request;

class GetApiPembayaran extends Controller
{
    public function index(){
        Pembayaran::all();
    }
}
