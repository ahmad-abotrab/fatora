<?php

namespace App\Http\Controllers;

use App\Models\IdReceipt;
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
            Receipt::create(
                [
                    'whoIsTake' => $request->input('whoIsTake'),
                    'idLocal' => $request->input('idLocal'),
                    'amountNumeric' => $request->input('amountNumeric'),
                    'amountText' => $request->input('amountText'),
                    'causeOfPayment' => $request->input('causeOfPayment'),
                    'receiptPdfFileName' => $request->input('receiptPdfFileName'),
                    'statusSend_WhatsApp' => $request->input('statusSend_WhatsApp'),
                    'date' => $request->input('date'),
                ]
            );
            $charId = substr($request->input('idLocal'), -1);
            $idNum = substr($request->input('idLocal'), 0);
            $result = DB::table('id_receipts')
                ->where('charReceiptForEachEmployee', $charId)
                ->get();

            if ($result->isEmpty()) {
                $idAndCharToMakeLocalId = $this->createNewLocalCharID();
//
                try {
                    IdReceipt::create([
                        "idReceiptForEachEmployee" => $idAndCharToMakeLocalId['idReceiptForEachEmployee'],
                        "charReceiptForEachEmployee" => $idAndCharToMakeLocalId['charReceiptForEachEmployee'],
                    ]);
                    return "success";
                } catch (Exception $exception) {
                    return $exception;
                }
            } else {
                return "success";
            }
        } catch (Exception $e) {
            return "fail cause " . $e->getMessage();
        }
    }

    public function store(Request $request)
    {
        try {
            $date = $request->input('date');
            $year = date('Y');
            $month = date('m');
            $day = date('d');
            if ($request->hasFile("receipt")) {
                $file = $request->file("receipt");
                $fileName = $file->getClientOriginalName();
                $path = '/receipt/' . $year . '/' . $month . '/' . $day;
                $tempPath = '/receipt/temp';
                $file->storeAs($path, $fileName);
                $file->storeAs($tempPath, $fileName);
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
            return false;
        } else {
            return true;
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
                    'charReceiptForEachEmployee', $request->input('charReceiptForEachEmployee'))
                ->update(
                    ['idReceiptForEachEmployee' => $request->input('idReceiptForEachEmployee')]);
            return "success";
        } catch (Exception $exception) {
            return "fail cause " . $exception->getMessage();
        }
    }

    public function createNewLocalCharID()
    {
        $anotherIdChar = '';
        $anotherId = '';
        $result = DB::table('id_receipts')
            ->orderBy('charReceiptForEachEmployee', 'desc')
            ->first();

        if (!$result) {
            $anotherIdChar = 'A';
            $anotherId = '0';
        } else {
            $anotherIdChar = $this->incrementChar($result->charReceiptForEachEmployee);
            $anotherId = '0';
        }
        return array('charReceiptForEachEmployee' => $anotherIdChar, "idReceiptForEachEmployee" => $anotherId, "statusSend_WhatsApp" => 0);
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

    public function checkIfDirIsThere(Request $request)
    {
        $filename = $request->input('fileName');
        $path = storage_path('app/receipt/temp' . $filename);
        return response()->file($path);
    }

    public function updateLocalNumId(Request $request)
    {
        DB::table('id_receipts')
            ->where('charReceiptForEachEmployee', $request->input('charReceiptForEachEmployee'))
            ->update(['idReceiptForEachEmployee' => $request->input('idReceiptForEachEmployee')]);
    }

    public function addLocalIdToServer(Request $request)
    {
        try {
            $input = $request->all();
            IdReceipt::create($input);
            return "done";
        } catch (Exception $exception) {
            return $exception;
        }
    }

    public function updateStatusOfWhatsAppSend(Request $request)
    {
        DB::table('receipts')
            ->where('idLocal', $request->input('idLocal'))
            ->update(['statusSend_WhatsApp' => $request->input('statusSend_WhatsApp')]);
    }

    public function getBeforeLocalID(Request $request)
    {

        $result= DB::table('id_receipts')
            ->where('charReceiptForEachEmployee', $request->input('charId'))
            ->get();
        if ($result->isEmpty()) {
            return 'not found';
        } else {
            return array("charReceiptForEachEmployee" => $result[0]->charReceiptForEachEmployee, "idReceiptForEachEmployee" => $result[0]->idReceiptForEachEmployee);
        }
    }

}
