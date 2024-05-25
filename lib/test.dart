// import 'package:flutter/material.dart';
// import 'package:flick_video_player/flick_video_player.dart';
// import 'package:video_player/video_player.dart';

// void main() => runApp(SamplePlayer());

// class SamplePlayer extends StatefulWidget {
//   SamplePlayer({Key? key}) : super(key: key);

//   @override
//   _SamplePlayerState createState() => _SamplePlayerState();
// }

// class _SamplePlayerState extends State<SamplePlayer> {
//   late FlickManager flickManager;
//   @override
//   void initState() {
//     super.initState();
//     flickManager = FlickManager(
//       videoPlayerController: VideoPlayerController.networkUrl(
//         Uri.parse(
//           "https://drive.google.com/uc?export=download&id=1KclC_6aFAS7P82i4nsVqmjuW301w98U4",
//           // 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     flickManager.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Directionality(
//         textDirection: TextDirection.ltr,
//         child: Scaffold(
//           body: Center(
//             child: FlickVideoPlayer(flickManager: flickManager),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

final videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(
    'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4'));

void main() => runApp(SamplePlayer());

class SamplePlayer extends StatefulWidget {
  SamplePlayer({Key? key}) : super(key: key);

  @override
  _SamplePlayerState createState() => _SamplePlayerState();
}

class _SamplePlayerState extends State<SamplePlayer> {
  // late FlickManager flickManager;
  final videoPlayerController = VideoPlayerController.networkUrl(
    Uri.parse(
      // 'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
      'http://192.168.219.90:3000/media/playlist.m3u8',
    ),
  );
  late ChewieController chewieController;
  @override
  void initState() {
    videoPlayerController.initialize();
    super.initState();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: true,
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Scaffold(
          body: Center(
            child: Chewie(
              controller: chewieController,
            ),
          ),
        ),
      ),
    );
  }
}
