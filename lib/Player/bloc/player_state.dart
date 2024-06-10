part of 'player_bloc.dart';

@immutable
sealed class PlayerState {}

final class PlayerInitial extends PlayerState {}

final class PlayerLoading extends PlayerState {}

final class PlayerLoaded extends PlayerState {
  final String videoTitle;
  final ChewieController controller;
  final VideoPlayerController vController;
  PlayerLoaded(this.controller, this.vController, this.videoTitle);
}

final class PlayerError extends PlayerState {
  final String error;
  PlayerError(this.error);
}

final class NoInternet extends PlayerState {}

class PlayerMedia {
  final String uri;
  PlayerMedia({required this.uri});
}
