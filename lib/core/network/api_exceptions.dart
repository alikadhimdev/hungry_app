import 'package:dio/dio.dart';
import 'package:hungry_app/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handleApiError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiError(message: "انتهت مهلة الاتصال");
      case DioExceptionType.badResponse:
        return _handleHttpError(error.response?.statusCode ?? 0);
      case DioExceptionType.connectionError:
      case DioExceptionType.unknown:
        return ApiError(message: "فشل الاتصال بالإنترنت");
      default:
        return ApiError(message: "حدث خطأ ما");
    }
  }

  static ApiError _handleHttpError(int statusCode) {
    switch (statusCode) {
      case 400:
        return ApiError(message: "طلب غير صالح");
      case 401:
        return ApiError(message: "غير مصرح بالوصول");
      case 404:
        return ApiError(message: "الصفحة غير موجودة");
      case 500:
        return ApiError(message: "خطأ في الخادم");
      default:
        return ApiError(message: "حدث خطأ");
    }
  }
}
