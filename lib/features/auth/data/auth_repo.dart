import 'package:dio/dio.dart';
import 'package:hungry_app/core/network/api_error.dart';
import 'package:hungry_app/core/network/api_exceptions.dart';
import 'package:hungry_app/core/network/api_service.dart';
import 'package:hungry_app/core/utils/pref_helper.dart';
import 'package:hungry_app/features/auth/data/user_model.dart';

class AuthRepo {
  ApiService apiService = ApiService();
  bool isGest = false;
  UserModel? _currentUser;

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
        isGest = false;
        _currentUser = user;
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
      isGest = false;
      _currentUser = user;
      return user;
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  // get profile

  Future<UserModel?> profile() async {
    try {
      final token = await PrefHelper.getToken();
      if (token == null || token == "gest") {
        return null;
      }
      final response = await apiService.get("/auth/profile");
      final user = UserModel.fromJson(response["data"]);
      _currentUser = user;
      return user;
    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<UserModel?> updateProfile(
    String username,
    String email,
    String card,
    String address,
    String? image,
  ) async {
    try {
      final formDate = FormData.fromMap({
        "name": username,
        "email": email,
        "visa": card,
        "address": address,
        if (image != null && image.isNotEmpty)
          "image": await MultipartFile.fromFile(
            image,
            filename: image.split("/").last,
          ),
      });
      final response = await apiService.put("/auth/update", formDate);
      if (response["status"] == "success") {
        final updateUser = UserModel.fromJson(response["data"]);
        _currentUser = updateUser;
        return updateUser;
      } else if (response["status"] == "fail") {
        final msg = response["error"]["isArabic"] == true
            ? response["error"]["arabicMessage"]
            : response["error"]["message"];
        throw ApiError(message: msg);
      }
      return null;
    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await apiService.get("/auth/logout");
      await PrefHelper.clearToken();
      _currentUser = null;
      isGest = true;
    } on DioException catch (e) {
      throw ApiExceptions.handleApiError(e);
    } catch (e) {
      throw ApiError(message: e.toString());
    }
  }

  Future<void> continueGest() async {
    isGest = true;
    _currentUser = null;
    await PrefHelper.saveToken("gest");
  }

  Future<UserModel?> autoLogin() async {
    final token = await PrefHelper.getToken();

    if (token == null || token == "gest") {
      isGest = true;
      _currentUser = null;
      return null;
    }
    isGest = false;
    try {
      final user = await profile();
      _currentUser = user;
      return user;
    } catch (e) {
      await PrefHelper.clearToken();
      isGest = true;
      _currentUser = null;
      return null;
    }
  }

  UserModel? get currentUser => _currentUser;
  bool get isLoggedIn => !isGest && _currentUser != null;
}
