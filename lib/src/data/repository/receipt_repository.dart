import 'dart:convert' as convert;
import 'dart:io';

import '/src/data/model/Receipt.dart';
import '../server/receipt_api.dart';

class ReceiptRepository {
  Future<List<Receipt>> getAllReceipts() async {
    final source = await ReceiptApi().getAllReceipt();
    var response = convert.jsonDecode(source.body);
    List<Receipt> x = [];
    for (int i = 0; i < response.length; i++) {
      Receipt receipt = Receipt.fromJson(response[i]);
      x.add(receipt);
    }
    return x;
  }

  Future<dynamic> addNewReceipt(
      Receipt receiptObject, File receiptFile, String fileName) async {
    final source = await ReceiptApi()
        .addNewReceipt(receiptObject.toJson(), receiptFile, fileName);
    return source;
  }

  Future<dynamic> getLastId() async {
    final response = await ReceiptApi().getLastId();
    if (response.body == '') {
      return null;
    }
    var result = convert.jsonDecode(response.body);
    return Receipt.fromJson(result);
  }
}
