<?php

namespace App\Http\Controllers;

use App\Models\Pembayaran;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class ConfirmPembayaran extends Controller
{
    public function index()
    {
        $user = Auth::user();

        $pembayaran = DB::table('payments')
            ->join('schedules', 'payments.schedules_id', '=', 'schedules.id')
            ->join('buses', 'buses.id', '=', 'schedules.bus_id')
            ->join('users', 'users.id', '=', 'buses.supir_id')
            ->where('buses.supir_id', $user->id)
            ->join('bookings', 'payments.bookings_id', 'bookings.id')
            ->select('schedules.*', 'buses.*', 'users.name', 'users.email', 'bookings.*')
            ->get();

        return response()->json(['data' => $pembayaran, 'message' => 'data Retrieved Successfully']);
    }
}
