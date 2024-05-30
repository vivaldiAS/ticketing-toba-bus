<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Auth;
use Carbon\Carbon;


class defaultSchedulesController extends Controller
{
    public function getDefaultSchedules()
    {
        // Check if a user is authenticated
        if (Auth::check()) {
            // Get the currently authenticated user's admin_id
            $adminId = Auth::user()->id;
    
            // Retrieve all default schedules for the logged-in admin with the specified query
            $defaultSchedules = DB::table('default_schedules as ds')
                ->join('brands as b', 'b.id', '=', 'ds.brand_id')
                ->leftJoin(DB::raw('(SELECT DISTINCT * FROM buses) as bs'), 'bs.id', '=', 'ds.bus_id')
                ->where('b.admin_id', '=', $adminId)
                ->select('ds.*', 'bs.nomor_pintu')
                ->get();
    
            // Return the data as JSON
            return response()->json($defaultSchedules);
        } else {
            // Return an error response if the user is not authenticated
            return response()->json(['error' => 'Unauthenticated'], 401);
        }
    }
    
    public function addDefaultSchedules(Request $request)
    {
        // Validate the request data
        $request->validate([
            'bus_id' => 'required|numeric',
            'route_id' => 'required|numeric',
            'day_of_week' => 'required|numeric',
            'time' => 'required|string',
            'harga' => 'required|string',
        ]);
    
        // Extract data from the request
        $busId = $request->input('bus_id');
        $routeId = $request->input('route_id');
        $dayOfWeek = $request->input('day_of_week');
        $time = $request->input('time');
        $harga = $request->input('harga');
    
        // Get the current time in WIB (Western Indonesian Time)
        $currentTime = now('Asia/Jakarta')->toDateTimeString();
    
        // Get the brand_id based on the logged-in user's admin_id
        $loggedInUserId = Auth::id();
        $brandId = DB::table('brands')
                    ->where('admin_id', $loggedInUserId)
                    ->value('id');
    
        // Insert data into the default_schedules table
        DB::table('default_schedules')->insert([
            'bus_id' => $busId,
            'route_id' => $routeId,
            'day_of_week' => $dayOfWeek,
            'time' => $time,
            'harga' => $harga,
            'status' => 'not_started',
            'brand_id' => $brandId,
            'created_at' => $currentTime,
            'updated_at' => $currentTime,
        ]);
    
        // Return a success response
        return response()->json(['message' => 'Default schedule added successfully'], 200);
    }
}
