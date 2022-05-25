<?php

namespace App\Http\Controllers;

use App\Models\Receipt;
use Exception;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;

class ReceiptController extends Controller
{
    public function allReceipt()
    {
        return DB::table('receipts')
            ->orderBy('created_at', 'desc')
            ->get();
    }

    public function addReceipt(Request $request): string
    {
        try {
            Receipt::create([
                'whoIsTake' => $request->input('whoIsTake'),
                'amountNumeric' => $request->input('amountNumeric'),
                'amountText' => $request->input('amountText'),
                'causeOfPayment' => $request->input('causeOfPayment'),
                'date' => $request->input('date'),
            ]);
            return "success";
        } catch (Exception $e) {
            return "fail cause " . $e->getMessage();
        }
    }

    public function store(Request $request)
    {
        try {
            if ($request->hasFile("receipt")) {
                $file = $request->file("receipt");
                $fileName = $file->getClientOriginalName();
                $file->storeAs('/Users/ahmadabotrab/Desktop/ahmad', $fileName);
                return "done store";
            } else {
                return "no i not found it";
            }
        } catch (Exception $e) {
            return $e->getMessage();
        }
    }

    public function lastRecord()
    {
        return Receipt::latest()->first();
    }

    public function printPath()
    {
        if (!File::exists("/Users/ahmadabotrab/Desktop/ahmad")) {
            File::makeDirectory("/Users/ahmadabotrab/Desktop/ahmad");
            echo "created";
        } else {
            echo "find";
        }
    }

    public function getBetweenDateRange(Request $request)
    {
        $startDateInput = $request->input("startDate");
        $endDateInput = $request->input("endDate");
        $startDate_convertedToTimestamp = strtotime($startDateInput);
        $endDate_convertedToTimestamp = strtotime($endDateInput);
        $startDate_usedToQuery = date('Y-m-d', $startDate_convertedToTimestamp);
        $endDate_usedToQuery = date('Y-m-d', $endDate_convertedToTimestamp);
        if ($startDate_usedToQuery == $endDate_usedToQuery) {
            return Receipt::whereDate('created_at', $startDate_usedToQuery)
                ->get();
        } else {
            return Receipt::
            whereBetween('created_at', [$startDate_usedToQuery, $endDate_usedToQuery])
                ->lastest()
                ->get();
        }
    }

}
