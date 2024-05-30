<?php

namespace App\Http\Controllers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;


class PaymentsController extends Controller
{
    public function getPaymentById($paymentId)
    {
        // Pastikan pengguna telah terautentikasi
        if (Auth::check()) {
            // Dapatkan data pembayaran berdasarkan ID
            $payment = DB::table('payments')
                        ->where('id', $paymentId)
                        ->first();

            // Jika pembayaran ditemukan
            if ($payment) {
                // Mengembalikan data pembayaran dalam format JSON
                return response()->json(['payment' => $payment]);
            } else {
                // Jika pembayaran tidak ditemukan, kembalikan respons dengan pesan error
                return response()->json(['message' => 'Payment not found'], 404);
            }
        } else {
            // Pengguna belum terautentikasi, mungkin perlu diarahkan ke halaman login
            return response()->json(['message' => 'Unauthorized'], 401);
        }
    }
}
