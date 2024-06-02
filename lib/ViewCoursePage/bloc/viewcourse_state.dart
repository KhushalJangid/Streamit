part of 'viewcourse_bloc.dart';

@immutable
sealed class ViewCourseState {}

final class ViewCourseInitial extends ViewCourseState {}

final class ViewCourseLoading extends ViewCourseState {}

final class ViewCourseLoaded extends ViewCourseState {
  final ViewCourseMedia data;
  ViewCourseLoaded(this.data);
}

final class ViewCourse404 extends ViewCourseState {}

final class NoInternet extends ViewCourseState {}

class ViewCourseMedia {
  final CourseMedia course;
  final List<VideoMedia> videos;
  ViewCourseMedia({required this.course, required this.videos});
}
