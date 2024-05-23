<?php

namespace App\Http\Controllers;

use App\Http\Controllers\API\BaseController;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class AdminLoketController extends BaseController
{
    public function store(Request $request)
    {
        if (!auth()->check()) {
            return response()->json(['message' => 'Unauthenticated.'], 401);
        }
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:20',
            'email' => 'required|string|unique:users',
            'phone_number' => 'required|string',
            'address' => 'required|string',
            'gender' => 'required|string',
        ], [
            'required' => ':attribute tidak boleh kosong',
            'phone_number.required' => 'No Handphone tidak boleh kosong',
            'gender.required' => 'Jenis Kelamin tidak boleh kosong',
            'address.required' => 'Alamat tidak boleh kosong',
            'name.required' => 'Nama tidak boleh kosong',
            'max' => ':attribute minimal :max digit',
            'unique' => ':attribute sudah digunakan',
            'string' => ':attribute hanya bisa diisi oleh huruf dan angka.',
        ]);
    
        if ($validator->fails()) {
            return $this->sendError('Input tidak boleh kosong', $validator->errors(), 422);
        }
        $input = $request->all();
        $input['password'] = bcrypt($request->password);
        $input['photo'] = "null";
        $input['role_id'] = '4';
        $input['status'] = '1';
    
        // Membuat entri baru di tabel users
        $user = User::create($input);
    
        // Dapatkan ID admin yang sedang login
        $adminId = Auth::id();
    
        // Query untuk mendapatkan brand_id dari tabel brands berdasarkan admin_id
        $brandId = DB::table('brands')->where('admin_id', $adminId)->value('id');
    
        // Membuat entri baru di tabel adminloket_brand
        DB::table('adminloket_brand')->insert([
            'id_adminloket' => $user->id,
            'brand_id' => $brandId,
        ]);
    
        $success['token'] =  $user->createToken('MyApp')->accessToken;
        $success['name'] =  $user->name;
    
        return $this->sendResponse($success, 'Admin Loket Berhasil Ditambahkan.');
    }

    public function index()
    {
           // Dapatkan ID admin yang sedang login
    $adminId = Auth::id();

    // Lakukan query sesuai dengan kebutuhan
    $user = User::select('users.*', 'brands.merk', 'brands.admin_id')
        ->join('adminloket_brand', 'users.id', '=', 'adminloket_brand.id_adminloket')
        ->join('brands', 'adminloket_brand.brand_id', '=', 'brands.id')
        ->where('brands.admin_id', $adminId)
        ->where('users.role_id', 4)
        ->get();

        return response()->json($user);
    }
}
