<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Bookings extends Model
{
    use HasFactory;
    protected $fillable = [
        'alamatJemput',
    ];
    public function user()
    {
        return $this->belongsTo(User::class);
    }
    public function schedules()
    {
        return $this->belongsTo(Schedule::class);
    }
    public function buss()
    {
        return $this->belongsTo(bus::class);
    }


}
