import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../response/request/register_request_model.dart';
import '../response/response/error_response_model.dart';

class AuthLocalDatasource {
  Future<void> saveAuthData(RegisterRequestModel body) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("auth_data", body.toRawJson());
  }

  Future<void> removeAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("auth_data");
  }

  Future<Either<ErrorResponseModel, RegisterRequestModel>> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString("auth_data");

    if (authData == null) {
      return Left(ErrorResponseModel(message: "Auth data not found"));
    }

    return Right(RegisterRequestModel.fromRawJson(authData));
  }

  Future<Either<ErrorResponseModel, bool>> isAuth() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString("auth_data");

    if (authData == null) {
      return Left(ErrorResponseModel(message: "Auth data not found"));
    }

    return Right(true);
  }

  // Get the auth data from the local storage
  Future<void> saveLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isLogin", true);
  }

  Future<void> removeLogin() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("isLogin");
  }

  Future<Either<ErrorResponseModel, bool>> isLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getBool("isLogin");

    if (authData == null) {
      return Left(ErrorResponseModel(message: "Auth data not found"));
    }

    return Right(true);
  }
}
