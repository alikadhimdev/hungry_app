import 'package:dio/dio.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/core/network/api_exceptions.dart';
import 'package:hungry_app/core/network/api_service.dart';
import 'package:hungry_app/features/cart/data/cart_model.dart';

class CartRepo {
  ApiService apiService = ApiService();

  Future<CartModel?> getCart() async {
    try {
      final response = await apiService.get("/cart");
      if (response["status"] != 200 || response["success"] == "fail") {
        throw ApiError(message: response["message"]);
      }
      CartModel cart = CartModel.fromJson(response["data"]);

      return cart;
    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<Map<String, dynamic>> addToCart(
    String product,
    double spicey,
    List<String>? toppings,
    List<String>? sideOptions,
  ) async {
    try {
      final Map<String, dynamic> body = {
        "items": [
          {
            "product": product,
            "quantity": 1,
            "spicey": spicey,
            "toppings": toppings ?? [],
            "sideOptions": sideOptions ?? [],
          },
        ],
      };
      final response = await apiService.post("/cart", body);
      if (response["status"] != 200 || response["success"] == "fail") {
        throw ApiError(message: response["message"]);
      }
      return response;
    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<Map<String, dynamic>> deleteItem(String id) async {
    try {
      final response = await apiService.delete("/cart/$id");
      if (response["status"] != 200 || response["success"] == "fail") {
        throw ApiError(message: response["message"]);
      }
      return response;
    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<CartModel?> updateItem(String id, int qyt) async {
    try {
      final response = await apiService.put("/cart/$id", {"quantity": qyt});
      if (response["status"] != 200 || response["success"] == "fail") {
        throw ApiError(message: response["message"]);
      }

      final cart = CartModel.fromJson(response["data"]);
      return cart;
    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
