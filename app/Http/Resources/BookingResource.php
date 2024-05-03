<?php

namespace App\Http\Resources;

use Illuminate\Http\Resources\Json\JsonResource;

class BookingResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return array|\Illuminate\Contracts\Support\Arrayable|\JsonSerializable
     */
    public function toArray($request)
    {
        return [
            "bookings_id" => $this->bookings_id,
            "created_at" => $this->created_at,
            "schedule_id" => $this->schedule_id,
            "derpature" => $this->derpature,
            "arrival" => $this->arrival,
            "nomor_pintu" => $this->nomor_pintu ,
            "type" => $this->type,
            "number_of_seats" =>$this->number_of_seats ,
            "tanggal" => $this->tanggal,
            "name" => $this->name,
            "harga" => $this->harga,
            "status" => $this->status,
            "status_pay" => $this->status_pay,
            "how_to_pay_page" => $this->how_to_pay_page,
            "how_to_pay_api" => $this->how_to_pay_api,
            "created_date" => $this->created_date,
            "expired_date" =>$this->expired_date,
            "expired_a"

        ];
    }
}
