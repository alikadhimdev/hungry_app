import 'package:dio/dio.dart';
import 'package:hungry_app/core/network/api_error.dart';

class ApiExceptions {
  static ApiError handleApiError(DioException error) {
    final statusCode = error.response?.data["error"]["statusCode"];

    final data = error.response?.data;
    if (data is Map<String, dynamic>) {
      // التحقق من وجود رسالة عربية
      if (data["error"] != null && data["error"]["isArabic"] == true && data["error"]["arabicMessage"] != null) {
        return ApiError(message: data["error"]["arabicMessage"], statusCode: statusCode);
      }
      // التحقق من وجود رسالة عامة
      else if (data["message"] != null) {
        return ApiError(message: data["message"], statusCode: statusCode);
      }
    }

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
