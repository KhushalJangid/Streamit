import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:streamit/DatabaseConfig/user_model.dart';
import 'package:streamit/constants.dart';

class UserApi {
  final CancelToken cancelToken;
  final Dio dio;
  UserApi()
      : cancelToken = CancelToken(),
        dio = Dio();

  Future<bool> login(String email, String password) async {
    try {
      const String url = "$baseUrl/u/login";
      final response = await dio.post(
        url,
        data: {
          "email": email,
          "password": password,
        },
        cancelToken: cancelToken,
        options: Options(),
      );

      final data = response.data;
      if (response.statusCode == 202) {
        const FlutterSecureStorage().write(key: "token", value: data["token"]);
        UserMedia.fromJson(data).save();
        return true;
      } else {
        throw data["error"];
      }
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }

  Future<bool> signup(String email, String password) async {
    try {
      const String url = "$baseUrl/u/user";
      final response = await dio.get(url, cancelToken: cancelToken);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }
}
