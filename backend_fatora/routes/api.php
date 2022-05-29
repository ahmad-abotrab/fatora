<?php

use App\Http\Controllers\ReceiptController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| is assigned the "api" middleware group. Enjoy building your API!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

Route::controller(ReceiptController::class)->group(function () {
    Route::get('/allReceipt', 'allReceipt');
    Route::post('/addReceipt', 'addReceipt');
    Route::post('/store', 'store');
    Route::get('/lastRecord', 'lastRecord');
    Route::post('/filterByDate', 'filterByDate');
    Route::get('/getLocalCharID' , 'getLocalCharID');
    Route::put('/updateIdNumberForEmployee' , 'updateIdNumberForEmployee');
    Route::get('/allLocalIdChar','allLocalIdChar');
    Route::post('/checkIfDirIsThere' , 'checkIfDirIsThere');
    Route::put('/updateLocalNumId' , 'updateLocalNumId');


});
