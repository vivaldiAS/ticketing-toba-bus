<?php

namespace App\Http\Controllers;

use Illuminate\Support\Facades\Response;
use App\Models\bus;
use Illuminate\Http\Request;
use App\Http\Resources\Bus as BusResource;
use App\Http\Controllers\API\BaseController;
use App\Models\User;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Validator;

class BusController extends BaseController
{
    public function store(Request $request)
    {

        $validator = Validator::make($request->all(), [
            'type' => 'required|string|max:20',
            'police_number' => 'required|string|unique:buses',
            'number_of_seats' => 'required|string',
            'merk_id' => 'required|string',
            'nomor_pintu' => 'required|string|unique:buses',
            'supir_id' => 'required:unique:users',
            'loket_id' => 'required'
        ], [
            'required' => ':attribute harus diisi.',
            'string' => 'Input tidak valid!',
            'police_number.unique' => 'Bus sudah digunakan',
            'nomor_pintu.unique' => 'Bus sudah terdaftar',
            'police_number.required' => 'Nomor polisi harus diisi.',
            'nomor_pintu.required' => 'Nomor pintu harus diisi.',
            'type.required' => 'Type polisi harus diisi.',
            'max' => ':attribute maksimal :max digit',
            'supir_id.required' => 'Supir harus diisi.',
            'supir_id.unique' => 'Supir Telah terdaftar di mobil lain.',
            'loket_id.required' => 'Loket harus diisi.',

        ]);


        if ($validator->fails()) {
            return $this->sendError('Input tidak boleh kosong', $validator->errors(), 422);
        }

        $input = $request->all();
        $input['status'] = 1;
        bus::create($input);

        return $this->sendResponse($input, 'Berhasil menambhakan mobil.');

    }
    public function show()
    {
        $buses = DB::table('buses')
            ->join('lokets', 'buses.loket_id', '=', 'lokets.id')
            ->join('users', 'users.id', '=', 'buses.supir_id')
            ->select('buses.*', 'lokets.nama_loket', 'users.name as driver_name', 'users.email as driver_email')
            ->get();

        $responseData = [
            'status' => 'success',
            'message' => 'Buses Retrieved Successfully',
            'data' => BusResource::collection($buses)
        ];
        return Response::json($responseData);

    }

    public function show2()
    {
        $buses = DB::table('buses')
            ->join('lokets', 'buses.loket_id', '=', 'lokets.id')
            ->join('users', 'users.id', '=', 'buses.supir_id')
            ->select('buses.*', 'lokets.nama_loket', 'users.name as driver_name', 'users.email as driver_email')
            ->get();

            return Response::json(['data' => $buses]);;
    }
    public function update(Request $request, $id)
    {
        $input = $request->all();
        $validator = Validator::make($input, [
            'type' => 'required|string',
            'police_number' => 'required|string|unique:buses,police_number,' . $id,
            'number_of_seats' => 'required|string',
            'merk_id' => 'required|string',
            // 'supir_id' => 'required|unique:buses'
        ]);

        if ($validator->fails()) {
            return $this->sendError('Validation Error.', $validator->errors());
        }
        $bus = Bus::find($id);
        $bus->type = $request->input('type');
        $bus->police_number = $request->input('police_number');
        $bus->loket_id = $request->input('loket_id');
        $bus->number_of_seats = $request->input('number_of_seats');
        $bus->merk_id = $request->input('merk');
        $bus->supir_id = $request->input('supir_id');
        $bus->save();

        return $this->sendResponse($bus, 'Bus Updated Successfully');
    }


    public function delete($id)
    {
        $bus = bus::find($id);
        $bus->delete();
        return $this->sendResponse($bus->police_number, 'Bus Deleted Successfully');
    }

    public function updateStatus($id)
    {
        $bus = bus::find($id);

        if (!$bus) {
            return response()->json(['message' => 'Bus not found.'], 404);
        }
        $bus->status = ($bus->status == 1) ? 0 : 1;
        $bus->save();
        return response()->json(['data' => $bus, 'message' => 'Status Bus Updated Successfully']);
    }
    public function SelectOneBus($id)
    {
        $bus = DB::table('buses')
            ->join('lokets', 'buses.loket_id', '=', 'lokets.id')
            ->join('users', 'users.id', '=', 'buses.supir_id')
            ->where('buses.id', '=',  $id)
            ->select('buses.*', 'lokets.nama_loket', 'users.name', 'users.email')
            ->get();

        return response()->json(['data' => $bus, 'message' => ' Bus Retrieved  Successfully']);
    }

    public function getBusByBrandsId($id)
    {   
        $brandName = DB::table('brands')->where('id', $id)->value('merk');
        $cekBrands = DB::table('brands')
        ->select('*')
        ->where('brands.id', $id)
        ->get();

        $brands = DB::table('brands')
            ->join('buses', 'buses.merk_id', '=', 'brands.id')
            ->select('buses.id', 'buses.type', 'buses.police_number', 'buses.number_of_seats', 'buses.status', 'brands.merk')
            ->where('brands.id', $id)
            ->get();
    
        if ($cekBrands->isEmpty()) {
            return response()->json(['message' => 'Brand tidak ditemukan'], 404);
        } else if ($brands->isEmpty()) {
            return response()->json(['message' => 'Tidak ada bus untuk brand '. $brandName], 404);
        } else {
            return response()->json(['data' => $brands]);
        }
    }
    
    public function notAssociated()
    {
        $supir = DB::table('users')
            ->leftJoin('buses', 'users.id', '=', 'buses.supir_id')
            ->where('users.role_id', 3)
            ->whereNull('buses.supir_id')
            ->select('users.*')
            ->get();


        return response()->json($supir);
    }
}
