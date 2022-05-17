import 'package:http/http.dart' as http;

import '../../Constant/url_api.dart';

class ReceiptApi {
  Future<dynamic> getAllReceipt() async {
    try {
      var uri = URLApi.getAllReceipts;
      http.Response response = await http.get(Uri.parse(uri));
      print(response);
      return response;
    } catch (e) {
      return [];
    }
  }

  Future<dynamic> addNewReceipt(receipt) async {
    var uri = URLApi.addNewReceipt;
    http.Response response = await http.post(Uri.parse(uri), body: receipt);
    print(response);
    return response;
  }
}
