<?php

namespace App\Http\Controllers;

use App\Models\Bookings;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class TicketController extends Controller
{
    public function index($id)
    {
        $tickets = DB::table('bookings')
            ->join('schedules', 'bookings.schedules_id', '=', 'schedules.id')
            ->join('buses', 'schedules.bus_id', '=', 'buses.id')
            ->join('users', 'buses.supir_id', '=', 'users.id')
            ->join('routes', 'schedules.route_id', '=', 'routes.id')
            ->join('payments', 'payments.bookings_id', '=', 'bookings.id')
            ->join('booking_seats as bs', 'bs.booking_id', '=', 'bookings.id')
            ->where('bookings.id', $id)
            ->select(
                'bookings.id as bookings_id', 
                'bookings.name', 
                'bookings.number_phone', 
                'bookings.alamatJemput', 
                'bookings.num_seats', 
                'routes.derpature', 
                'routes.arrival', 
                'buses.nomor_pintu', 
                'buses.type', 
                'schedules.tanggal', 
                'schedules.harga', 
                'payments.status',
                'bs.seat_number'
            )
            ->get();
    
        $result = [];
        
        foreach ($tickets as $ticket) {
            $bookingsId = $ticket->bookings_id;
    
            if (!isset($result[$bookingsId])) {
                $result[$bookingsId] = [
                    'bookings_id' => $ticket->bookings_id,
                    'name' => $ticket->name,
                    'number_phone' => $ticket->number_phone,
                    'alamatJemput' => $ticket->alamatJemput,
                    'num_seats' => $ticket->num_seats,
                    'derpature' => $ticket->derpature,
                    'arrival' => $ticket->arrival,
                    'nomor_pintu' => $ticket->nomor_pintu,
                    'type' => $ticket->type,
                    'tanggal' => $ticket->tanggal,
                    'harga' => $ticket->harga,
                    'status' => $ticket->status,
                    'seat_number' => []
                ];
            }
    
            $result[$bookingsId]['seat_number'][] = $ticket->seat_number;
        }
    
        $response = array_values($result);
    
        return response()->json(['data' => $response, 'message' => 'Ticket Retrieved Successfully']);
    }    
}
