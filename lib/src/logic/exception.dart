import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  static fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        return "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        return "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        return "Connection to API server failed due to internet connection";
        break;
      case DioErrorType.other:
        return "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        return handleError(
            dioError.response!.statusCode!, dioError.response!.data);
        break;
      case DioErrorType.sendTimeout:
        return "Send timeout in connection with API server";
        break;
      default:
        return "Something went wrong";
        break;
    }
  }

  static handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return error["message"];
      case 500:
        return 'Internal server error';
      default:
        return 'Oops something went wrong';
    }
  }
}
