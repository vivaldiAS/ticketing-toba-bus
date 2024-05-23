<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SupirController extends Controller
{
    public function index(){
        $adminId = auth()->user()->id;
        $user = DB::table('users as u')
                ->join('sopir_brand as sb', 'u.id', '=', 'sb.id_sopir')
                ->join('brands as br', 'br.id', '=', 'sb.brand_id')
                ->where('br.admin_id', $adminId)
                ->select('u.*')
                ->get();
        return response()->json($user);
    }
    public function getOne(){
        $user = DB::table('users')->where('role_id', 3)->select('name', 'id' ,'status')->get();

        return response($user);
    }
}
