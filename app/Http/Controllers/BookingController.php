<?php

namespace App\Http\Controllers;

use App\Http\Controllers\API\BaseController;
use App\Models\Bookings;
use App\Models\bus;
use App\Models\Pembayaran;
use App\Models\Routes;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Log;
use Midtrans;

class BookingController extends BaseController
{
    public function callback(Request $request){
        $serverKey = 'SB-Mid-server-KX7YOOfRPU6gJaUd-x3spaFu';
        $hashed = hash('sha512', $request->order_id.$request->status_code.$request->gross_amount.$serverKey);
    
        if($hashed == $request->signature_key){
            if($request->transaction_status == 'capture' || $request->transaction_status == 'settlement'){
                // Mengupdate status pembayaran menjadi 'Berhasil' di tabel payments
                DB::table('payments')
                    ->where('id', $request->order_id)
                    ->update(['status' => 'Berhasil']);
            }
        }
    }
    public function bookingMidtrans(Request $request)
    {
        Log::info('Incoming request data:', $request->all());
    
        $validator = Validator::make($request->all(), [
            'user_id' => 'required|integer',
            'schedules_id' => 'required|integer',
            'name' => 'required|string',
            'alamatJemput' => 'required|string',
            'num_seats' => 'required|array',
            'num_seats.*' => 'integer',
            'number_phone' => 'required|string',
            'harga' => 'required|integer',
            'status' => 'required|integer',
            'email' => 'nullable|email',
        ]);
    
        if ($validator->fails()) {
            Log::error('Validation failed:', $validator->errors()->toArray());
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors(),
            ], 422);
        }
    
        try {
            DB::beginTransaction();
    
            Log::info('Saving booking data');
    
            $bookingId = DB::table('bookings')->insertGetId([
                'user_id' => $request->input('user_id'),
                'schedules_id' => $request->input('schedules_id'),
                'name' => $request->input('name'),
                'alamatJemput' => $request->input('alamatJemput'),
                'num_seats' => count($request->input('num_seats')),
                'number_phone' => $request->input('number_phone'),
                'seats' => 0,
                'status' => 0,
                'created_at' => now()->addHours(7),
                'updated_at' => now()->addHours(7),
            ]);
    
            Log::info('Booking data saved', ['booking_id' => $bookingId]);
    
            $seatNumbers = $request->input('num_seats');
            $bookingSeats = [];
            foreach ($seatNumbers as $seatNumber) {
                $bookingSeats[] = [
                    'booking_id' => $bookingId,
                    'seat_number' => $seatNumber,
                ];
            }
    
            Log::info('Saving booking seats data');
            DB::table('booking_seats')->insert($bookingSeats);
    
            Log::info('Saving payment data');
    
            $invoiceNumber = "INV-EKBT-" . time();
            $expiredDate = now()->addHours(7)->addHour();
    
            $paymentId = DB::table('payments')->insertGetId([
                'schedules_id' => $request->input('schedules_id'),
                'bookings_id' => $bookingId,
                'method' => 'noncash',
                'status' => 'menunggu',
                'amount' => $request->input('harga'),
                'created_date' => now()->addHours(7),
                'expired_date' => $expiredDate,
                'how_to_pay_page' => 'null',
                'how_to_pay_api' => 'null',
                'invoice_number' => $invoiceNumber,
                'virtual_account_number' => 'null',
                'updated_at' => now()->addHours(7),
                'active' => 0,
            ]);
    
            DB::commit();
    
            Log::info('Booking and payment transaction committed');
    
            // Midtrans integration
            $user = Auth::user();
    
            \Midtrans\Config::$serverKey = 'SB-Mid-server-KX7YOOfRPU6gJaUd-x3spaFu';
            \Midtrans\Config::$isProduction = false;
            \Midtrans\Config::$isSanitized = true;
            \Midtrans\Config::$is3ds = true;
    
            $params = [
                'transaction_details' => [
                    'order_id' => $paymentId,
                    'gross_amount' => $request->input('harga'),
                ],
                'customer_details' => [
                    'first_name' => $user->name,
                    'last_name' => '',
                    'phone' => $user->phone_number,
                ],
            ];
    
            $snapToken = \Midtrans\Snap::getSnapToken($params);
    
            DB::table('payments')->where('id', $paymentId)->update([
                'snap_token' => $snapToken,
            ]);
    
            return response()->json([
                'message' => 'Booking created successfully',
                'data' => [
                    'booking_id' => $bookingId,
                    'booking_seats' => $bookingSeats,
                    'payment_id' => $paymentId,
                    'snap_token' => $snapToken,
                ],
            ], 201);
        } catch (\Throwable $e) {
            DB::rollBack();
            Log::error('Exception during booking creation:', [
                'message' => $e->getMessage(),
                'trace' => $e->getTraceAsString(),
            ]);
            return response()->json([
                'message' => 'Failed to create booking',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
    public function cancelBooking(Request $request)
    {
        $paymentId = $request->input('payment_id');

        DB::table('payments')
            ->where('id', $paymentId)
            ->update(['status' => 'Expired']);

        return response()->json(['message' => 'Payment status updated to expired'], 200);
    }
    public function confirmBooking(Request $request)
    {
        $paymentId = $request->input('payment_id');
    
        try {
            if (empty($paymentId)) {
                throw new \Exception('Payment ID is missing');
            }
    
            $affectedRows = DB::table('payments')
                ->where('id', $paymentId)
                ->update(['status' => 'Berhasil']);
    
            if ($affectedRows === 0) {
                throw new \Exception('Payment ID not found');
            }
    
            Log::info('Payment status updated successfully', ['payment_id' => $paymentId]);
    
            return response()->json(['message' => 'Payment status updated successfully'], 200);
        } catch (\Exception $e) {
            Log::error('Error updating payment status', [
                'payment_id' => $paymentId,
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
    
            return response()->json(['message' => 'An error occurred while updating payment status', 'error' => $e->getMessage()], 500);
        }
    }
    public function PesananOnlineBySchedulesID($id)
    {
        $bookings = DB::table('bookings as b')
            ->join('schedules as s', 's.id', '=', 'b.schedules_id')
            ->join('booking_seats as bs', 'bs.booking_id', '=', 'b.id')
            ->leftJoin('payments as p', 'p.bookings_id', '=', 'b.id')
            ->select(
                'b.id', 
                'b.user_id', 
                'b.name', 
                'b.alamatJemput', 
                'b.num_seats', 
                'b.number_phone', 
                's.bus_id', 
                's.tanggal', 
                's.harga', 
                'bs.seat_number',
                'p.id as payment_id',
                'p.method as payment_method', 
                'p.status as payment_status', 
                'p.invoice_number'
            )
            ->where('s.id', $id)
            ->whereIn('p.status', ['menunggu', 'berhasil'])
            ->get();
    
        $groupedBookings = [];
    
        foreach ($bookings as $booking) {
            if (!isset($groupedBookings[$booking->id])) {
                $groupedBookings[$booking->id] = [
                    'id' => $booking->id,
                    'user_id' => $booking->user_id,
                    'name' => $booking->name,
                    'alamatJemput' => $booking->alamatJemput,
                    'num_seats' => $booking->num_seats,
                    'number_phone' => $booking->number_phone,
                    'bus_id' => $booking->bus_id,
                    'tanggal' => $booking->tanggal,
                    'harga' => $booking->harga,
                    'seat_number' => [],
                    'payment_id' => $booking->payment_id,
                    'payment_method' => $booking->payment_method,
                    'payment_status' => $booking->payment_status,
                    'invoice_number' => $booking->invoice_number
                ];
            }
    
            $groupedBookings[$booking->id]['seat_number'][] = $booking->seat_number;
        }
    
        // Ubah array asosiatif menjadi array biasa
        $groupedBookings = array_values($groupedBookings);
    
        return response()->json($groupedBookings);
    } 
    public function showBokingTunaiOnline()
    {
        // Ambil ID user yang sedang login
        $userId = Auth::id();

        $data = DB::table('schedules as s')
            ->join('buses as b', 'b.id', '=', 's.bus_id')
            ->join('lokets as l', 'l.id', '=', 'b.loket_id')
            ->select('s.*', 'l.id as loket_id', 'l.nama_loket', 'b.police_number', 'b.nomor_pintu')
            ->where('l.admin_id', $userId)
            ->where('s.status', 'not_started')
            ->get();

        // Kembalikan data dalam format JSON
        return response()->json($data);
    }
    public function bookingBayarTunai(Request $request)
    {
        Log::info('Incoming request data:', $request->all());
    
        $validator = Validator::make($request->all(), [
            'user_id' => 'required|integer',
            'schedules_id' => 'required|integer',
            'name' => 'required|string',
            'alamatJemput' => 'required|string',
            'num_seats' => 'required|array',
            'num_seats.*' => 'integer',
            'number_phone' => 'required|string',
            'harga' => 'required|integer',
            'status' => 'required|integer',
            'email' => 'nullable|email',
        ]);
    
        if ($validator->fails()) {
            Log::error('Validation failed:', $validator->errors()->toArray());
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors(),
            ], 422);
        }
    
        try {
            DB::beginTransaction();
    
            Log::info('Saving booking data');
    
            $bookingId = DB::table('bookings')->insertGetId([
                'user_id' => $request->input('user_id'),
                'schedules_id' => $request->input('schedules_id'),
                'name' => $request->input('name'),
                'alamatJemput' => $request->input('alamatJemput'),
                'num_seats' => count($request->input('num_seats')),
                'number_phone' => $request->input('number_phone'),
                'seats' => 0,
                'status' => 0,
                'created_at' => now()->addHours(7),
                'updated_at' => now()->addHours(7),
            ]);
    
            Log::info('Booking data saved', ['booking_id' => $bookingId]);
    
            $seatNumbers = $request->input('num_seats');
            $bookingSeats = [];
            foreach ($seatNumbers as $seatNumber) {
                $bookingSeats[] = [
                    'booking_id' => $bookingId,
                    'seat_number' => $seatNumber,
                ];
            }
    
            Log::info('Saving booking seats data');
            DB::table('booking_seats')->insert($bookingSeats);
    
            Log::info('Saving payment data');
    
            $invoiceNumber = "INV-EKBT-" . time();
            $expiredDate = now()->addHours(7)->addHour();
    
            $paymentId = DB::table('payments')->insertGetId([
                'schedules_id' => $request->input('schedules_id'),
                'bookings_id' => $bookingId,
                'method' => 'cash',
                'status' => 'menunggu',
                'amount' => $request->input('harga'),
                'created_date' => now()->addHours(7),
                'expired_date' => $expiredDate,
                'how_to_pay_page' => 'null',
                'how_to_pay_api' => 'null',
                'invoice_number' => $invoiceNumber,
                'virtual_account_number' => 'null',
                'updated_at' => now()->addHours(7),
                'active' => 0,
            ]);
    
            DB::commit();
    
            Log::info('Booking and payment transaction committed');
            return response()->json([
                'message' => 'Booking created successfully',
                'data' => [
                    'booking_id' => $bookingId,
                    'booking_seats' => $bookingSeats,
                    'payment_id' => $paymentId,
                ],
            ], 201);
        } catch (\Throwable $e) {
            DB::rollBack();
            Log::error('Exception during booking creation:', [
                'message' => $e->getMessage(),
                'trace' => $e->getTraceAsString(),
            ]);
            return response()->json([
                'message' => 'Failed to create booking',
                'error' => $e->getMessage(),
            ], 500);
        }
    }

    public function store(Request $request)
    {
        Log::info('Incoming request data:', $request->all());
    
        $validator = Validator::make($request->all(), [
            'user_id' => 'required|integer',
            'schedules_id' => 'required|integer',
            'name' => 'required|string',
            'alamatJemput' => 'required|string',
            'num_seats' => 'required|array',
            'num_seats.*' => 'integer',
            'number_phone' => 'required|string',
            'harga' => 'required|integer',
            'status' => 'required|integer',
            'email' => 'nullable|email',
        ]);
    
        if ($validator->fails()) {
            Log::error('Validation failed:', $validator->errors()->toArray());
            return response()->json([
                'message' => 'Validation failed',
                'errors' => $validator->errors(),
            ], 422);
        }
    
        try {
            DB::beginTransaction();
    
            Log::info('Saving booking data');
    
            $bookingId = DB::table('bookings')->insertGetId([
                'user_id' => $request->input('user_id'),
                'schedules_id' => $request->input('schedules_id'),
                'name' => $request->input('name'),
                'alamatJemput' => $request->input('alamatJemput'),
                'num_seats' => count($request->input('num_seats')),
                'number_phone' => $request->input('number_phone'),
                'seats' => 0,
                'status' => $request->input('status'),
                'created_at' => now()->addHours(7),
                'updated_at' => now()->addHours(7),
            ]);
    
            Log::info('Booking data saved', ['booking_id' => $bookingId]);
    
            // Simpan data kursi di sini
            $seatNumbers = $request->input('num_seats');
            $bookingSeats = [];
            foreach ($seatNumbers as $seatNumber) {
                $bookingSeats[] = [
                    'booking_id' => $bookingId,
                    'seat_number' => $seatNumber,
                ];
            }
    
            Log::info('Saving booking seats data');
            DB::table('booking_seats')->insert($bookingSeats);
    
            Log::info('Booking seats data saved');
    
            // Simpan data pembayaran di sini
            $paymentId = DB::table('payments')->insertGetId([
                'schedules_id' => $request->input('schedules_id'),
                'bookings_id' => $bookingId,
                'method' => 'cash', // Ganti dengan metode pembayaran yang sesuai
                'status' => 'Berhasil',
                'amount' => $request->input('harga'),
                'created_date' => now()->addHours(7),
                'expired_date' => now()->addHours(7)->addHour(),
                'invoice_number' => "INV-EKBT-" . time(),
                'updated_at' => now()->addHours(7),
                'active' => 0,
            ]);
    
            Log::info('Payment data saved', ['payment_id' => $paymentId]);
    
            DB::commit();
    
            Log::info('Booking and payment transaction committed');
            return response()->json([
                'message' => 'Booking and payment created successfully',
                'data' => [
                    'booking_id' => $bookingId,
                    'booking_seats' => $bookingSeats,
                    'payment_id' => $paymentId,
                ],
            ], 201);
        } catch (\Throwable $e) {
            DB::rollBack();
            Log::error('Exception during booking and payment creation:', [
                'message' => $e->getMessage(),
                'trace' => $e->getTraceAsString(),
            ]);
            return response()->json([
                'message' => 'Failed to create booking and payment',
                'error' => $e->getMessage(),
            ], 500);
        }
    }
    
    public function index()
    {
        $booking = Bookings::with('schedules', 'user')->get();

        if ($booking) {
            return response()->json($booking);
        } else {
            return response()->json(['message' => 'Booking not found.'], 404);
        }
    }
    public function getOne($id)
    {
        $booking = Bookings::with('schedules', 'user')->where('id', $id)->get();

        if ($booking) {
            return response()->json($booking);
        } else {
            return response()->json(['message' => 'Booking not found.'], 404);
        }
    }
    public function getByUserId()
    {
        $user = Auth::user();
    
        $booking = DB::table('bookings')
            ->join('schedules', 'bookings.schedules_id', 'schedules.id')
            ->join('buses', 'schedules.bus_id', 'buses.id')
            ->join('users', 'buses.supir_id', 'users.id')
            ->join('routes', 'schedules.route_id', 'routes.id')
            ->join('payments', 'payments.bookings_id', 'bookings.id')
            ->where('bookings.user_id', $user->id)
            ->where(function ($query) {
                $query->where('payments.status', '=', 'Menunggu')
                    ->orWhere('payments.status', '=', 'Berhasil');
            })
            ->select(
                'payments.id as pembayarans_id',
                'bookings.id as bookings_id',
                'bookings.created_at',
                'schedules.id as schedule_id',
                'routes.derpature',
                'routes.arrival',
                'buses.nomor_pintu',
                'buses.type',
                'buses.number_of_seats',
                'schedules.tanggal',
                'users.name',
                'schedules.harga',
                'schedules.status',
                'payments.status as status_pay',
                'payments.how_to_pay_page',
                'payments.how_to_pay_api',
                'payments.created_date',
                'payments.expired_date',
                'payments.method'
            )
            ->orderBy('bookings.created_at', 'DESC')
            ->get();
    
        if ($booking->isNotEmpty()) {
            return response()->json($booking);
        } else {
            return response()->json(['message' => 'Booking not found.'], 404);
        }
    }
    public function getriwayat()
{
    $user = Auth::user();

    $bookings = DB::select("
        SELECT 
            payments.id AS pembayarans_id,
            bookings.id AS bookings_id,
            bookings.created_at,
            schedules.id AS schedule_id,
            routes.derpature,
            routes.arrival,
            buses.nomor_pintu,
            buses.type,
            buses.number_of_seats,
            schedules.tanggal,
            users.name,
            schedules.harga,
            schedules.status AS jadwalstatus,
            payments.status AS status_pay,
            payments.how_to_pay_page,
            payments.how_to_pay_api,
            payments.created_date,
            payments.expired_date
        FROM
            bookings
                INNER JOIN
            schedules ON bookings.schedules_id = schedules.id
                INNER JOIN
            buses ON schedules.bus_id = buses.id
                INNER JOIN
            users ON buses.supir_id = users.id
                INNER JOIN
            routes ON schedules.route_id = routes.id
                INNER JOIN
            payments ON payments.bookings_id = bookings.id
        WHERE
            bookings.user_id = ?
                AND (payments.status = 'Menunggu'
                OR payments.status = 'Berhasil')
                AND schedules.status = 'complete'
        ORDER BY bookings.created_at DESC
    ", [$user->id]);

    if (!empty($bookings)) {
        return response()->json($bookings);
    } else {
        return response()->json(['message' => 'Booking not found.'], 404);
    }
}
    public function getOneSchedules($id)
    {
        $bookings = DB::table('bookings')
            ->join('schedules', 'bookings.schedules_id', '=', 'schedules.id')
            ->join('buses', 'schedules.bus_id', '=', 'buses.id')
            ->join('routes', 'schedules.route_id', '=', 'routes.id')
            ->join('payments', 'payments.bookings_id', '=', 'bookings.id')
            ->join('booking_seats as bs', 'bs.booking_id', '=', 'bookings.id')
            ->where('schedules.id', $id)
            ->whereIn('payments.status', ['Berhasil', 'Menunggu'])
            ->select(
                'bookings.*', 
                'schedules.id as schedule_id', 
                'routes.derpature', 
                'routes.arrival', 
                'buses.nomor_pintu', 
                'buses.type', 
                'buses.number_of_seats', 
                'schedules.tanggal', 
                'schedules.harga', 
                'schedules.status as schedule_status', 
                'payments.method', 
                'payments.status as status_pembayaran',
                'bs.seat_number'
            )
            ->get();
    
        // Mengelompokkan hasil berdasarkan 'id' dan menggabungkan 'seat_number' dalam array
        $groupedBookings = $bookings->groupBy('id')->map(function ($group) {
            $first = $group->first();
    
            return [
                'id' => $first->id,
                'user_id' => $first->user_id,
                'schedules_id' => $first->schedules_id,
                'name' => $first->name,
                'alamatJemput' => $first->alamatJemput,
                'num_seats' => $first->num_seats,
                'number_phone' => $first->number_phone,
                'status' => $first->status,
                'created_at' => $first->created_at,
                'updated_at' => $first->updated_at,
                'derpature' => $first->derpature,
                'arrival' => $first->arrival,
                'nomor_pintu' => $first->nomor_pintu,
                'type' => $first->type,
                'number_of_seats' => $first->number_of_seats,
                'tanggal' => $first->tanggal,
                'harga' => $first->harga,
                'method' => $first->method,
                'status_pembayaran' => $first->status_pembayaran,
                'schedule_status' => $first->schedule_status, // Tambahkan ini untuk mengembalikan status schedule
                'seat_numbers' => $group->pluck('seat_number')->all(),
            ];
        });
    
        $num_of_bookings = $groupedBookings->count();
        if ($num_of_bookings > 0) {
            return response()->json(['total' => $num_of_bookings, 'data' => $groupedBookings->values()->all()]);
        } else {
            return response()->json(['message' => 'Booking not found.'], 404);
        }
    }
    public function WaitPayment($id)
    {
        $wait = DB::table('bookings')
            ->join('schedules', 'bookings.schedules_id', 'schedules.id')
            ->join('buses', 'schedules.bus_id', 'buses.id')
            ->join('routes', 'schedules.route_id', 'routes.id')
            ->join('payments', 'payments.bookings_id', 'bookings.id')
            ->where('schedules.id', $id)
            ->where('payments.status', 'Menunggu')
            ->select('bookings.*', 'schedules.id', 'routes.derpature', 'routes.arrival', 'buses.nomor_pintu', 'buses.type', 'buses.number_of_seats', 'schedules.tanggal', 'schedules.harga', 'schedules.status', 'payments.method', 'payments.status as status_pembayaran')
            ->get();

        $num_of_bookings = $wait->count();
        if ($wait) {
            return response()->json(['total' => $num_of_bookings, 'data' => $wait]);
        } else {
            return response()->json(['message' => 'Booking not found.'], 404);
        }
    }
    public function update($id)
    {
        $booking = Bookings::find($id);
        return $this->sendResponse($booking, 'Booking Retrieved Successfully');
    }
    public function expiredCheck($id)
    {
        $pembayaran = Pembayaran::find($id);

        if (!$pembayaran && $pembayaran != 'Expired') {
            return $this->sendResponse(null, 'Pembayaran Not Found');
        }
        $pembayaran->status = 'Expired';
        $pembayaran->save();
        return response()->json(['data' => $pembayaran, 'message' => 'update berhasil']);
    }
}
