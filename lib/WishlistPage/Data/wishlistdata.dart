import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:streamit/DatabaseConfig/course_model.dart';
import 'package:streamit/DatabaseConfig/database.dart';

const String baseUrl = 'http://192.168.62.90:8000';

Future<List<CourseMedia>> loadData() async {
  try {
    final wishlist = await MasterDB.instance.readAllNotes(wishlist_table_name);
    if (wishlist.isEmpty) {
      final token = await const FlutterSecureStorage().read(key: "token");
      final response = await Dio().get(
        "$baseUrl/wishlist",
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
        final data = response.data as List;
        return data.map((e) => CourseMedia.fromJson(e)).toList();
      } else if (response.statusCode == 204) {
        return [];
      } else {
        throw response.data["error"];
      }
    }
    return <CourseMedia>[];
  } catch (e) {
    print("Error : ${e.toString()}");
    rethrow;
  }
}
