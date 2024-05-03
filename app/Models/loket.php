<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class loket extends Model
{
    use HasFactory;
    protected $fillable = [
        'nama_loket',
        'lokasi_loket',
        'admin_id',
    ];
}
