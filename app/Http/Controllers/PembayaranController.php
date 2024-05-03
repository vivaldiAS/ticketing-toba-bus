<?php

namespace App\Http\Controllers;

use App\Models\Bookings;
use App\Models\Pembayaran;
use App\Utils\SignatureDoku;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Str;
use DOKU\Client;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Validator;
use Ramsey\Uuid\Uuid;
class PembayaranController extends Controller
{
    public static function generateToken(Request $request)
    {

        $user = Auth::user();
        $currentDate = Carbon::now()->format('YmdHis');
        $validator = Validator::make($request->all(), [
            'schedules_id' => 'required|exists:schedules,id',
            'name' => 'required|string',
            'number_phone' => 'required|string',
            'num_seats' => 'required|integer',
        ]);

        if ($validator->fails()) {
            return response()->json(['message' => $validator->errors()], 400);
        }
        
        $clientId = "BRN-0215-1665721005141";
        $requestId = Uuid::uuid4()->toString();

        $dateTime = gmdate("Y-m-d H:i:s");
        $isoDateTime = date(DATE_ISO8601, strtotime($dateTime));
        $dateTimeFinal = substr($isoDateTime, 0, 19) . "Z";
        $requestDate =  $dateTimeFinal;
        
        $targetPath = "/bca-virtual-account/v2/payment-code"; // For merchant request to Jokul, use Jokul path here. For HTTP Notification, use merchant path here
        $secretKey = "SK-3ut5p5VDAKku2Dqd541q";

        $invoice = "INV-EKBT-".time();
        
        $requestBody = [
            "order" => array(
                "invoice_number" => $invoice,
                "amount" => $request->harga
            ),
            "virtual_account_info" => array(
                "billing_type" => "FIX_BILL",
                "expired_time" => 60,
                "reusable_status" => false,
                "info1" => "Thank you for ordering ",
                "info2" => "Pembelian e-ticket",
                "info3" => "di e-KBT"
            ),
            "customer" => array(
                "name" => $request->name,
                "email" => $user->email
            )
        ];

        $digestValue = base64_encode(hash('sha256', json_encode($requestBody), true));

        $componentSignature = "Client-Id:" . $clientId . "\n" .
            "Request-Id:" . $requestId . "\n" .
            "Request-Timestamp:" . $requestDate . "\n" .
            "Request-Target:" . $targetPath . "\n" .
            "Digest:" . $digestValue;

        $signature = base64_encode(hash_hmac('sha256', $componentSignature, $secretKey, true));

        $response = Http::withHeaders([
            'Content-Type' => 'application/json',
            'Client-Id' => $clientId,
            'Request-Id' => $requestId,
            'Request-Timestamp' => $requestDate,
            'Signature' => 'HMACSHA256=' . $signature,
        ])->post('https://api-sandbox.doku.com/bca-virtual-account/v2/payment-code', $requestBody);

        $responseJson = json_decode($response->body());
        $httpCode = $response->status();

        $booking = new Bookings;
        $booking->user_id = $user->id;
        $booking->schedules_id = $request->schedules_id;
        $booking->name = $request->name;
        $booking->number_phone = $request->number_phone;
        $booking->alamatJemput = $request->alamatJemput;
        $booking->num_seats = $request->num_seats;

        $booking->save();
        $pembayaran = new Pembayaran;
        $pembayaran->schedules_id = $request->schedules_id;
        $pembayaran->bookings_id = $booking->id;
        $pembayaran->method = 'noncash';
        $pembayaran->status = 'Menunggu';
        $pembayaran->created_date = $responseJson->virtual_account_info->created_date;
        $pembayaran->expired_date = $responseJson->virtual_account_info->expired_date;
        $pembayaran->how_to_pay_api = $responseJson->virtual_account_info->how_to_pay_api;
        $pembayaran->how_to_pay_page = $responseJson->virtual_account_info->how_to_pay_page;
        $pembayaran->invoice_number = $invoice;
        $pembayaran->amount    = $request->harga;
        $pembayaran->virtual_account_number = $responseJson->virtual_account_info->virtual_account_number;
        $pembayaran->active = 0;
        $pembayaran->save();

        return response()->json([
            'data' => $responseJson,
            'code' => $httpCode,
            'signature' => 'HMACSHA256=' . $signature,
        ]);
    }
}
