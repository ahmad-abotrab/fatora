import 'dart:io';

import 'package:dio/dio.dart';

import '/src/constant/url_api.dart';
import '/src/data/model/temp.dart';
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

  Future<dynamic> updateLocalNumId(localID) async {
    try {
      final response = await dio?.put(URLApi.updateLocalNumId, data: localID);
      return response;
    } on DioError catch (dioError) {
      throw DioExceptions.fromDioError(dioError);
    }
  }

  Future<dynamic> addLocalIdToServer(localId) async {
    try {
      final response =
          await dio?.post(URLApi.addLocalIdToServer, data: localId);
      return response!.data;
    } on DioError catch (dioError) {
      throw DioExceptions.fromDioError(dioError);
    }
  }

  Future<dynamic> createNewLocalCharID() async {
    try {
      final response = await dio?.get(URLApi.createNewLocalCharID);
      return response!.data;
    } on DioError catch (dioError) {
      throw DioExceptions.fromDioError(dioError);
    }
  }

  Future<dynamic> updateStatusOfSendReceiptToWhatsApp(idLocal, status) async {
    try {
      final response = await dio?.put(URLApi.updateStatusOfWhatsAppSend,
          data: {"idLocal": idLocal, "statusSend_WhatsApp": status});
      return response!.data;
    } on DioError catch (dioError) {
      throw DioExceptions.fromDioError(dioError);
    }
  }

  Future <dynamic> getLocalIdExits(charId)async{
    try {
      final response = await dio?.post(URLApi.getBeforeLocalID,data: {"charId":charId});
      return response!.data;
    } on DioError catch (dioError) {
      rethrow;
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

  Future<dynamic> downloadReceipt(fileName) async {
    try {
      var httpClient = HttpClient();
      var request = await httpClient.post(URLApi.host, URLApi.port,
          '/api/checkIfDirIsThere?fileName=$fileName');
      var response = request.close();
      return response;
    } on DioError catch (error) {
      throw DioExceptions.fromDioError(error);
    }
  }

  Future<dynamic> addNewReceipt(
      receiptObject, File receiptFile, fileName) async {
    var urlAddNewReceipt = URLApi.addNewReceipt;

    try {
      print("third");
      print(receiptObject['statusSend_WhatsApp']);
      final responseAddReceipt =
          await dio?.post(urlAddNewReceipt, data: receiptObject);
      print(responseAddReceipt);
      print("tggggghird");
      if (responseAddReceipt!.data == "success") {
        print('hsshhs');
        try {
          print("fourthx");
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
      'date': DateTime.now().toIso8601String(),
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
