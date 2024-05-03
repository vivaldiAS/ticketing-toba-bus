<?php

namespace App\Http\Controllers;

use App\Models\Schedule;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class KeuanganController extends Controller
{
    public function index()
    {
        $user = Auth::user()->id;
        $keuangan = DB::table('schedules')
            ->join('bookings', 'bookings.schedules_id', '=', 'schedules.id')
            ->join('payments', 'bookings.id', '=', 'payments.bookings_id')
            ->join('buses', 'buses.id', '=', 'schedules.bus_id')
            ->join('users', 'buses.supir_id', '=', 'users.id')
            ->join('lokets', 'buses.loket_id', '=', 'lokets.id')
            ->where('payments.status', 'Berhasil')
            ->where('lokets.admin_id', $user)
            // ->select('schedules.id', 'buses.id', 'lokets.*')
            // ->where('bookings.user_id', $user)
            ->select(DB::raw('DATE(schedules.tanggal) as tanggal'), DB::raw('SUM(schedules.harga) as total'))
            ->groupBy(DB::raw('DATE(schedules.tanggal)'))
            ->get();


        $total = DB::table('schedules')
            ->join('bookings', 'bookings.schedules_id', '=', 'schedules.id')
            ->join('buses', 'buses.id', '=', 'schedules.bus_id')
            ->join('users', 'buses.supir_id', '=', 'users.id')
            ->join('lokets', 'buses.loket_id', '=', 'lokets.id')
            ->where('lokets.admin_id', $user)
            ->select(DB::raw('DATE(schedules.tanggal) as tanggal'), DB::raw('COUNT(DISTINCT buses.id) as jumlah'))
            ->groupBy(DB::raw('DATE(schedules.tanggal)'))

            ->get();


        return response()->json(['data' => $keuangan, 'total' => $total]);
    }

    public function getByTanggal($tanggal)
    {
        $user = Auth::user()->id;

        $schedule = DB::table('schedules')

            ->join('buses', 'buses.id', '=', 'schedules.bus_id')
            ->join('users', 'buses.supir_id', '=', 'users.id')
            ->join('lokets', 'buses.loket_id', '=', 'lokets.id')
            ->join('users AS AdmLokets', 'lokets.admin_id', '=', 'AdmLokets.id')
            ->join('routes', 'schedules.route_id', '=', 'routes.id')
            ->leftJoin('bookings', 'bookings.schedules_id', '=', 'schedules.id')
            ->join('payments', 'bookings.id', '=', 'payments.bookings_id')
            ->select('schedules.id as schedule_id', 'schedules.tanggal', 'schedules.harga', 'buses.police_number', 'buses.nomor_pintu',  'routes.arrival', 'routes.derpature', 'routes.type', 'lokets.admin_id', 'lokets.nama_loket', 'users.name', 'AdmLokets.name as admin', DB::raw('COUNT(bookings.schedules_id) as jumlah_booking'))
            ->where('lokets.admin_id', $user)
            ->where('payments.status', 'Berhasil')

            ->whereDate('schedules.tanggal', '=', date('Y-m-d', strtotime($tanggal)))
            ->groupBy('schedules.id', 'schedules.tanggal', 'schedules.harga', 'buses.police_number', 'buses.nomor_pintu',  'routes.arrival', 'routes.derpature', 'routes.type', 'users.name', 'lokets.admin_id', 'AdmLokets.name', 'lokets.nama_loket')
            ->get();


        return response()->json(['data' => $schedule]);
    }

    public function getPassenger($id)
    {
        $user = Auth::user()->id;

        $penumpang = DB::table('bookings')
            ->join('schedules', 'bookings.schedules_id', '=', 'schedules.id')
            ->join('users', 'bookings.user_id', '=', 'users.id')
            ->join('buses', 'buses.id', '=', 'schedules.bus_id')
            ->join('lokets', 'buses.loket_id', '=', 'lokets.id')
            ->join('payments', 'bookings.id', 'payments.bookings_id')
            ->join('routes', 'schedules.route_id', '=', 'routes.id')
            ->select('bookings.name', 'bookings.num_seats', 'bookings.number_phone', 'bookings.alamatJemput', 'payments.method', 'routes.harga', 'users.phone_number')
            ->where('lokets.admin_id', $user)
            ->where('payments.status', 'Berhasil')
            ->where('schedules.id', $id)
            ->get();

        return response()->json(['data' => $penumpang]);
    }
}
