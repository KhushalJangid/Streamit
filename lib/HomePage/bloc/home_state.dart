part of 'home_bloc.dart';

@immutable
sealed class HomeState {}

final class HomeInitial extends HomeState {}

final class HomeLoading extends HomeState {}

final class HomeLoaded extends HomeState {
  final HomeScreenData data;
  HomeLoaded(this.data);
}

final class Home404 extends HomeState {}

final class NoInternet extends HomeState {}
