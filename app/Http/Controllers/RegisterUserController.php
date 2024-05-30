<?php

namespace App\Http\Controllers;

use App\Http\Controllers\API\BaseController;
use App\Models\User;
use App\Models\Brand;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Validator;

class RegisterUserController extends BaseController

{
    public function RegisterUser(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:20',
            'email' => 'required|string|unique:users',
            'phone_number' => 'required|string',
            'address' => 'required|string',
            'gender' => 'required|string',
            'password' => 'required|string|min:6',
            'confirm_password' => 'required|same:password'
        ], [
            'required' => ':attribute tidak boleh kosong',
            'string' => ':attribute hanya bisa diisi oleh huruf dan angka.',
            'min' => ':attribute minimal :min digit',
            'max' => ':attribute maksimal :max digit',
            'same' => 'Konfirmasi password harus sama dengan Password baru anda.',
            'confirmed' => 'Password konfirmasi salah.',
            'exists' => 'Email yang dimasukkan telah terdaftar.',
            'unique' => ':attribute sudah digunakan'

        ]);
        // return $validator;

        if ($validator->fails()) {
            return $this->sendError('Input tidak boleh kosong', $validator->errors(), 422);
        }
        $input = $request->all();
        $input['password'] = bcrypt($request->password);
        $input['photo'] = "null";
        $input['role_id'] = '2';
        $input['status'] = 1;
        $user = User::create($input);
        $success['token'] =  $user->createToken('MyApp')->accessToken;
        

        return $this->sendResponse($success, 'register user berhasil!');
    }

    public function RegistrasiSupir(Request $request)
    {
        if (!auth()->check()) {
            return response()->json(['message' => 'Unauthenticated.'], 401);
        }
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:20',
            'email' => 'required|string|unique:users|email',
            'phone_number' => 'required|string',
            'address' => 'required|string',
            'gender' => 'required|string',
        ], [
            'required' => ':attribute tidak boleh kosong!',
            'email' => 'Gunakan format email yang benar ',
            'max'      => 'minimal :max digit.',
            'phone_number.required' => 'No handphone tidak boleh kosong!',
            'address.required' => 'Alamat tidak boleh kosong!',
            'name.required' => 'Nama tidak boleh kosong!',
            'gender.required' => 'Jenis Kelamin tidak boleh kosong!',
            'unique' => ':attribute sudah digunakan',
            'string' => ':attribute hanya bisa diisi oleh huruf dan angka.',
        ]);
    
        if ($validator->fails()) {
            return $this->sendError('Input tidak boleh kosong', $validator->errors(), 422);
        }
    
        $input = $request->all();
        $input['password'] = bcrypt('123456');
        $input['photo'] = "null";
        $input['role_id'] = '3';
        $input['status'] = 1;
    
        // Membuat entri baru di tabel users
        $user = User::create($input);
    
        // Dapatkan ID admin yang sedang login
        $adminId = Auth::id();
    
        // Query untuk mendapatkan brand_id dari tabel brands berdasarkan admin_id
        $brandId = DB::table('brands')->where('admin_id', $adminId)->value('id');
    
        // Membuat entri baru di tabel sopir_brand
        DB::table('sopir_brand')->insert([
            'id_sopir' => $user->id,
            'brand_id' => $brandId,
        ]);
    
        $success['token'] =  $user->createToken('MyApp')->accessToken;
        $success['name'] =  $user->name;
    
        return $this->sendResponse($input, 'Berhasil menambahkan supir');
    }

    public function RegistrasiAdminKantor(Request $request)
    {
        // if (!auth()->check()) {
        //     return response()->json(['message' => 'Unauthenticated.'], 401);
        // }
        $validator = Validator::make($request->all(), [
            'name' => 'required|string|max:20',
            'email' => 'required|string|unique:users|email',
            'phone_number' => 'required|string',
            'address' => 'required|string',
            'gender' => 'required|string',
        ], [
            'required' => ':attribute tidak boleh kosong!',
            'email' => 'Gunakan format email yang benar ',
            'max'      => 'minimal :max digit.',
            'phone_number.required' => 'No handphone tidak boleh kosong!',
            'address.required' => 'Alamat tidak boleh kosong!',
            'name.required' => 'Nama tidak boleh kosong!',
            'gender.required' => 'Jenis Kelamin tidak boleh kosong!',
            'unique' => ':attribute sudah digunakan',
            'string' => ':attribute hanya bisa diisi oleh huruf dan angka.',
        ]);

        if ($validator->fails()) {
            return $this->sendError('Input tidak boleh kosong', $validator->errors(), 422);
        }

        $input = $request->all();
        $input['password'] = bcrypt('123456');
        $input['photo'] = "null";
        $input['role_id'] = '1';
        $input['status'] = 1;
        $user = User::create($input);

        $success['token'] =  $user->createToken('MyApp')->accessToken;
        $success['name'] =  $user->name;

        return $this->sendResponse($input, 'Berhasil menambahkan Admin Kantor');
    }

    public function RegistrasiBrand(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'merk' => 'required|string|max:20|unique:brands',
            'admin_id' => 'required|string|exists:users,id',
        ], [
            'required' => ':attribute tidak boleh kosong!',
            'max'      => 'minimal :max digit.',
            'unique' => ':attribute sudah digunakan',
            'string' => ':attribute hanya bisa diisi oleh huruf dan angka.',
            'exists' => ':attribute tidak valid.',
        ]);
    
        if ($validator->fails()) {
            return $this->sendError('Gagal', $validator->errors(), 422);
        }
    
        // Memeriksa apakah admin_id memiliki role_id 1
        $admin = User::find($request->admin_id);
        if (!$admin || $admin->role_id !== 1) {
            return $this->sendError('Gagal', 'Admin tidak memiliki role_id yang sesuai.', 422);
        }
    
        // Menambahkan brand tanpa memperbarui tabel users
        $input = $request->all();
        $input['status'] = 1;
        $brand = Brand::create($input);
    
        $success['token'] =  $admin->createToken('MyApp')->accessToken; // Jika Anda ingin menggunakan token dari admin untuk brand
    
        return $this->sendResponse($input, 'Berhasil menambahkan Brand');
    }
    
    
}
