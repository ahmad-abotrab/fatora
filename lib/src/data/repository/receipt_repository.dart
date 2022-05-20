import 'dart:convert' as convert;
import 'dart:io';

import '../web_services/receipt_api.dart';
import '/src/data/model/Receipt.dart';


class ReceiptRepository {
  ReceiptApi receiptApi  =  ReceiptApi();

  Future<dynamic> getAllReceipts() async {
    try{
      final source = await receiptApi.getAllReceipt();
      return source.data;
    } catch (e){
      rethrow;
    }
  }

  Future<dynamic> addNewReceipt(
      Receipt receiptObject, File receiptFile, String fileName) async {
    try{
      final source = await ReceiptApi()
          .addNewReceipt(receiptObject.toJson(), receiptFile, fileName);
      return source;
    }catch (e){
      rethrow;
    }
  }

  Future<dynamic> getLastId() async {
    try{
      final response = await ReceiptApi().getLastId();

      if (response.body == '') {
        return null;
      }
      var result = convert.jsonDecode(response.body);
      return Receipt.fromJson(result);
    }
    catch (e){
      rethrow ;
    }
  }
}
