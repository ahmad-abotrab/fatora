import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  static fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        return "لقد تم إلغاء الطلب بشكل غير معرف";

      case DioErrorType.connectTimeout:
        return "تجاوز في الوقت المسموح للاتصال بالسيرفر ، هناك مشكلة بالاتصال";

      case DioErrorType.receiveTimeout:
        return "Connection to API server failed due to internet connection";

      case DioErrorType.other:
        return "لقد تجاوزت الوقت المسوح في انتظار استقبال البيانات ، قد لا يكون هنالك اتصال بالسيرفر";

      case DioErrorType.response:
        return handleError(
            dioError.response!.statusCode!, dioError.response!.data);

      case DioErrorType.sendTimeout:
        return "تجاوز في الوقت المسموح لارسال البيانات";

      default:
        return "الخطأ غير معرف يرجى مراجعة الشركة المصنعة";
    }
  }

  static handleError(int statusCode, dynamic error) {
    switch (statusCode) {
      case 400:
        return 'طلب خاطئ';
      case 404:
        return error["message"];
      case 500:
        return 'هناك مشكلة في السيرفر';
      default:
        return 'المشكلة غير معرفة يرجى مراجعة الشركة المصنعة';
    }
  }
}
// case DioErrorType.cancel:
// return "Request to API server was cancelled";
//
// case DioErrorType.connectTimeout:
// return "Connection timeout with API server";
//
// case DioErrorType.receiveTimeout:
// return "Connection to API server failed due to internet connection";
//
// case DioErrorType.other:
// return "Receive timeout in connection with API server";
//
// case DioErrorType.response:
// return handleError(
// dioError.response!.statusCode!, dioError.response!.data);
//
// case DioErrorType.sendTimeout:
// return "Send timeout in connection with API server";
//
// default:
// return "Something went wrong";
