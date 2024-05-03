<?php

namespace App\Http\Controllers;

use App\Http\Controllers\API\BaseController;
use App\Models\User;
use Illuminate\Http\Request;
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

        $user = User::create($input);

        $success['token'] =  $user->createToken('MyApp')->accessToken;
        $success['name'] =  $user->name;

        return $this->sendResponse($success, 'Admin Loket Berhasil Ditambahakan.');

    }

    public function index()
    {
        $user = User::where('role_id', 4)->get();

        return response()->json($user);
    }
}
