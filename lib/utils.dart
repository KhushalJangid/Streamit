import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamit/MyCoursePage/bloc/course_bloc.dart';
import 'package:streamit/ViewCoursePage/Presentation/viewcoursepage.dart';
import 'package:streamit/ViewCoursePage/bloc/viewcourse_bloc.dart';

Future<bool> checkConnection() async {
  try {
    final result = await InternetAddress.lookup('example.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}

viewCourse(BuildContext context, int courseId) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => ViewCourseBloc(courseId),
        child: BlocProvider(
          create: (context) => CourseBloc(),
          child: ViewCoursePage(
            key: UniqueKey(),
          ),
        ),
      ),
    ),
  );
}

Route createAnimatedRoute(Widget screen) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
