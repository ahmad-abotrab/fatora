import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import '/src/data/model/local_id_for_receipt.dart';
import '../model/receipt_model.dart';
import '../web_services/receipt_api.dart';

class ReceiptRepository {
  ReceiptApi receiptApi = ReceiptApi();

  Future<dynamic> updateLocalNumId(LocalIdForReceipt localID) async{
    print(localID.charReceiptForEachEmployee);
    print(localID.idReceiptForEachEmployee);
    try {
      final response = receiptApi.updateLocalNumId(localID.toJson());
      return response;
    } on DioError catch (dioError) {
      rethrow;
    }
  }

  Future<dynamic> addNewCharIdForThisApp() async {
    try {
      final source = await receiptApi.addNewCharIdForThisApp();
      var result = LocalIdForReceipt.fromJson(source);
      return result;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> getAllReceipts() async {
    try {
      final source = await receiptApi.getAllReceipt();
      var result = source.map<Receipt>((e) => Receipt.fromJson(e)).toList();
      return result;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> uploadReceipt(fileName)async{
    try{

      var source = await ReceiptApi().uploadReceipt(fileName);
      var dir = (await getTemporaryDirectory()).path;
      File file = File(dir + '/' + fileName);
      File newFile = await file.writeAsBytes(source);
      return newFile;
    } catch(error){
      rethrow ;
    }
  }

  Future<dynamic> addNewReceipt(

      Receipt receiptObject, File receiptFile, String fileName) async {

    try {
      String source = await ReceiptApi()
          .addNewReceipt(receiptObject.toJson(), receiptFile, fileName);
      return source;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> getLastId() async {
    try {
      final response = await ReceiptApi().getLastId();
      if (response.data == '') {
        return null;
      }

      return Receipt.fromJson(response.data);
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> getReceiptsBetweenRangeDate(
      DateTime startDate, DateTime endDate) async {
    try {
      final source =
          await ReceiptApi().getReceiptsBetweenRangeDate(startDate, endDate);
      var result = source.map<Receipt>((e) => Receipt.fromJson(e)).toList();
      return result;
    } catch (dioError) {
      rethrow;
    }
  }
}
