part of 'viewcourse_bloc.dart';

@immutable
sealed class ViewCourseEvent {}

final class ViewCourseLoadEvent extends ViewCourseEvent {}
