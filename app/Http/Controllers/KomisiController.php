<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Response;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class KomisiController extends Controller
{
    public function index2()
{
    // Assuming you use Laravel's Auth to get the logged-in user's ID
    $userId = auth()->user()->id;

    // Modify the query to fetch data based on the logged-in user's ID
    $komisiData = DB::table('komisi')
                    ->join('brands', 'brands.id', '=', 'komisi.brand_id')
                    ->where('brands.admin_id', '=', $userId)
                    ->select('komisi.*')
                    ->get(); // Assuming you expect multiple results

    return response()->json(['data' => $komisiData]);
}

    public function index($id)
{
    // Assuming you use Laravel's Auth to get the logged-in user's ID
    $userId = auth()->user()->id;

    // Modify the query to fetch data based on the schedule_id
    $komisiData = DB::table('penghasilan_per_jadwal')
                    ->where('schedule_id', '=', $id)
                    ->select('persentase_komisi', 'setoran_kantor', 'administrasi')
                    ->first(); // Assuming you only expect one result

    return response()->json(['data' => $komisiData]);
}

public function updateKomisi(Request $request)
{
    try {
        $id = $request->input('id'); // Mendapatkan ID dari request

        $data = [
            'persentase_komisi' => $request->input('persentase_komisi'),
            'setoran_kantor' => $request->input('setoran_kantor'),
            'administrasi' => $request->input('administrasi'),
            'brand_id' => $request->input('brand_id'),
            'updated_at' => now()
        ];
        
        $affected = DB::table('komisi')
            ->where('id', $id) // Menggunakan ID dari request
            ->update($data);

        if ($affected) {
            $komisi = DB::table('komisi')->where('id', $id)->first();
            return response()->json(['message' => 'Komisi data updated successfully', 'data' => $komisi], 200);
        } else {
            return response()->json(['message' => 'Komisi data not found'], 404);
        }
    } catch (\Exception $e) {
        return response()->json(['message' => 'Error updating komisi data', 'error' => $e->getMessage()], 500);
    }
}
}
