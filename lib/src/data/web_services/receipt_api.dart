import 'dart:io';

import 'package:dio/dio.dart';
import 'package:fatora/src/data/model/temp.dart';

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

  Future<dynamic> addNewCharIdForThisApp() async {
    try {
      final response = await dio?.get('api/getLocalCharID');
      return response!.data;
    } on DioError catch (dioError) {
      throw DioExceptions.fromDioError(dioError);
    }
  }

  Future<dynamic> getAllReceipt() async {
    var url = URLApi.getAllReceipts;
    try {
      final response = await dio?.get(url);

      return response!.data;
    } on DioError catch (dioError) {
      throw DioExceptions.fromDioError(dioError);
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
          var res = await store(receiptFile, fileName);
          return res;
        } on DioError catch (dioError) {
          throw DioExceptions.fromDioError(dioError);
        }
      }
    } on DioError catch (dioError) {
      throw DioExceptions.fromDioError(dioError);
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
    } on DioError catch (dioError) {
      throw DioExceptions.fromDioError(dioError);
    }
  }

  Future<dynamic> getReceiptsBetweenRangeDate(
      DateTime startDate, DateTime endDate) async {
    try {
      Temp temp = Temp(startDate: startDate, endDate: endDate);
      final response = await dio?.post(
        URLApi.getReceiptsBetweenRangeDate,
        data: temp.toJson(),
      );

      return response!.data;
    } on DioError catch (dioError) {
      throw DioExceptions.fromDioError(dioError);
    }
  }

  Future<dynamic> getLastId() async {
    var url = URLApi.getLastId;
    try {
      final response = await dio?.get(url);
      return response;
    } on DioError catch (dioError) {
      throw DioExceptions.fromDioError(dioError);
    }
  }
}
