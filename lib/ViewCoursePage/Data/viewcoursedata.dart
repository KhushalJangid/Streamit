import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:streamit/DatabaseConfig/course_model.dart';
import 'package:streamit/ViewCoursePage/bloc/viewcourse_bloc.dart';
import 'package:streamit/constants.dart';

Future<ViewCourseMedia> loadData(int id) async {
  try {
    final token = await const FlutterSecureStorage().read(key: "token");
    final response = await Dio().get(
      "$baseUrl/course?index=-1&id=$id",
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
      final videos = data["videos"] as List;
      return ViewCourseMedia(
        course: CourseMedia.fromJson(data),
        videos: videos.indexed.map((e) {
          e.$2["id"] = e.$1 + 1;
          return VideoMedia.fromJson(e.$2);
        }).toList(),
      );
    } else {
      throw response.data["error"];
    }
  } catch (e) {
    print("Error : ${e.toString()}");
    rethrow;
  }
}
