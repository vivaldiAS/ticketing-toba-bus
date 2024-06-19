<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use App\Models\Brand;
use App\Models\User;

class DireksiController extends Controller
{
    public function userAll() {
        $users = DB::table('users as u')
            ->leftJoin('bookings as b', 'b.user_id', '=', 'u.id')
            ->leftJoin('payments as p', 'p.bookings_id', '=', 'b.id')
            ->select('u.*', 
                     DB::raw('SUM(CASE WHEN p.status = "Expired" THEN 1 ELSE 0 END) as jumlah_pembayaran_expired'),
                     DB::raw('SUM(CASE WHEN p.status = "Berhasil" THEN 1 ELSE 0 END) as jumlah_pembayaran_berhasil'))
            ->where('u.role_id', 2)
            ->groupBy('u.id')
            ->get();
    
        return response()->json($users);
    }
    
    public function DefaultSchedulesToSchedules()
    {
        try {
            // Menjalankan prosedur tersimpan
            DB::statement('CALL generate_weekly_schedule()');
            return response()->json(['message' => 'Procedure executed successfully.']);
        } catch (\Exception $e) {
            return response()->json(['error' => $e->getMessage()], 500);
        }
    }
    public function brandsyanglogin()
    {
        $adminId = Auth::id();
    
        $data = DB::table('brands')
            ->where('admin_id', $adminId)
            ->get();
    
        return response()->json($data);
    }
    
    public function updateBrandsStatus($id)
    {
        $brand = DB::table('brands')->where('id', $id)->first();
        if ($brand) {
            $newStatus = $brand->status == 1 ? 0 : 1;
            DB::table('brands')
                ->where('id', $id)
                ->update(['status' => $newStatus]);
        }
    }
    public function updateBrands($id)
    {
        $input = request()->validate([
            'merk' => 'required|string',
            'admin_id' => 'required|integer|unique:brands,admin_id,' . $id,
        ]);
    
        $updated = DB::table('brands')
                    ->where('id', $id)
                    ->update([
                        'merk' => $input['merk'],
                        'admin_id' => $input['admin_id'],
                    ]);
    
        if ($updated) {
            $brand = DB::table('brands')->where('id', $id)->first();
            return response()->json(['data' => $brand, 'message' => 'Data Berhasil']);
        } else {
            return response()->json(['message' => 'Brand not found or no change made'], 404);
        }
    }
    public function adminkantorNotAssociated()
    {
        $data = DB::table('users')
            ->leftJoin('brands', 'brands.admin_id', '=', 'users.id')
            ->where('users.role_id', 1)
            ->whereNull('brands.merk')
            ->select('users.*', 'brands.merk')
            ->get();
    
        return response()->json($data);
    }
    
    public function getadminkantor()
    {
        $data = DB::table('users')
            ->where('role_id', 1)
            ->get();

        return response()->json($data);
    }

    public function CountAdminKantor()
    {
        $countUsers = DB::table('users')->where('role_id', 1)->count();
        $countBrands = DB::table('brands')->where('status', 1)->count();
    
        return response()->json([
            'count_users' => $countUsers,
            'count_brands' => $countBrands
        ]);
    }
    public function index()
    {
        if (Auth::check()) {
            // Get the authenticated user's ID
            $user_id = Auth::user()->id;
    
            // Raw SQL query to retrieve combined data
            $combinedData = DB::select(
                DB::raw("
                    SELECT DATE(schedules.tanggal) AS tanggal, 
                           SUM(ppj.total_penghasilan) AS total,
                           COUNT(*) AS jumlah
                    FROM schedules
                    JOIN buses ON buses.id = schedules.bus_id
                    JOIN brands ON brands.id = buses.merk_id
                    JOIN penghasilan_per_jadwal ppj ON ppj.schedule_id = schedules.id
                    WHERE brands.admin_id = :user_id
                    GROUP BY DATE(schedules.tanggal)
                    ORDER BY DATE(schedules.tanggal) DESC
                "), ['user_id' => $user_id]
            );
    
            return response()->json(['data' => $combinedData]);
        } else {
            // If the user is not authenticated, return an unauthorized response
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
            ->join('penghasilan_per_jadwal', 'penghasilan_per_jadwal.schedule_id', '=', 'schedules.id')
            ->select('schedules.id as schedule_id', 'schedules.tanggal', 'schedules.harga', 'buses.police_number', 'buses.nomor_pintu',  'routes.arrival', 'routes.derpature', 'routes.type','penghasilan_per_jadwal.total_penghasilan', 'users.name', DB::raw('COUNT(bookings.schedules_id) as jumlah_booking'))
            ->whereDate('schedules.tanggal', '=', date('Y-m-d', strtotime($tanggal)))
            ->groupBy('schedules.id', 'schedules.tanggal', 'schedules.harga', 'buses.police_number', 'buses.nomor_pintu',  'routes.arrival', 'routes.derpature', 'routes.type', 'users.name')
            ->get();

        return response()->json(['data' => $schedule]);
    }

    public function getPassenger($id)
    {
        // Menjalankan query SQL
        $results = DB::select("
            SELECT 
                bookings.id,
                bookings.name, 
                bookings.num_seats, 
                bookings.number_phone, 
                bookings.alamatJemput, 
                payments.method, 
                payments.amount as harga,
                booking_seats.seat_number,
                SUM(payments.amount) AS total
            FROM 
                bookings
            JOIN 
                users ON bookings.user_id = users.id
            JOIN 
                schedules ON bookings.schedules_id = schedules.id
            JOIN 
                payments ON bookings.id = payments.bookings_id
            JOIN 
                routes ON schedules.route_id = routes.id
            JOIN
                booking_seats ON bookings.id = booking_seats.booking_id
            WHERE 
                schedules.id = ?
            GROUP BY
                bookings.id, bookings.name, bookings.num_seats, bookings.number_phone, bookings.alamatJemput, payments.method, payments.amount, booking_seats.seat_number
        ", [$id]);
    
        // Menggabungkan data berdasarkan ID
        $penumpang = [];
        foreach ($results as $result) {
            // Jika ID sudah ada dalam array, tambahkan nomor kursi ke array seat_number
            if (isset($penumpang[$result->id])) {
                $penumpang[$result->id]->seat_number[] = $result->seat_number;
            } else {
                // Jika ID belum ada, buat entri baru dan tambahkan nomor kursi sebagai array
                $penumpang[$result->id] = (object) [
                    'id' => $result->id,
                    'name' => $result->name,
                    'num_seats' => $result->num_seats,
                    'number_phone' => $result->number_phone,
                    'alamatJemput' => $result->alamatJemput,
                    'method' => $result->method,
                    'harga' => $result->harga,
                    'seat_number' => [$result->seat_number],
                ];
            }
        }
    
        // Mengonversi hasil ke array dan mengembalikan sebagai respons JSON
        return response()->json(['data' => array_values($penumpang)]);
    }
    
    
    public function getAllBrands()
    {
        $brands = DB::table('brands')
        ->join('users', 'brands.admin_id', '=', 'users.id')
        ->select('brands.*', 'users.name', 'users.email')
        ->where('brands.status', 1)
        ->get();

        return Response::json($brands);
    }

    public function getBrandsById($id)
    {
        $brand = DB::table('brands')
            ->join('users', 'brands.admin_id', '=', 'users.id')
            ->select('brands.id', 'brands.merk','brands.admin_id', 'users.name')
            ->where('brands.id', $id)
            ->first();

        if ($brand) {
            return Response::json(['data' => $brand]);
        } else {
            return Response::json(['message' => 'Brand tidak ditemukan'], 404);
        }
    }

}
