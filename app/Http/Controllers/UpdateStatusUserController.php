<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;

class UpdateStatusUserController extends Controller
{
    public function update($id)
    {
        $user = User::find($id);

        if (!$user) {
            return response()->json(['message' => 'Account not found.'], 404);
        }

        $user->status = ($user->status == 1) ? 0 : 1;
        $user->save();

        return response()->json(['data' => $user, 'message' => 'Update Status Successfully']);
    }
}
