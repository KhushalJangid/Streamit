part of 'course_bloc.dart';

@immutable
sealed class CourseEvent {}

final class CourseLoadEvent extends CourseEvent {}
