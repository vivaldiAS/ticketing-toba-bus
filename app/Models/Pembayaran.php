<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Pembayaran extends Model
{
    use HasFactory;
    protected $table = "payments";

    protected $fillable = [
        // 'created_date',
        // 'expired_date',
        // 'how_to_pay_page',
        // 'how_to_pay_api',
        // 'amount',
    ];
}
