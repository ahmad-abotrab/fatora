import 'dart:io';
import '../model/receipt_model.dart';
import '../web_services/receipt_api.dart';

class ReceiptRepository {
  ReceiptApi receiptApi = ReceiptApi();

  Future<dynamic> getAllReceipts() async {
    try {
      final source = await receiptApi.getAllReceipt();
      var result = source.map<Receipt>((e) => Receipt.fromJson(e)).toList();
      return result;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> addNewReceipt(
      Receipt receiptObject, File receiptFile, String fileName) async {
    try {
      final source = await ReceiptApi()
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
  Future<dynamic> getReceiptsBetweenRangeDate(DateTime startDate,
      DateTime endDate) async {
    try {
      final source = await ReceiptApi().getReceiptsBetweenRangeDate(startDate, endDate);
      var result = source.map<Receipt>((e) => Receipt.fromJson(e)).toList();
      return result;
    }catch(dioError){
      rethrow;
    }
  }
}
