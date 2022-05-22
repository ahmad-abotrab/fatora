import 'dart:io';

import 'package:dio/dio.dart';

import '../../Constant/url_api.dart';
import '../../logic/exception.dart';

class ReceiptApi {
  Dio? dio;
  var options = BaseOptions(
    baseUrl: URLApi.baseUrl,
    receiveDataWhenStatusError: true,
    connectTimeout: 20 * 1000,
    receiveTimeout: 20 * 1000,
  );

  ReceiptApi() {
    dio = Dio(options);
  }

  Future<dynamic> getAllReceipt() async {
    var url = URLApi.getAllReceipts;
    try {
      final response = await dio?.get(url);

      return response!.data;
    } on DioError catch (errorDio) {
      throw DioExceptions.fromDioError(errorDio);
    }
  }

  Future<dynamic> addNewReceipt(

      receiptObject, File receiptFile, fileName) async {

    var urlAddNewReceipt = URLApi.addNewReceipt;
    try {
      final responseAddReceipt =
          await dio?.post(urlAddNewReceipt, data: receiptObject);
      

      if (responseAddReceipt!.data == "success") {
        try {
          return await store(receiptFile, fileName);
        } on DioError catch (errorDio) {
          throw DioExceptions.fromDioError(errorDio);
        }
      }
    } on DioError catch (errorDio) {
      print(errorDio.toString());
      throw DioExceptions.fromDioError(errorDio);
    }
  }

  Future<dynamic> store(File file, fileName) async {
    var urlUploadFile = URLApi.store;
    var formData = FormData.fromMap({
      'receipt': await MultipartFile.fromFile(file.path, filename: fileName),
    });

    try {
      await dio?.post(urlUploadFile, data: formData);
      return "success";
    } on DioError catch (errorDio) {
      throw DioExceptions.fromDioError(errorDio);
    }
  }

  Future<dynamic> getLastId() async {
   
    var url = URLApi.getLastId;
    try {
      final response = await dio?.get(url);
      return response;
    } on DioError catch (errorDio) {
      throw DioExceptions.fromDioError(errorDio);
    }
  }
}
