<?php

namespace App\Http\Controllers;

use App\Http\Controllers\API\BaseController;
use App\Models\loket;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class LoketController extends BaseController
{
    public function getLoketsByAdmin()
    {
        // Ambil ID pengguna yang sedang login
        $adminId = Auth::id();

        // Ambil data loket berdasarkan admin_id menggunakan Query Builder
        $lokets = DB::table('lokets')
                    ->where('admin_id', $adminId)
                    ->get();

        // Kembalikan response JSON dengan data lokets
        return response()->json(['data' => $lokets]);
    }
    public function store(Request $request)
{
    // Validation
    $validator = Validator::make($request->all(), [
        'nama_loket' => 'required|string',
        'lokasi_loket' => 'required|string',
        'admin_id' => 'required|integer|unique:lokets',
    ], [
        'required' => ':attribute tidak boleh kosong.',
        'string' => ':attribute hanya bisa diisi oleh huruf dan angka.',
        'admin_id.unique' => 'Admin telah terdaftar di loket lain.',
        'admin_id.required'=> 'Admin harus diisi.',
        'lokasi_loket.required'=> 'Lokasi loket harus diisi.',
        'nama_loket.required'=> 'Nama loket harus diisi.',
    ]);

    if ($validator->fails()) {
        return $this->sendError('Input tidak boleh kosong', $validator->errors(), 422);
    }

    // Get the ID of the currently logged-in user
    $userId = Auth::id();

    // Query to get the brand_id from the brands table based on admin_id
    $brandId = DB::table('users')
        ->join('brands', 'brands.admin_id', '=', 'users.id')
        ->where('users.id', $userId)
        ->value('brands.id');

    // Query to get the brand name from the brands table based on admin_id
    $brandName = DB::table('users')
        ->join('brands', 'brands.admin_id', '=', 'users.id')
        ->where('users.id', $userId)
        ->value('brands.merk');

    // Prepare the input data
    $input = $request->all();
    $input['brand_id'] = $brandId; // Add the brand_id to the input

    // Append the brand name to the nama_loket
    $input['nama_loket'] = $input['nama_loket'] . ' ' . $brandName;

    // Insert the data into the lokets table
    DB::table('lokets')->insert($input);

    return $this->sendResponse($input, 'Berhasil Menambahkan Loket.');
}

    public function UpdateStatus($id)
    {
        $loket = loket::find($id);
        if ($loket) {
            $status = $loket->status;
            $loket->status = $status == 1 ? 0 : 1;
            $loket->save();
        }
    }
    public function getOne($id)
    {
        $loket = loket::find($id);
        if ($loket) {
            return response()->json(['data' => $loket, 'message' => 'Data Berhasil']);
        }
        return response()->json(['message' => 'Data not found']);
    }

    public function show()
    {
        $adminId = auth()->user()->id;

        $loket = DB::table('lokets as l')
            ->join('users', 'users.id', '=', 'l.admin_id')
            ->join('brands', 'brands.id', '=', 'l.brand_id')
            ->select('l.id', 'l.nama_loket', 'l.lokasi_loket', 'l.status', 'l.nama_loket', 'brands.admin_id', 'users.name', 'users.email')
            ->where('brands.admin_id', $adminId)
            ->get();
        return response()->json($loket);
    }

    public function update($id)
    {
        $input = $this->validate(request(), [
            'nama_loket' => 'required|string',
            'lokasi_loket' => 'required|string',
            'admin_id' => 'required|integer|unique:lokets,admin_id,' . $id,
        ]);
        $loket = loket::find($id);
        if ($loket) {
            $loket->nama_loket = $input['nama_loket'];
            $loket->lokasi_loket = $input['lokasi_loket'];
            $loket->admin_id = $input['admin_id'];
            $loket->save();
        }
        return response()->json(['data' => $loket, 'message' => 'Data Berhasil']);
    }

    public function notAssociated()
    {
        $userId = Auth::id(); // Dapatkan ID user yang sedang login

        $supir = DB::table('users as u')
        ->leftJoin('adminloket_brand as ab', 'u.id', '=', 'ab.id_adminloket')
        ->join('brands as b', 'b.id', '=', 'ab.brand_id')
        ->leftJoin('lokets as l', 'l.admin_id', '=', 'u.id')
        ->where('u.role_id', 4)
        ->where('b.admin_id', $userId) // Filter berdasarkan ID user yang sedang login
        ->whereNull('l.admin_id') // Pastikan tidak ada admin_id yang terkait di lokets
        ->select('u.*')
        ->get();
        return response()->json($supir);
    }
}
