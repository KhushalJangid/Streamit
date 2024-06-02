import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        child: ViewCoursePage(
          key: UniqueKey(),
        ),
      ),
    ),
  );
}
