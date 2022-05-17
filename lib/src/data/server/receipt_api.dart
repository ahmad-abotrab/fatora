import 'package:http/http.dart' as http;

import '../../Constant/url_api.dart';

class ReceiptApi {
  Future<dynamic> getAllReceipt() async {
    try {
      var url = Uri.parse(URLApi.baseUrl + URLApi.getAllReceipts);
      http.Response response = await http.get(url);
      print(response);
      return response;
    } catch (e) {
      return [];
    }
  }

  Future<dynamic> addNewReceipt(receipt) async {
    var url = Uri.parse(URLApi.baseUrl + URLApi.addNewReceipt);
    http.Response response = await http.post(url, body: receipt);
    print(response);
    return response;
  }

  Future<dynamic> getLastId() async {
    var url = Uri.parse(URLApi.baseUrl + URLApi.getLastId);
    http.Response response = await http.get(url);
    print(response);
    return response;
  }
}
