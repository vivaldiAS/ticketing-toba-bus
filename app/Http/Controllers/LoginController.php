<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Http\Controllers\API\BaseController;
use App\Models\User;
use Illuminate\Support\Facades\Auth;
use Laravel\Passport\Token;
use Validator;

class LoginController extends BaseController
{

  public function login(Request $request)
{
    $fields = $request->validate([
        'email' => 'required|string|email',
        'password' => 'required|string',
    ]);

    // Coba untuk melakukan autentikasi
    if (Auth::attempt($fields)) {
        // Jika autentikasi berhasil, dapatkan pengguna yang diotentikasi
        $user = auth()->user();
        $status = $user->status;

        // Periksa status akun
        if ($status) {
            // Jika akun aktif, buat token akses baru
            $accessToken = $user->createToken('authToken')->accessToken;
            // Tentukan waktu kedaluwarsa token
            $expired = now()->addDays(1);

            return response()->json([
                'access_token' => $accessToken,
                'expires_at' => $expired,
            ], 200);
        } else {
            // Jika akun tidak aktif, kembalikan pesan kesalahan
            return response()->json([
                'message' => 'Login gagal',
                'errors' => ['account' => ['Akun tidak aktif']],
            ], 422);
        }
    } else {
        // Jika autentikasi gagal, kembalikan pesan kesalahan
        return response()->json([
            'message' => 'Login gagal',
            'errors' => ['credentials' => ['Email atau Password salah']],
        ], 401);
    }
}


  public function user(Request $request)
  {
    return response()->json($request->user());
  }

  public function logout(Request $request)
  {
    $request->user()->token()->revoke();

    return response()->json(['message' => 'Successfully logged out']);
  }
}
