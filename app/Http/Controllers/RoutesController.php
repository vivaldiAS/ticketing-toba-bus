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
    public function index()
    {
        try {
            // Mendapatkan ID admin yang sedang login
            $adminId = auth()->user()->id;
    
            // Mengambil data rute berdasarkan admin yang sedang login
            $routes = Routes::select('routes.id', 'routes.derpature', 'routes.arrival', 'routes.harga', 'routes.type', 'routes.harga', 'routes.status')
                            ->join('brands', 'routes.brand_id', '=', 'brands.id')
                            ->where('brands.admin_id', $adminId)
                            ->get();
    
            // Mengembalikan data sebagai respons
            return $this->sendResponse($routes, 'Routes Retrieved Successfully');
        } catch (\Exception $e) {
            // Jika terjadi kesalahan, kembalikan respons dengan pesan kesalahan
            return $this->sendError('Error retrieving routes.', [], 404);
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
