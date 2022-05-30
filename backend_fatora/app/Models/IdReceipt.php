<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class IdReceipt extends Model
{
    use HasFactory;
    protected  $fillable = ['idReceiptForEachEmployee','charReceiptForEachEmployee'];
}
