<?php

namespace App\Http\Controllers;

use App\Models\idReceipt;
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
                'idLocal' => $request->input('idLocal'),
                'amountNumeric' => $request->input('amountNumeric'),
                'amountText' => $request->input('amountText'),
                'causeOfPayment' => $request->input('causeOfPayment'),
                'receiptPdfFileName' =>$request->input('receiptPdfFileName'),
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
                $path = '/receipt';
                $file->storeAs($path, $fileName);
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

    public function filterByDate(Request $request)
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
            return
                Receipt::
                whereBetween('created_at', [$startDate_usedToQuery, $endDate_usedToQuery])
                    ->get();
        }
    }

    public function getLastId()
    {
        return Receipt::latest()->first();
    }


    public function updateIdNumberForEmployee(Request $request)
    {
        try {
            DB::table('id_receipts')
                ->where(
                    'charReceiptForEachEmployee' , $request->input('charReceiptForEachEmployee'))
                ->update(
                    ['idReceiptForEachEmployee' => $request->input('idReceiptForEachEmployee')]);
            return "success";
        } catch (Exception $exception) {
            return "fail cause " . $exception->getMessage();
        }
    }

    public function getLocalCharID()
    {
        $anotherIdChar = '';
        $anotherId = '';
        $result = DB::table('id_receipts')
            ->select('charReceiptForEachEmployee')
            ->latest()
            ->first();
        if ($result == null) {
            $anotherIdChar = 'A';
            $anotherId = '1';
        } else {
            $anotherIdChar = $this->incrementChar($result->charReceiptForEachEmployee);
            $anotherId = '1';
        }

//        try {
//            IdReceipt::create([
//                'charReceiptForEachEmployee' => $anotherIdChar,
//                'idReceiptForEachEmployee' => $anotherId,
//            ]);
            return array('charReceiptForEachEmployee' => $anotherIdChar, "idReceiptForEachEmployee" => $anotherId);
//        } catch (Exception $exception) {
//            return "fail cause " . $exception->getMessage();
//        }
    }

    public function allLocalIdChar()
    {
        return DB::table('id_receipts')->select("charReceiptForEachEmployee")->get();
    }

    public function incrementChar(string $character): string
    {
        $letterAscii = ord($character);
        $letterAscii++;
        return chr($letterAscii);
    }
}
