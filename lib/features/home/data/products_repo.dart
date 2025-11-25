import 'package:dio/dio.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/core/network/api_exceptions.dart';
import 'package:hungry_app/core/network/api_service.dart';
import 'package:hungry_app/features/home/data/product_model.dart';

class ProductsRepo {
  ApiService apiService = ApiService();

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await apiService.get("/product/");
      if (response["status"] != 200 || response["success"] != "success") {
        throw ApiError(message: response["message"]);
      }
      List<ProductModel> products = (response["data"] as List)
          .map((productJson) => ProductModel.fromJson(productJson))
          .toList();
      return products;
    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<ProductModel?> getProduct(String id) async {
    try {
      final response = await apiService.get("/product/$id");
      if (response["status"] != 200 || response["success"] != "success") {
        throw ApiError(message: response["message"]);
      }
      final product = ProductModel.fromJson(response["data"]);
      return product;
    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
}
