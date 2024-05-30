<?php

namespace App\Http\Controllers;

use App\Http\Controllers\API\BaseController;
use App\Models\Bookings;
use App\Models\Schedule;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Carbon\carbon;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Log; // Import Log


class ScheduleController extends BaseController
{
    public function SelectOnes($id)
    {
        $schedule = DB::table('schedules')
        ->join('buses', 'buses.id', '=', 'schedules.bus_id')
        ->join('users', 'buses.supir_id', '=', 'users.id')
        ->join('routes', 'schedules.route_id', '=', 'routes.id')
        ->join('bookings as b', 'b.schedules_id', '=', 'schedules.id')
        ->where('b.id', '=', $id)
        ->select(
            'schedules.id as schedule_id',
            'schedules.tanggal',
            'schedules.harga',
            'schedules.bus_id',
            'schedules.route_id',
            'buses.*',
            'routes.*',
            'users.name',
            'b.id as booking_id'
        )
        ->get();
    
        return $this->sendResponse($schedule, 'Booking Retrieved Successfully');
    }
    public function store(Request $request)
    {
        // Log the incoming request data
        Log::info('Store Schedule Request Data:', $request->all());
    
        $validator = Validator::make($request->all(), [
            'bus_id' => 'required',
            'route_id' => 'required',
            'tanggal' => 'required|date',
            'harga' => 'required|string',
        ], [
            'bus_id.required' => 'Bus harus diisi!',
            'route_id.required' => 'Rute harus diisi!',
            'tanggal.required' => 'Tanggal Harus Di Isi!',
            'tanggal.date' => 'Format Tanggal Salah!',
            'harga.required' => 'Harga harus di isi!'
        ]);
    
        if ($validator->fails()) {
            return $this->sendError('Input tidak boleh kosong', $validator->errors(), 422);
        }
    
        try {
            $input = $request->all();
            $input['status'] = 'not_started';
            Schedule::create($input);
            Log::info('Schedule Created:', $input);
            return $this->sendResponse($input, 'Berhasil Membuat Jadwal Baru');
        } catch (\Exception $e) {
            // Log the exception
            Log::error('Error creating schedule:', ['error' => $e->getMessage()]);
            return response()->json(['error' => 'Internal Server Error'], 500);
        }
    }
    public function ShowAll()
    {
        try {
            // Mendapatkan ID admin yang sedang login
            $adminId = auth()->user()->id;
    
            // Mengambil data jadwal dengan kondisi WHERE
            $schedule = DB::table('schedules')
                ->join('buses', 'buses.id', '=', 'schedules.bus_id')
                ->join('users', 'buses.supir_id', '=', 'users.id')
                ->join('routes', 'schedules.route_id', '=', 'routes.id')
                ->join('lokets', 'buses.loket_id', '=', 'lokets.id')
                ->join('brands', 'buses.merk_id', '=', 'brands.id')
                ->where('brands.admin_id', $adminId)
                ->select('schedules.id as schedule_id', 'schedules.tanggal', 'schedules.status', 'schedules.harga', 'buses.status as status_bus', 'buses.nomor_pintu', 'buses.police_number', 'routes.status as routes_status', 'routes.derpature', 'routes.arrival', 'users.name', 'lokets.nama_loket as loket')
                ->orderBy('schedules.tanggal', 'DESC')
                ->get();
    
            return response()->json(['data' => $schedule]);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 404);
        }
    }
    
    public function index()
    {
        $currentDate = Carbon::now();
        // return $currentDate;
        $schedule = DB::table('schedules')
            ->join('buses', 'buses.id', '=', 'schedules.bus_id')
            ->join('users', 'buses.supir_id', '=', 'users.id')
            ->join('routes', 'schedules.route_id', '=', 'routes.id')
            ->where('schedules.status', "!=", 'complete')
            // ->whereDate('schedules.tanggal', '>', $currentDate)
            ->select('schedules.id as schedule_id', 'schedules.tanggal', 'schedules.harga', 'buses.*', 'routes.*', 'users.name')
            ->orderBy('schedules.tanggal', 'DESC')
            ->get();

        return $this->sendResponse($schedule, 'Schedule Retrieved Successfully');

        $hasBooked = DB::table('schedules')
            ->join('bookings', 'bookings.schedules_id', '=', 'schedules.id')
            ->join('payments', 'payments.bookings_id', 'bookings.id')
            ->join('buses', 'schedules.bus_id', '=', 'buses.id')
            // ->whereDate('schedules.tanggal', '>', $currentDate)
            ->whereIn('payments.status', ['Berhasil', 'Menunggu'])
            ->select('bookings.schedules_id')
            ->get();

        return response()->json(['total' => $hasBooked, 'data' => $schedule]);
    }
    public function showForAdmin()
    {
        $user = Auth::user()->id;
        $currentDate = Carbon::now();

        // return $user;
        $schedule = DB::table('schedules')
            ->join('buses', 'buses.id', '=', 'schedules.bus_id')
            ->join('users', 'buses.supir_id', '=', 'users.id')
            ->join('lokets as lok', 'lok.id', '=', 'buses.loket_id')
            ->join('users as us', 'us.id', '=', 'lok.admin_id')
            ->join('routes', 'schedules.route_id', '=', 'routes.id')
            ->where('lok.admin_id', "=", $user)
            ->where('schedules.status', "!=", 'complete')
            // ->whereDate('schedules.tanggal', '>', $currentDate)

            ->select('schedules.id as schedule_id', 'schedules.tanggal', 'schedules.harga', 'buses.*', 'routes.*', 'users.name', 'lok.admin_id as admin_loket')
            ->orderBy('schedules.tanggal', 'DESC')
            ->get();

        // return $this->sendResponse($schedule, 'Schedule Retrieved Successfully');

        $hasBooked = DB::table('schedules')
            ->join('bookings', 'bookings.schedules_id', '=', 'schedules.id')
            ->join('payments', 'payments.bookings_id', 'bookings.id')
            ->join('buses', 'schedules.bus_id', '=', 'buses.id')
            ->whereIn('payments.status', ['Berhasil', 'Menunggu'])
            // ->whereDate('schedules.tanggal', '>', $currentDate)
            ->select('bookings.schedules_id')
            ->get();

        return response()->json(['total' => $hasBooked, 'data' => $schedule]);
    }
    public function ShowExecutive()
    {
        $schedule = DB::table('schedules')
            ->join('buses', 'buses.id', '=', 'schedules.bus_id')
            ->join('users', 'buses.supir_id', '=', 'users.id')
            ->join('routes', 'schedules.route_id', '=', 'routes.id')
            ->where('buses.type', '=', 'Executive')
            ->where('schedules.status', "!=", 'complete')
            ->select('schedules.id as schedule_id', 'schedules.tanggal', 'schedules.status as status_bus', 'schedules.harga', 'buses.*', 'routes.*', 'users.name')
            ->get();

        $hasBooked = DB::table('schedules')
            ->join('bookings', 'bookings.schedules_id', '=', 'schedules.id')
            ->join('buses', 'schedules.bus_id', '=', 'buses.id')
            ->where('buses.type', "=", 'Executive')
            ->select('bookings.schedules_id')
            ->get();

        return response()->json(['total' => $hasBooked, 'data' => $schedule]);
    }
    public function ShowEconomi()
    {
        $schedule = DB::table('schedules')
            ->join('buses', 'buses.id', '=', 'schedules.bus_id')
            ->join('users', 'buses.supir_id', '=', 'users.id')
            ->join('routes', 'schedules.route_id', '=', 'routes.id')
            ->where('schedules.status', "!=", 'complete')
            // ->join('bookings', 'bookings.schedules_id', '=', 'schedules.id')
            ->where('buses.type', '=', 'Economi')
            ->select('schedules.id as schedule_id', 'schedules.tanggal', 'schedules.status as status_bus', 'schedules.harga',  'buses.*', 'routes.*', 'users.name')
            ->get();

        $hasBooked = DB::table('schedules')
            ->join('bookings', 'bookings.schedules_id', '=', 'schedules.id')
            ->join('buses', 'schedules.bus_id', '=', 'buses.id')
            ->where('buses.type', "=", 'Economi')
            ->select('bookings.schedules_id')
            ->get();

        return response()->json(['total' => $hasBooked, 'data' => $schedule]);
    }
    //get by id schedule
    public function SelectOne($id)
    {
        $schedule = DB::table('schedules')
            ->join('buses', 'buses.id', '=', 'schedules.bus_id')
            ->join('users', 'buses.supir_id', '=', 'users.id')
            ->join('routes', 'schedules.route_id', '=', 'routes.id')
            // ->where('buses.type', '=', 'Ekonomi')
            ->where('schedules.id', '=', $id)
            ->select('schedules.id as schedule_id', 'schedules.tanggal', 'schedules.harga', 'schedules.bus_id', 'schedules.route_id', 'buses.*', 'routes.*', 'users.name')
            ->get();

        return $this->sendResponse($schedule, 'Schedule Retrieved Successfully');
    }
    // get by id supir

    public function getForSupir()
    {
        $user = Auth::user()->id;

        $schedule = DB::table('schedules')
            ->join('buses', 'buses.id', '=', 'schedules.bus_id')
            ->join('users', 'buses.supir_id', '=', 'users.id')
            ->join('routes', 'schedules.route_id', '=', 'routes.id')
            ->where('users.role_id', '=', 3)
            ->where('users.status', '=', 1)
            ->where('buses.status', '=', 1)
            ->where('routes.status', '=', 1)
            ->where('buses.supir_id', '=', $user)
            // ->where('schedules.status', 'complete')
            ->select('schedules.id as schedule_id', 'schedules.tanggal', 'schedules.harga', 'schedules.status as schedules_status', 'buses.id as bus_id', 'buses.*', 'routes.*', 'users.name')
            ->get();



        return response()->json(['data' => $schedule]);
    }
    public function update($id)
    {
        $schedule = Schedule::find($id);
        if (!$schedule) {
            return response()->json(['message' => 'Route not found.'], 404);
        }
        $input = $this->validate(request(), [
            'tanggal' => 'required|numeric|min:0',
            'harga' => 'required|numeric|min:0',
            'bus_id' => 'required|numeric|exists:buses,id',
            'route_id' => 'required|numeric|exists:routes,id',
            'status' => 'required|numeric|exists:schedules,status',
        ]);
        $schedule->update($input);
        return $this->sendResponse($schedule, 'Schedule Updated Successfully');
    }

    public function UpdateStatusBus($id)
    {
        $s = Schedule::find($id);
        if (!$s) {
            return response()->json(['message' => 'Route not found.'], 404);
        }
        if ($s->status == "not_started") {
            $s->status = "in_progress";
            $s->save();
        } elseif ($s->status == "in_progress") {
            $s->status = "complete";
            $s->save();
        } else {
            $s->status = "not_started";
            $s->save();
        }
        return $this->sendResponse($s, 'Satus has been update');
    }
    public function UpdateStatusAuto($id)
    {
        $s = Schedule::find($id);
        if (!$s) {
            return response()->json(['message' => 'Route not found.'], 404);
        }
        $dateBus = $s->tanggal;
        $carbonDate = Carbon::parse($dateBus)->addDay();

        if ($dateBus < $carbonDate) {
            $s->status = "complete";
            $s->save();
        }
    }
}
