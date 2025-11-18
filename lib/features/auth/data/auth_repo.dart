import 'package:dio/dio.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/core/network/api_exceptions.dart';
import 'package:hungry_app/core/network/api_service.dart';
import 'package:hungry_app/core/utils/pref_helper.dart';
import 'package:hungry_app/features/auth/data/user_model.dart';

class AuthRepo {
  ApiService apiService = ApiService();

  // login
  Future<UserModel?> login(String email, String password) async {
    try {
      final response = await apiService.post("/auth/login", {
        "email": email,
        "password": password,
      });

      if (response is ApiError) {
        throw response;
      }

      if (response is Map<String, dynamic>) {
        if (response["status"] == "fail") {
          final msg = response["error"]["isArabic"] == true
              ? response["error"]["arabicMessage"]
              : response["error"]["message"];
          throw ApiError(message: msg);
        }
        final user = UserModel.fromJson(response["data"]);
        if (user.token != null || user.token != "") {
          await PrefHelper.saveToken(user.token!);
        }
        return user;
      } else {
        throw ApiError(message: "Something went wrong");
      }
    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }
  // register

  Future<UserModel?> register(
    String name,
    String email,
    String password,
    String confirmPassword,
  ) async {
    try {
      final response = await apiService.post("/auth/register", {
        "name": name,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
      });

      if (response is ApiError) {
        throw response;
      }

      final user = UserModel.fromJson(response["data"]);

      if (user.token != null || user.token != "") {
        await PrefHelper.saveToken(user.token!);
      }

      return user;
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // get profile

  // update profile

  // logout
}
