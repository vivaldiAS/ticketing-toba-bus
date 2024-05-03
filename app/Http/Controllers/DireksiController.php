<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Models\Brand;

class DireksiController extends Controller
{
    public function index()
    {
        // Periksa apakah pengguna telah diautentikasi
        if (Auth::check()) {
            // Jika pengguna telah diautentikasi, dapatkan ID-nya
            $user_id = Auth::user()->id;
    
            $keuangan = DB::table('schedules')
                ->join('bookings', 'bookings.schedules_id', '=', 'schedules.id')
                ->join('buses', 'buses.id', '=', 'schedules.bus_id')
                ->join('users', 'buses.supir_id', '=', 'users.id')
                ->join('lokets', 'buses.loket_id', '=', 'lokets.id')
                ->select(DB::raw('DATE(schedules.tanggal) as tanggal'), DB::raw('SUM(schedules.harga) as total'))
                ->groupBy(DB::raw('DATE(schedules.tanggal)'))
                ->get();
    
            $total = DB::table('schedules')
                ->join('bookings', 'bookings.schedules_id', '=', 'schedules.id')
                ->join('buses', 'buses.id', '=', 'schedules.bus_id')
                ->join('users', 'buses.supir_id', '=', 'users.id')
                ->join('lokets', 'buses.loket_id', '=', 'lokets.id')
                ->select(DB::raw('DATE(schedules.tanggal) as tanggal'), DB::raw('COUNT(DISTINCT buses.id) as jumlah'))
                ->groupBy(DB::raw('DATE(schedules.tanggal)'))
                ->get();
    
            return response()->json(['data' => $keuangan, 'total' => $total]);
        } else {
            // Jika pengguna tidak diautentikasi, berikan respons yang sesuai
            return response()->json(['message' => 'Unauthorized'], 401);
        }
    }
    

    public function getByTanggal(Request $request, $tanggal)
    {
        $schedule = DB::table('schedules')
            ->join('buses', 'buses.id', '=', 'schedules.bus_id')
            ->join('users', 'buses.supir_id', '=', 'users.id')
            ->join('routes', 'schedules.route_id', '=', 'routes.id')
            ->leftJoin('bookings', 'bookings.schedules_id', '=', 'schedules.id')
            ->select('schedules.id as schedule_id', 'schedules.tanggal', 'schedules.harga', 'buses.police_number', 'buses.nomor_pintu',  'routes.arrival', 'routes.derpature', 'routes.type', 'users.name', DB::raw('COUNT(bookings.schedules_id) as jumlah_booking'))
            ->whereDate('schedules.tanggal', '=', date('Y-m-d', strtotime($tanggal)))
            ->groupBy('schedules.id', 'schedules.tanggal', 'schedules.harga', 'buses.police_number', 'buses.nomor_pintu',  'routes.arrival', 'routes.derpature', 'routes.type', 'users.name',)
            ->get();

        return response()->json(['data' => $schedule]);
    }

    public function getPassenger($id)
    {
        $penumpang = DB::table('bookings')
            ->join('users', 'bookings.user_id', '=', 'users.id')
            ->join('schedules', 'bookings.schedules_id', '=', 'schedules.id')
            ->join('payments', 'bookings.id', 'payments.bookings_id')
            ->join('routes', 'schedules.route_id', '=', 'routes.id')
            ->select('bookings.name', 'bookings.num_seats', 'bookings.number_phone', 'bookings.alamatJemput', 'payments.method', 'routes.harga')
            ->where('bookings.id', '=', $id)
            ->get();

        return response()->json(['data' => $penumpang]);
    }


    public function getAllBrands()
    {
        $brands = DB::table('brands')
        ->join('users', 'brands.admin_id', '=', 'users.id')
        ->select('brands.id', 'brands.merk', 'brands.gambar_qris', 'brands.admin_id', 'users.name')
        ->get();

        return Response::json(['data' => $brands]);
    }

    public function getBrandsById($id)
    {
        $brand = DB::table('brands')
            ->join('users', 'brands.admin_id', '=', 'users.id')
            ->select('brands.id', 'brands.merk', 'brands.gambar_qris', 'brands.admin_id', 'users.name')
            ->where('brands.id', $id)
            ->first();

        if ($brand) {
            return Response::json(['data' => $brand]);
        } else {
            return Response::json(['message' => 'Brand tidak ditemukan'], 404);
        }
    }

}
