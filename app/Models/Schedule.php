<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Schedule extends Model
{
    use HasFactory;

    protected $fillable = [
        'bus_id',
        'route_id',
        'tanggal',
        'harga',
        'status'
    ];
    public function buses()
    {
        return $this->belongsTo(bus::class, 'id');
    }
    public function users()
    {
        return $this->belongsTo(User::class, 'supir_id');
    }
    public function routes()
    {
        return $this->belongsTo(routes::class, 'route_id');
    }
    // public function bookings()
    // {
    //     return $this->hasMany(Bookings::class);
    // }
}
