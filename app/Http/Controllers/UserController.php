<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;

class UserController extends Controller
{
    public function user(Request $request)
    {
        return response()->json($request->user());
    }

    public function update(Request $request, $id)
    {
        $user  = User::find($id);
        if (!$user) {
            return response()->json(['message' => 'Route not found.'], 404);
        }
        $validator = Validator::make($request->all(), [
            'name' => 'required|string',
            'email' => 'required|string',
            'phone_number' => 'required|string',
            'gender' => 'required|string',
            'address' => 'required|string',
        ]);
        if ($validator->fails()) {
            return response()->json(['message' => $validator->errors()], 400);
        }

        $user->name = $request->name;
        $user->email = $request->email;
        $user->phone_number = $request->phone_number;
        $user->gender = $request->gender;
        $user->address = $request->address;
        $user->save();

        return response()->json([
            'data' => $user,
            'message' => 'User updated successfully.'
        ], 200);
    }

    public function getUser($id)
    {
        $user = User::find($id);
        return response()->json([
            'data' => $user,
        ], 200);
    }

    public function updatePassword(Request $request)
    {
        $user = Auth::user();
        
        $request->validate([
            'current_password' => 'required',
            'new_password' => 'required|min:6|confirmed',
        ]);

        $currentPassword = $request->input('current_password');
        $newPassword = $request->input('new_password');
        // return $user;
        
        if (Hash::check($currentPassword, $user->password)) {
            User::whereId(auth()->user()->id)->update([
                'password' => Hash::make($newPassword)
            ]);

            return response()->json([
                'message' => 'Password updated successfully!',
            ], 200);
        } else {
            return response()->json([
                'error' => 'Paasword saat ini salah!',
            ], 400);
        }
    }
}
