import 'dart:io';

import 'package:http/http.dart' as http;

import '../../Constant/url_api.dart';
import '../../logic/exception.dart';

class ReceiptApi {
  Future<dynamic> getAllReceipt() async {
    var url = Uri.parse(URLApi.baseUrl + URLApi.getAllReceipts);
    http.Response response = await http.get(url);
    return response;
  }

  Future<dynamic> addNewReceipt(
      receiptObject, File receiptFile, fileName) async {
    var urlAddNewReceipt = Uri.parse(URLApi.baseUrl + URLApi.addNewReceipt);
    try {
      http.Response responseAddReceipt =
          await http.post(urlAddNewReceipt, body: receiptObject);

      if (responseAddReceipt.body == "success") {
        await store(receiptFile, fileName);
        print('ahmad');
      }
    } catch (e) {
      return e.toString();
    }
  }

  Future<dynamic> store(File file, fileName) async {
    try {
      var urlUploadFile = URLApi.baseUrl + URLApi.store;
      var request = http.MultipartRequest('POST', Uri.parse(urlUploadFile));
      request.headers.addAll(
        {
          "Accept": "application/json",
        },
      );
      var image = await http.MultipartFile.fromPath(
        "receipt",
        file.path,
        filename: fileName,
      );
      request.files.add(image);
      var response = await request.send();
      if (response.statusCode == 200) {
        print('good');
        return;
      } else if (response.statusCode == 400) {
        throw ServerException("Wrong form of image");
      } else if (response.statusCode == 401) {
        throw ServerException("Unauthenticated");
      } else {
        throw UnknownException("Something went wrong");
      }
    } on SocketException {
      throw NetworkException("No internet connection");
    }
  }

  Future<dynamic> getLastId() async {
    var url = Uri.parse(URLApi.baseUrl + URLApi.getLastId);
    http.Response response = await http.get(url);
    return response;
  }
}
