import 'package:bloc/bloc.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:streamit/Player/Data/playerdata.dart';
import 'package:streamit/constants.dart';
import 'package:streamit/utils.dart';
import 'package:video_player/video_player.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  // final String courseId;
  // final String videoId;
  PlayerBloc(
      // required this.courseId,
      // required this.videoId,
      )
      : super(PlayerLoading()) {
    on<PlayerInitialize>((event, emit) {
      emit(PlayerLoading());
    });
    on<StartPlayer>((event, emit) async {
      try {
        final c = await checkConnection();
        if (c) {
          final data =
              await loadData(courseId: event.courseId, videoId: event.videoId);
          final videoPlayerController = VideoPlayerController.networkUrl(
            Uri.parse(
              "$baseUrl/${data.uri}",
            ),
          );
          final controller = ChewieController(
            videoPlayerController: videoPlayerController,
            autoInitialize: true,
            aspectRatio: 16 / 9,
            overlay: const ColoredBox(color: Colors.transparent),
            looping: false,
            materialProgressColors: ChewieProgressColors(
              playedColor: Colors.green,
              handleColor: Colors.green,
              bufferedColor: Colors.green.shade200,
              backgroundColor: Colors.green.shade100,
            ),
            cupertinoProgressColors: ChewieProgressColors(
              playedColor: Colors.green,
              handleColor: Colors.green,
              bufferedColor: Colors.green.shade200,
              backgroundColor: Colors.green.shade100,
            ),
            additionalOptions: (context) {
              return [
                OptionItem(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  iconData: Icons.keyboard_arrow_down,
                  title: "Minimize",
                ),
              ];
            },
          );

          emit(
            PlayerLoaded(
              controller,
              videoPlayerController,
              event.videoTitle,
            ),
          );
        } else {
          emit(NoInternet());
        }
      } catch (e) {
        emit(PlayerError(e.toString()));
      }
    });
    add(PlayerInitialize());
  }
  reset() async {
    add(PlayerInitialize());
  }
}
