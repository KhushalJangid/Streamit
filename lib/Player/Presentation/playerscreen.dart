import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:streamit/Player/Presentation/videoplayer_wrapper.dart';
import 'package:streamit/Player/bloc/player_bloc.dart';
import 'package:streamit/customPlayer/videoplayer_wrapper.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({
    super.key,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PlayerBloc, PlayerState>(
        builder: (context, state) {
          if (state is PlayerLoaded) {
            return Dismissible(
              key: const ValueKey("VideoPlayer"),
              direction: DismissDirection.down,
              background: const ColoredBox(color: Colors.transparent),
              behavior: HitTestBehavior.translucent,
              onDismissed: (direction) {
                Navigator.pop(context);
              },
              child: PopScope(
                onPopInvoked: (didPop) {
                  print("Poped: $didPop");
                  if (didPop) {
                    // state.controller.dispose();
                    // state.vController.dispose();
                    // bloc.add(PlayerInitialize());
                  }
                },
                // child: Chewie(controller: state.controller),
                child: Scaffold(
                  body: Center(
                    child: StreamItPlayer(
                      controller: state.vController,
                    ),
                  ),
                ),
              ),
            );
          } else if (state is PlayerLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is NoInternet) {
            return SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.wifi_off,
                    size: 40,
                    color: Colors.amber,
                  ),
                  Text(
                    "No Internet",
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  IconButton.outlined(
                    onPressed: () {},
                    icon: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.refresh),
                        Text("Refresh"),
                      ],
                    ),
                  )
                ],
              ),
            );
          } else if (state is PlayerError) {
            // return Center(
            //   child: Lottie.asset(
            //     'assets/animations/404.json',
            //     repeat: false,
            //   ),
            // );
            return AlertDialog(
              icon: const Icon(Icons.error_outline),
              title: Text(state.error),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Okay"),
                ),
              ],
            );
          } else {
            return const Center(
              child: Text('Error Occured'),
            );
          }
        },
        listener: (context, state) {});
  }
}
