<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SupirController extends Controller
{
    public function index(){
        $user = User::where('role_id', 3)->get();

        return response()->json($user);
    }
    public function getOne(){
        $user = DB::table('users')->where('role_id', 3)->select('name', 'id' ,'status')->get();

        return response($user);
    }
}
