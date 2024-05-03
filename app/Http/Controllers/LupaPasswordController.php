<?php

namespace App\Http\Controllers;

use App\Http\Controllers\API\BaseController;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Facades\Validator;

class LupaPasswordController extends BaseController
{
    public function sendOTP(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email'
        ], [
            'email.required' => 'email harus diisi.',
            'email'         => "format email salah."
        ]);

        if ($validator->fails()) {
            return $this->sendError('Input tidak boleh kosong', $validator->errors(), 422);
        }
        $email = $request->email;
        if ($user = User::where('email', $email)->first()) {
            $user->remember_token = strval(random_int(1000, 9999));
            $user->save();
            Mail::send('email.index', ['user' => $user], function ($message) use ($user) {
                $message->to($user->email)->subject("Email Verification");
                $message->from('hello@example.com');
            });
            return response()->json(['message' => "Berhasil mengirim OTP "]);
        }
        return response()->json(['message' => "Email tidak terdaftar "], 404);
    }

    public function getOtp(Request $request)
    {
        $user = User::where('email', $request->email)->first();
        $otp = $user->remember_token;

        
      
        if ($otp == $request->otp) {
            return $this->sendResponse($user, 'OTP Sesuai');
        } else {
            return $this->sendError('OTP tidak sesuai', $request->otp, 422);
        }
    }

    public function resetPassword(Request $request, $email)
    {
        $validator = Validator::make($request->all(), [
            'password' => 'required|min:6|string|confirmed',
            'password_confirmation' => 'required'
        ], [
            'required' => ':attribute tidak boleh kosong',
            'password_confirmation.required' => 'Konfirmasi password tidak boleh kosong',
            'min' => ':attribute minimal :min digit',
            'confirmed' => 'Password harus sama',
        ]);
        if ($validator->fails()) {
            return $this->sendError('Input tidak boleh kosong', $validator->errors(), 422);
        }
        $user = User::where('email', $email)->first();
        $user->password = bcrypt($request->password);
        if ($user->save()) {
            Mail::send('email.change_notif', ['user' => $user], function ($message) use ($user) {
                $message->to($user->email)->subject("Password Berhasil diperbaharui");
                $message->from('hello@example.com');
            });
            return $this->sendResponse($user, 'Berhasil mengubah password.');
        }
        return $this->sendError('Gagal mengubah password', $email, 422);
    }
}
