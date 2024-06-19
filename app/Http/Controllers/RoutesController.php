<?php

namespace App\Http\Controllers;

use App\Http\Controllers\API\BaseController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Validator;
use App\Models\r;
use App\Models\Routes;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;


class RoutesController extends BaseController
{
    public function showRoutesBusByAdminId()
    {
        try {
            // Pastikan pengguna telah terautentikasi
            if (Auth::check()) {
                // Dapatkan ID admin yang sedang login
                $adminId = Auth::id();
    
                // Menampilkan rute berdasarkan admin yang sedang login
                $routes = DB::table('routes')
                            ->select('routes.id', 'routes.derpature', 'routes.arrival', 'routes.harga', 'routes.type', 'routes.status')
                            ->join('brands', 'routes.brand_id', '=', 'brands.id')
                            ->where('brands.admin_id', $adminId)
                            ->get();
    
                // Membungkus data dalam array dengan kunci "data"
                $data = ["data" => $routes];
    
                // Mengembalikan data rute
                return response()->json($data);
            } else {
                // Pengguna belum terautentikasi, mungkin perlu diarahkan ke halaman login
                return response()->json(['message' => 'Unauthorized'], 401);
            }
        } catch (\Exception $e) {
            // Jika terjadi kesalahan, kembalikan respons dengan pesan kesalahan yang spesifik
            return response()->json(['message' => 'Error retrieving routes.', 'error' => $e->getMessage()], 500);
        }
    }
    public function getLokasiLoket()
    {
        // Dapatkan ID dari user yang sedang login
        $adminId = Auth::id();

        // Jalankan query untuk mendapatkan lokasi_loket
        $lokasiLoket = DB::table('lokets as l')
            ->join('brands as b', 'b.id', '=', 'l.brand_id')
            ->where('b.admin_id', $adminId)
            ->pluck('l.lokasi_loket');

        // Return data (sesuaikan dengan kebutuhan Anda, misalnya return sebagai JSON)
        return response()->json($lokasiLoket);
    }
    public function getAllRoutes()
    {
        try {
            // Mengambil seluruh data dari tabel routes
            $routes = DB::table('routes')->get();

            // Mengembalikan data dalam format JSON
            $data = ["data" => $routes->toArray()];
            return response()->json($data);
        } catch (\Exception $e) {
            // Menampilkan pesan kesalahan eksepsi
            dd($e->getMessage());

            // Jika terjadi kesalahan, kembalikan respons dengan pesan kesalahan yang spesifik
            return response()->json(['error' => 'Error retrieving routes.'], 500);
        }
    }
    public function showRoutesByAdminId()
    {
        try {
            // Pastikan pengguna telah terautentikasi
            if (Auth::check()) {
                // Dapatkan ID admin yang sedang login
                $adminId = Auth::id();
    
                // Menampilkan rute berdasarkan admin yang sedang login
                $routes = DB::table('routes')
                            ->select('routes.id', 'routes.derpature', 'routes.arrival', 'routes.harga', 'routes.type', 'routes.status')
                            ->join('brands', 'routes.brand_id', '=', 'brands.id')
                            ->where('brands.admin_id', $adminId)
                            ->get();
    
                // Membungkus data dalam array dengan kunci "data"
                $data = ["data" => $routes];
    
                // Mengembalikan data rute
                return response()->json($data);
            } else {
                // Pengguna belum terautentikasi, mungkin perlu diarahkan ke halaman login
                return response()->json(['message' => 'Unauthorized'], 401);
            }
        } catch (\Exception $e) {
            // Jika terjadi kesalahan, kembalikan respons dengan pesan kesalahan yang spesifik
            return response()->json(['message' => 'Error retrieving routes.', 'error' => $e->getMessage()], 500);
        }
    }
    
    public function index()
    {
        try {
            // Mendapatkan ID admin yang sedang login
            $adminId = Auth::user()->id;
    
            // Mengambil data rute berdasarkan admin yang sedang login
            $routes = DB::table('routes')
                        ->join('brands', 'routes.brand_id', '=', 'brands.id')
                        ->where('brands.admin_id', $adminId)
                        ->select('routes.id', 'routes.departure', 'routes.arrival', 'routes.harga', 'routes.type', 'routes.status')
                        ->get();
    
            // Memeriksa apakah ada rute yang ditemukan
            if ($routes->isEmpty()) {
                return $this->sendError('No routes found for this admin.', [], 404);
            }
    
            // Mengembalikan data sebagai respons
            $data = ["data" => $routes->toArray()];
            return response()->json($data);
    
        } catch (\Exception $e) {
            // Menampilkan pesan kesalahan eksepsi
            dd($e->getMessage());
    
            // Jika terjadi kesalahan, kembalikan respons dengan pesan kesalahan yang spesifik
            return $this->sendError('Error retrieving routes.', [], 500);
        }
    }

    public function store(Request $request)
    {
        // Mengambil ID admin yang sedang login
        $admin_id = Auth::id();
    
        $brand_id = DB::table('brands')
                        ->where('admin_id', $admin_id)
                        ->value('id');
    
        $validator = Validator::make($request->all(), [
            'derpature' => 'required|string',
            'arrival' => 'required|string',
            'harga' => 'required|string',
            'type' => 'required|string'
        ],[
            'required' => ':attribute tidak boleh kosong',
            'derpature.required' => 'Keberangkatan tidak boleh kosong',
            'arrival.required' => 'Kedatangan tidak boleh kosong',
            'type.required' => 'Type tidak boleh kosong',
            'string' => ':attribute hanya bisa diisi oleh huruf dan angka.',
        ]);
    
        if ($validator->fails()) {
            return $this->sendError('Input tidak boleh kosong', $validator->errors(), 422);
        }
        $routes = new Routes;
    
        $routes->derpature = $request->derpature;
        $routes->arrival = $request->arrival;
        $routes->harga = $request->harga;
        $routes->type = $request->type;
        $routes->brand_id = $brand_id;
        $routes->save();
    
        return $this->sendResponse($routes, 'Berhasil menambahkan rute.');
    }
    
    public function getOneRoute($id)
    {
        $routes = Routes::find($id);
        return response()->json([
            'data' => $routes,
        ], 200);
    }

    public function update(Request $request, $id)
    {
        $routes = Routes::find($id);
        if (!$routes) {
            return response()->json(['message' => 'Route not found.'], 404);
        }
        $validator = Validator::make($request->all(), [
            'derpature' => 'required|string',
            'arrival' => 'required|string',
            'harga' => 'required|string',
            'type' => 'required|string',
        ]);
        if ($validator->fails()) {
            return response()->json(['message' => $validator->errors()], 400);
        }
        $routes->derpature = $request->derpature;
        $routes->arrival = $request->arrival;
        $routes->harga = $request->harga;
        $routes->type = $request->type;
        $routes->save();
        return $this->sendResponse($routes, 'Routes Updated Successfully');
    }

    public function destroy($id)
    {
        $routes = Routes::find($id);

        if (!$routes) {
            return response()->json(['message' => 'Routes not found.'], 404);
        }

        $routes->delete();
        return $this->sendResponse($routes, 'Routes Deleted Successfully');
    }
public function UpdateStatusRoute($id)
        {
            $routes = Routes::find($id);

            if (!$routes) {
                return response()->json(['message' => 'Route not found.'], 404);
            }
            $routes->status = ($routes->status == 1) ? 0 : 1;
            $routes->save();
            return response()->json(['data' => $routes, 'message' => 'Status Bus Updated Successfully']);
    }

}
