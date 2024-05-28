import 'package:flutter/material.dart';

class HomeScreenData {
  final List banners;
  final List courses;
  HomeScreenData(this.banners, this.courses);
}

class HomeDataBaseQuery {
  Future<HomeScreenData?> initData() async {
    try {
      return HomeScreenData([], []);
    } catch (e) {
      debugPrint('Error Occured Fetching Homescreen data : ${e.toString()}');
      return null;
    }
  }
}
