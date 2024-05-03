<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Brand extends Model
{
    use HasFactory;

    protected $fillable = [
        'merk',
        'gambar_qris',
        'admin_id'
    ];

    // Relasi dengan model User (Admin)
    public function admin()
    {
        return $this->belongsTo(User::class, 'admin_id');
    }
}
