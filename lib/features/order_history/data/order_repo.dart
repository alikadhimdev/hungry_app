import 'package:dio/dio.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/core/network/api_exceptions.dart';
import 'package:hungry_app/core/network/api_service.dart';
import 'package:hungry_app/features/order_history/data/order_model.dart';

class OrderRepo {
  ApiService apiService = ApiService();

  Future<OrderModel?> addOrder(Map<String, dynamic> body) async {
    try {
      print(body);
      final response = await apiService.post("/orders", body);

      if (response["status"] != 200 || response["success"] != "success") {
        throw ApiError(message: response["message"]);
      }
      final order = response["data"];

      return order;
    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    } catch (e) {
      print(e);
      throw ApiError(message: e.toString());
    }
  }
}
