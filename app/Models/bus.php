<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class bus extends Model
{
    use HasFactory;

    protected $fillable = [
        'type',
        'police_number',
        'nomor_pintu',
        'number_of_seats',
        'merk_id',
        'status',
        'supir_id',
        'loket_id',
    ];

    public function driver()
    {
        return $this->belongsTo(User::class, 'supir_id');
    }


    public function bookings()
    {
        return $this->hasManyThrough(Bookings::class, Schedule::class);
    }

    public function trackings()
    {
        return $this->hasMany(Trackings::class);
    }

    public function schedules()
    {
        return $this->hasMany(schedules::class, 'bus_id');
    }
}
