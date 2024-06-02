import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:streamit/DatabaseConfig/course_model.dart';
import 'package:streamit/constants.dart';

class HomeScreenData {
  final List banners;
  final List courses;
  HomeScreenData(this.banners, this.courses);
}

class HomeDataBaseQuery {
  Future<HomeScreenData?> initData() async {
    try {
      final data = await CoursesApi().listCourses();
      final List<CourseMedia> courses = [];
      for (var d in data) {
        courses.add(CourseMedia.fromJson(d));
      }
      return HomeScreenData(courses, courses);
    } catch (e) {
      debugPrint('Error Occured Fetching Homescreen data : ${e.toString()}');
      return null;
    }
  }
}

class CoursesApi {
  final CancelToken cancelToken;
  final Dio dio;
  CoursesApi()
      : cancelToken = CancelToken(),
        dio = Dio();

  Future<List> listCourses() async {
    try {
      const String url = "$baseUrl/courses";
      final token = await const FlutterSecureStorage().read(key: "token");
      final response = await dio.get(
        url,
        cancelToken: cancelToken,
        options: Options(headers: {"Authorization": "Token $token"}),
      );

      final data = response.data;
      if (response.statusCode == 200) {
        return data as List;
      } else {
        throw data["error"];
      }
    } catch (e) {
      debugPrint(e.toString());
      throw e.toString();
    }
  }
}
