import 'dart:io';

import 'package:dio/dio.dart';

import '/src/data/model/local_id_for_receipt.dart';
import '../model/receipt_model.dart';
import '../web_services/receipt_api.dart';

class ReceiptRepository {
  ReceiptApi receiptApi = ReceiptApi();

  Future<dynamic> updateLocalNumId(LocalIdForReceipt localID) async {
    try {
      final response = receiptApi.updateLocalNumId(localID.toJson());
      return response;
    } on DioError {
      rethrow;
    }
  }

  Future<dynamic> getLocalIdExits(charId) async {
    try {
      final response = await receiptApi.getLocalIdExits(charId);
      try {
        var source = LocalIdForReceipt.fromJson(response);
        return source;
      } catch (e) {
        return LocalIdForReceipt();
      }
    } on DioError {
      rethrow;
    }
  }

  Future<dynamic> addLocalIdToServer(LocalIdForReceipt localId) async {
    try {
      final response = await receiptApi.addLocalIdToServer(localId.toJson());
      return response;
    } on DioError {
      rethrow;
    }
  }

  Future<dynamic> updateStatusOfSendReceiptToWhatsApp(idLocal, status) async {
    try {
      final response =
          await receiptApi.updateStatusOfSendReceiptToWhatsApp(idLocal, status);
      return response;
    } on DioError {
      rethrow;
    }
  }

  Future<dynamic> checkIfThereId(id) async {
    try {

      final f = await receiptApi.checkIfThereId(id);
      return f;
    } on DioError {
      rethrow;
    }
  }

  Future<dynamic> createNewLocalCharID() async {
    try {
      final source = await receiptApi.createNewLocalCharID();
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

  Future<dynamic> downloadReceipt(fileName) async {
    try {
      var source = await ReceiptApi().downloadReceipt(fileName);
      // var dir = (await getTemporaryDirectory()).path;
      // File file = File(dir + '/' + fileName);
      // var bytes = await consolidateHttpClientResponseBytes(source);
      // File newFile = await file.writeAsBytes(bytes);
      return source;
    } catch (error) {
      rethrow;
    }
  }

  Future<dynamic> addNewReceipt(
      Receipt receiptObject, File receiptFile, String fileName) async {
    try {
      print('lll');
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
