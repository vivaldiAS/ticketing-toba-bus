<?php

namespace App\Http\Controllers;

use App\Models\bus;
use App\Models\Routes;
use App\Models\User;

class DashboardDireksiController extends Controller
{
    public function CountAll()
{
    try {
        $supir = User::where('role_id', 3)->count();
        $bus = Bus::count();
        $rute = Routes::count();
        
        return response()->json(['supir' => $supir, 'mobil' => $bus, 'rute' => $rute]);
    } catch (\Exception $e) {
        return response()->json(['error' => $e->getMessage()], 404);
    }
}

}
