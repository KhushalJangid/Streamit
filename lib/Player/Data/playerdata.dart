import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:streamit/Player/bloc/player_bloc.dart';
import 'package:streamit/constants.dart';

Future<PlayerMedia> loadData(
    {required String courseId, required String videoId}) async {
  try {
    final token = await const FlutterSecureStorage().read(key: "token");
    final response = await Dio().get(
      "$baseUrl/$courseId/video/$videoId",
      options: Options(
        headers: {"Authorization": "Token $token"},
        validateStatus: (status) {
          if (status! >= 500) {
            return false;
          } else {
            return true;
          }
        },
      ),
    );
    if (response.statusCode == 200) {
      final data = response.data as Map;
      return PlayerMedia(uri: data["dataUrl"]);
    } else {
      throw response.data["error"];
    }
  } catch (e) {
    print("Error : ${e.toString()}");
    rethrow;
  }
}
