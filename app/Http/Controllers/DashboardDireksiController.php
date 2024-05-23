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
            // Mendapatkan ID admin yang sedang login
            $adminId = auth()->user()->id;
    
            // Menghitung jumlah supir berdasarkan query yang diminta
            $supir = User::join('buses', 'users.id', '=', 'buses.supir_id')
                         ->join('brands', 'buses.merk_id', '=', 'brands.id')
                         ->where('brands.admin_id', $adminId)
                         ->count();
    
            // Menghitung jumlah bus dan rute
            $bus = Bus::join('brands', 'buses.merk_id', '=', 'brands.id')
                  ->where('brands.admin_id', $adminId)
                  ->count();
            
                  $rute = Routes::join('brands', 'routes.brand_id', '=', 'brands.id')
                  ->where('brands.admin_id', $adminId)
                  ->count();
            
            return response()->json(['supir' => $supir, 'mobil' => $bus, 'rute' => $rute]);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 404);
        }
    }
    

}
