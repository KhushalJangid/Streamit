part of 'player_bloc.dart';

@immutable
sealed class PlayerEvent {}

final class PlayerInitialize extends PlayerEvent {}

final class StartPlayer extends PlayerEvent {
  final String courseId;
  final String videoId;
  final String videoTitle;
  StartPlayer({
    required this.courseId,
    required this.videoId,
    required this.videoTitle,
  });
}

final class DisposePlayer extends PlayerEvent {}
