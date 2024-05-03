<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Routes extends Model
{
    use HasFactory;

    protected $fillable = [
        'derpature',
        'arrival',
        'harga',
        'type'
    ];

    public function buses()
    {
        return $this->hasMany(bus::class);
    }

    public function bookings()
    {
        return $this->hasMany(Bookings::class);
    }
}
