<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Receipt extends Model
{
    use HasFactory;
//    public $timestamps = false;
    protected $fillable = ['whoIsTake','idLocal','amountNumeric','amountText','causeOfPayment','date','receiptPdfFileName' ,'statusSend_WhatsApp'];
}
