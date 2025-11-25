import 'package:dio/dio.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/core/network/api_exceptions.dart';
import 'package:hungry_app/core/network/api_service.dart';
import 'package:hungry_app/features/product/data/toppings_model.dart';

class ToppingsRepo {
  ApiService apiService = ApiService();

  Future<List<ToppingsModel>?> getToppings() async {
    try {
      final response = await apiService.get("/toppings");

      if (response["status"] != 200 || response["success"] != "success") {
        throw ApiError(message: response["message"]);
      }

      final List<ToppingsModel> products = (response["data"])
          .map<ToppingsModel>((json) => ToppingsModel.fromJson(json))
          .toList();
      return products;
    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}

class SideOptionsRepo {
  ApiService apiService = ApiService();

  Future<List<SideOptionsModel>?> getSideOptions() async {
    try {
      final response = await apiService.get("/options");

      if (response["status"] != 200 || response["success"] != "success") {
        throw ApiError(message: response["message"]);
      }
      final List<SideOptionsModel> options = (response["data"])
          .map<SideOptionsModel>((json) => SideOptionsModel.fromJson(json))
          .toList();
      return options;
    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
