<?php

namespace App\Http\Controllers;


use App\Models\Bus;
use App\Models\Routes;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Exception;



class PASTIController extends Controller
{
    public function index()
    {
        $buses = Bus::all();

        return response()->json(['data' => $buses], 200);
    }

    public function storeBus(Request $request)
    {
        // Memeriksa apakah pengguna telah terautentikasi
        if (!Auth::check()) {
            return response()->json(['error' => 'Unauthorized. Please authenticate.'], 401);
        }
    
        // Mendapatkan id merek dari pengguna yang sedang login
        $brand_id = DB::table('brands')
            ->where('admin_id', Auth::id()) // Memastikan hanya merek yang sesuai dengan pengguna yang sedang login yang diambil
            ->value('id');
    
        $request->validate([
            'supir_id' => 'required|numeric',
            'loket_id' => 'required|numeric',
            'type' => 'required|string',
            'police_number' => 'required|string',
            'number_of_seats' => 'required|string',
            'nomor_pintu' => 'required|string',
        ]);
    
        $bus = new Bus();
        $bus->supir_id = $request->supir_id;
        $bus->loket_id = $request->loket_id;
        $bus->type = $request->type;
        $bus->police_number = $request->police_number;
        $bus->number_of_seats = $request->number_of_seats;
        $bus->merk_id = $brand_id; // Mengisi merk_id dengan brands_id dari user yang sedang login
        $bus->nomor_pintu = $request->nomor_pintu;
    
        $bus->save();
    
        return response()->json(['message' => 'Bus added successfully'], 201);
    }

    public function update(Request $request, $id)
    {
        $request->validate([
            'supir_id' => 'required|numeric',
            'loket_id' => 'required|numeric',
            'type' => 'required|string',
            'police_number' => 'required|string',
            'number_of_seats' => 'required|string',
            'merks_id' => 'required|numeric',
            'merk_id' => 'required|numeric',
            'nomor_pintu' => 'required|string',
        ]);

        $bus = Bus::find($id);
        if (!$bus) {
            return response()->json(['message' => 'Bus not found'], 404);
        }

        $bus->supir_id = $request->supir_id;
        $bus->loket_id = $request->loket_id;
        $bus->type = $request->type;
        $bus->police_number = $request->police_number;
        $bus->number_of_seats = $request->number_of_seats;
        $bus->merks_id = $request->merks_id;
        $bus->merk_id = $request->merk_id;
        $bus->nomor_pintu = $request->nomor_pintu;

        $bus->save();

        return response()->json(['message' => 'Bus updated successfully'], 200);
    }

    public function destroy($id)
    {
        $bus = Bus::find($id);
        if (!$bus) {
            return response()->json(['message' => 'Bus not found'], 404);
        }

        $bus->delete();

        return response()->json(['message' => 'Bus deleted successfully'], 200);
    }

    public function lihatRoutes()
    {
        $routes = Routes::all();

        return response()->json(['routes' => $routes], 200);
    }

    public function storeRoutes(Request $request)
    {
        $request->validate([
            'derpature' => 'required|string',
            'arrival' => 'required|string',
            'harga' => 'required|string',
            'type' => 'required|string',
        ]);

        $route = new Routes();
        $route->derpature = $request->derpature;
        $route->arrival = $request->arrival;
        $route->harga = $request->harga;
        $route->type = $request->type;
        $route->save();

        return response()->json(['message' => 'Route added successfully'], 201);
    }

    public function updateRoutes(Request $request, $id)
    {
        $request->validate([
            'derpature' => 'required|string',
            'arrival' => 'required|string',
            'harga' => 'required|string',
            'type' => 'required|string',
        ]);

        $route = Routes::find($id);
        if (!$route) {
            return response()->json(['message' => 'Route not found'], 404);
        }

        $route->derpature = $request->derpature;
        $route->arrival = $request->arrival;
        $route->harga = $request->harga;
        $route->type = $request->type;
        $route->save();

        return response()->json(['message' => 'Route updated successfully'], 200);
    }
}
