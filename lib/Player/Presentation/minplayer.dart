import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:streamit/Player/Presentation/playerscreen.dart';
import 'package:streamit/Player/bloc/player_bloc.dart';
import 'package:streamit/utils.dart';
import 'package:video_player/video_player.dart';

class MiniPlayer extends StatefulWidget {
  const MiniPlayer({super.key});

  @override
  State<MiniPlayer> createState() => _MiniPlayerState();
}

class _MiniPlayerState extends State<MiniPlayer> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayerBloc, PlayerState>(builder: (context, state) {
      final width = MediaQuery.of(context).size.width;
      if (state is PlayerLoaded) {
        return Container(
          height: width * 0.2,
          width: width * 0.9,
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onSecondary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              SizedBox(
                height: width * 0.2,
                width: width * 0.4,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: VideoPlayer(state.vController)),
              ),
              // const Spacer(),
              SizedBox(
                height: width * 0.2,
                width: width * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8, left: 8),
                        child: Text(
                          state.videoTitle,
                          style: Theme.of(context).textTheme.bodySmall,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {
                              state.controller.togglePause();
                            });
                          },
                          icon: state.controller.isPlaying
                              ? const Icon(Icons.pause)
                              : const Icon(Icons.play_arrow),
                        ),
                        // AnimatedIcon(icon: AnimatedIcons.pause_play, progress: progress)
                        // const Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              createAnimatedRoute(
                                const PlayerScreen(),
                              ),
                              // PageTransition(
                              //   child: const PlayerScreen(),
                              //   type: PageTransitionType.bottomToTop,
                              //   duration: const Duration(milliseconds: 350),
                              //   curve: Curves.easeIn,
                              //   opaque: true,
                              // ),
                            );
                          },
                          icon: const Icon(Icons.keyboard_arrow_up),
                        ),
                        // const Spacer(),
                        IconButton(
                          onPressed: () {
                            state.controller.dispose();
                            state.vController.dispose();
                            BlocProvider.of<PlayerBloc>(context).add(
                              PlayerInitialize(),
                            );
                          },
                          icon: const Icon(Icons.clear),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        return const SizedBox();
      }
    });
  }
}
