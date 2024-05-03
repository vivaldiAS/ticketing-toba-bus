<?php

namespace App\Http\Controllers;

use App\Models\Bookings;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TicketController extends Controller
{
    public function index($id)
    {
        $ticket = DB::table('bookings')
            ->join('schedules', 'bookings.schedules_id', 'schedules.id')
            ->join('buses', 'schedules.bus_id', 'buses.id')
            ->join('users', 'buses.supir_id', 'users.id')
            ->join('routes', 'schedules.route_id', 'routes.id')
            ->join('payments', 'payments.bookings_id', 'bookings.id')
            ->where('bookings.id', $id)
            ->select('bookings.id as bookings_id', 'bookings.name','bookings.number_phone','bookings.alamatJemput','bookings.num_seats', 'routes.derpature', 'routes.arrival', 'buses.nomor_pintu', 'buses.type', 'schedules.tanggal', 'schedules.harga', 'payments.status')
            ->get();
        return response()->json(['data' => $ticket, 'message' => 'TIcket Retrieved Successfully']);
    }
}
