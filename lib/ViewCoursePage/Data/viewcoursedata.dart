import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:streamit/DatabaseConfig/course_model.dart';
import 'package:streamit/DatabaseConfig/database.dart';
import 'package:streamit/ViewCoursePage/bloc/viewcourse_bloc.dart';
import 'package:streamit/constants.dart';

Future<ViewCourseMedia> loadData(int id) async {
  try {
    final token = await const FlutterSecureStorage().read(key: "token");
    final response = await Dio().get(
      "$baseUrl/courses?index=-1&id=$id",
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
    debugPrint("Error : ${e.toString()}");
    rethrow;
  }
}

Future<bool> addToWishlist(CourseMedia course) async {
  try {
    final token = await const FlutterSecureStorage().read(key: "token");
    final response = await Dio().post(
      "$baseUrl/wishlist/add/${course.uniqueName}",
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
      Wishlist.instance.insert(course);
      return true;
    } else {
      throw response.data["error"];
    }
  } catch (e) {
    debugPrint("Error : ${e.toString()}");
    rethrow;
  }
}

Future<bool> removeFromWishlist(CourseMedia course) async {
  try {
    final token = await const FlutterSecureStorage().read(key: "token");
    final response = await Dio().post(
      "$baseUrl/wishlist/remove/${course.uniqueName}",
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
      Wishlist.instance.delete(course);
      return true;
    } else {
      throw response.data["error"];
    }
  } catch (e) {
    debugPrint("Error : ${e.toString()}");
    rethrow;
  }
}

Future<bool> purchase(CourseMedia course) async {
  try {
    final token = await const FlutterSecureStorage().read(key: "token");
    final response = await Dio().post(
      "$baseUrl/course/purchase/${course.uniqueName}",
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
      MycourseDB.instance.insert(course);
      return true;
    } else {
      throw response.data["error"];
    }
  } catch (e) {
    debugPrint("Error : ${e.toString()}");
    rethrow;
  }
}
