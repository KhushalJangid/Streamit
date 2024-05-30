part of 'course_bloc.dart';

@immutable
sealed class CourseState {}

final class CourseInitial extends CourseState {}

final class CourseLoading extends CourseState {}

final class CourseLoaded extends CourseState {}

final class Course404 extends CourseState {}

final class NoInternet extends CourseState {}