<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;
use App\Http\Controllers\DateTime;
use App\Http\Controllers\Carbon;
use App\Http\Controllers\DateTimeZone;


class DokuPaymentController extends Controller
{
    public function checkoutPayment(){
        $now = Carbon::now();
        $baseurl = env('DOKU_URL');
        $client_id = env('DOKU_CLIENT_ID');
        $requestId = "21";
        // $requestDate = "2020-10-21T03:38:28Z";
        $date = new DateTime("Fri, 15 Mar 2019 08:56:57 +0000");
        $date->setTimezone(new DateTimeZone("UTC"));
        $requestDate = $date->format(\DateTime::ISO8601);
        $targetPath = "/checkout/v1/payment";
        $secretKey = "SK-oEvYyCaeAQ8BZBxgQIFa";

        $response = Http::withHeaders([
            'Client-Id'  => $client_id,
            'Request-Id' => 'fdb69f47-96da-499d-acec-7cdc318ab2fe',
            'Response-Timestamp' => '2020-08-11T08:45:42Z',
            'Signature' => 'HMACSHA256=vl9DBTX5KhEiXmnpOD0TSm8PYQknuHPdyHSTSc3W6Ps=',
        ])->get($baseurl);
        $requestBody = array (
            'order' => array (
                'amount' => 15000,
                'invoice_number' => 'INV-20210124-0001',
            ),
            'virtual_account_info' => array (
                'expired_time' => 60,
                'reusable_status' => false,
                'info1' => 'Merchant Demo Store',
            ),
            'customer' => array (
                'name' => 'Taufik Ismail',
                'email' => 'taufik@example.com',
            ),
        );
        
        // Generate Digest
        $digestValue = base64_encode(hash('sha256', json_encode($requestBody), true));
        echo "Digest: " . $digestValue;
        echo "\r\n\n";
        
        // Prepare Signature Component
        $componentSignature = "Client-Id:" . $client_id . "\n" . 
                              "Request-Id:" . $requestId . "\n" .
                              "Request-Timestamp:" . $requestDate . "\n" . 
                              "Request-Target:" . $targetPath . "\n" .
                              "Digest:" . $digestValue;
        echo "Component Signature: \n" . $componentSignature;
        echo "\r\n\n";
         
        // Calculate HMAC-SHA256 base64 from all the components above
        $signature = base64_encode(hash_hmac('sha256', $componentSignature, $secretKey, true));
        echo "Signature: " . $signature;
        echo "\r\n\n";
        
        // Sample of Usage
        $headerSignature =  "Client-Id:" . $client_id ."\n". 
                            "Request-Id:" . $requestId . "\n".
                            "Request-Timestamp:" . $requestDate ."\n".
                            // Prepend encoded result with algorithm info HMACSHA256=
                            "Signature:" . "HMACSHA256=" . $signature;
        echo "your header request look like: \n".$headerSignature;
        echo "\r\n\n";
        return $baseurl;
    }
}
