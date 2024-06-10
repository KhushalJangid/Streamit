import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_video_progress/smooth_video_progress.dart';
import 'package:streamit/customPlayer/provider/orientation.dart' as helper;
import 'package:video_player/video_player.dart';
import 'package:provider/provider.dart';

class StreamItPlayer extends StatefulWidget {
  final VideoPlayerController controller;
  const StreamItPlayer({
    super.key,
    required this.controller,
  });

  @override
  State<StreamItPlayer> createState() => _StreamItPlayerState();
}

class _StreamItPlayerState extends State<StreamItPlayer> {
  bool _controlsVisible = true;
  bool _showSkipForwardIndicator = false;
  bool _showSkipBackwardIndicator = false;
  Timer? _hideTimer;

  @override
  void initState() {
    super.initState();
    _startHideTimer();
  }

  @override
  void dispose() {
    // widget.controller.dispose();
    _hideTimer?.cancel();
    super.dispose();
  }

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      setState(() {
        _controlsVisible = false;
      });
    });
  }

  void _onTap() {
    print("!!!!!! Tapped !!!!!!!!!");
    setState(() {
      _controlsVisible = !_controlsVisible;
      if (_controlsVisible) {
        _startHideTimer();
      } else {
        _hideTimer?.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.controller.value.isInitialized) {
      return Consumer<helper.OrientationProvider>(
        builder:
            (context, helper.OrientationProvider orientationProvider, child) {
          if (orientationProvider.orientation is helper.Portrait) {
            final size = orientationProvider.orientation.size(context);
            return GestureDetector(
              onTap: _onTap,
              onDoubleTapDown: (details) {
                print("!!!!!! Double Tapped !!!!!");
                if (details.localPosition.dx > (size.width / 2)) {
                  widget.controller.seekTo(
                    widget.controller.value.position +
                        const Duration(seconds: 10),
                  );
                  setState(() {
                    _showSkipForwardIndicator = true;
                  });
                  Timer(const Duration(milliseconds: 500), () {
                    setState(() {
                      _showSkipForwardIndicator = false;
                    });
                  });
                } else {
                  widget.controller.seekTo(
                    widget.controller.value.position -
                        const Duration(seconds: 10),
                  );
                  setState(() {
                    _showSkipBackwardIndicator = true;
                  });
                  Timer(const Duration(milliseconds: 500), () {
                    setState(() {
                      _showSkipBackwardIndicator = false;
                    });
                  });
                }
              },
              child: SizedBox(
                width: size.width,
                height: size.height,
                child: Stack(
                  children: [
                    VideoPlayer(widget.controller),
                    if (_controlsVisible || !widget.controller.value.isPlaying)
                      VideoControls(controller: widget.controller),
                    if (_showSkipBackwardIndicator)
                      SkipBackwardOverlay(
                        size: size,
                      ),
                    if (_showSkipForwardIndicator)
                      SkipForwardOverlay(
                        size: size,
                      )
                  ],
                ),
              ),
            );
          } else {
            final size = orientationProvider.orientation.size(context);
            return GestureDetector(
              onTap: _onTap,
              onDoubleTapDown: (details) {
                print("!!!!!! Double Tapped !!!!!");
                if (details.localPosition.dy > (size.width / 2)) {
                  widget.controller.seekTo(
                    widget.controller.value.position +
                        const Duration(seconds: 10),
                  );
                  setState(() {
                    _showSkipForwardIndicator = true;
                  });
                  Timer(const Duration(milliseconds: 500), () {
                    setState(() {
                      _showSkipForwardIndicator = false;
                    });
                  });
                } else {
                  widget.controller.seekTo(
                    widget.controller.value.position -
                        const Duration(seconds: 10),
                  );
                  setState(() {
                    _showSkipBackwardIndicator = true;
                  });
                  Timer(const Duration(milliseconds: 500), () {
                    setState(() {
                      _showSkipBackwardIndicator = false;
                    });
                  });
                }
              },
              child: RotatedBox(
                quarterTurns: 1,
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: Stack(
                    children: [
                      VideoPlayer(widget.controller),
                      if (_controlsVisible ||
                          !widget.controller.value.isPlaying)
                        VideoControls(
                          controller: widget.controller,
                        ),
                      if (_showSkipBackwardIndicator)
                        SkipBackwardOverlay(
                          size: size,
                        ),
                      if (_showSkipForwardIndicator)
                        SkipForwardOverlay(
                          size: size,
                        ),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}

class VideoControls extends StatefulWidget {
  final VideoPlayerController controller;

  const VideoControls({
    super.key,
    required this.controller,
  });

  @override
  State<VideoControls> createState() => _VideoControlsState();
}

class _VideoControlsState extends State<VideoControls> {
  final buttonStyle = IconButton.styleFrom(
    backgroundColor: Colors.black45,
    foregroundColor: Colors.white,
  );

  String getCurrentPosition(VideoPlayerController controller) {
    int seconds = controller.value.position.inSeconds;
    NumberFormat formatter = NumberFormat("00");
    if (seconds < 60) {
      return "00:${formatter.format(seconds)}";
    } else {
      int minutes = seconds ~/ 60;
      seconds = seconds % 60;
      return "${formatter.format(minutes)}:${formatter.format(seconds)}";
    }
  }

  String getDuration(VideoPlayerController controller) {
    int seconds = controller.value.duration.inSeconds;
    NumberFormat formatter = NumberFormat("00");
    if (seconds < 60) {
      return "00:${formatter.format(seconds)}";
    } else {
      int minutes = seconds ~/ 60;
      seconds = seconds % 60;
      return "${formatter.format(minutes)}:${formatter.format(seconds)}";
    }
  }

  updateUIonPositionUpdate() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {});
    });
  }

  @override
  void initState() {
    updateUIonPositionUpdate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back),
              ),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.language_rounded),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(CupertinoIcons.speedometer),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.video_settings),
              ),
            ],
          ),
          const Spacer(),
          Center(
            child: Container(
              constraints: const BoxConstraints(
                maxWidth: 250,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton.filled(
                    style: buttonStyle,
                    onPressed: () {},
                    icon: const Icon(Icons.skip_previous),
                  ),
                  IconButton.filled(
                    style: buttonStyle.copyWith(
                      minimumSize: const MaterialStatePropertyAll(
                        Size(50, 50),
                      ),
                    ),
                    onPressed: () {
                      if (!widget.controller.value.isBuffering) {
                        if (widget.controller.value.isPlaying) {
                          widget.controller.pause();
                        } else {
                          widget.controller.play();
                        }
                        setState(() {});
                      }
                    },
                    icon: widget.controller.value.isBuffering
                        ? const CircularProgressIndicator()
                        : widget.controller.value.isPlaying
                            ? const Icon(Icons.pause)
                            : const Icon(Icons.play_arrow),
                  ),
                  IconButton.filled(
                    style: buttonStyle,
                    onPressed: () {},
                    icon: const Icon(Icons.skip_next),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
          Row(
            children: [
              Text(getCurrentPosition(widget.controller)),
              Expanded(
                child: SmoothVideoProgress(
                  controller: widget.controller,
                  builder: (context, position, duration, child) => Slider(
                    onChangeStart: (_) => widget.controller.pause(),
                    onChangeEnd: (_) => widget.controller.play(),
                    onChanged: (value) {
                      widget.controller
                          .seekTo(Duration(milliseconds: value.toInt()));
                      setState(() {});
                    },
                    value: position.inMilliseconds.toDouble(),
                    min: 0,
                    max: duration.inMilliseconds.toDouble(),
                    thumbColor: Colors.green,
                    activeColor: Colors.green,
                    inactiveColor: Colors.green.shade100,
                  ),
                ),
              ),
              Text(getDuration(widget.controller)),
              IconButton(
                onPressed: () {
                  final provider = Provider.of<helper.OrientationProvider>(
                    context,
                    listen: false,
                  );
                  if (provider.orientation is helper.Portrait) {
                    provider.orientation = helper.Landscape();
                  } else {
                    provider.orientation = helper.Portrait();
                  }
                },
                icon: const Icon(
                  Icons.rotate_90_degrees_ccw,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class SkipBackwardOverlay extends StatelessWidget {
  final Size size;
  const SkipBackwardOverlay({
    super.key,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        height: size.height,
        width: size.width * 0.4,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.only(
            topRight: Radius.elliptical(
              size.width * 0.2,
              size.height / 2,
            ),
            bottomRight: Radius.elliptical(
              size.width * 0.2,
              size.height / 2,
            ),
          ),
        ),
        child: Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: Lottie.asset(
              'assets/animations/rewind.json',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}

class SkipForwardOverlay extends StatelessWidget {
  final Size size;
  const SkipForwardOverlay({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: size.height,
        width: size.width * 0.4,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.only(
            topLeft: Radius.elliptical(
              size.width * 0.2,
              size.height / 2,
            ),
            bottomLeft: Radius.elliptical(
              size.width * 0.2,
              size.height / 2,
            ),
          ),
        ),
        child: Center(
          child: SizedBox(
            height: 50,
            width: 50,
            child: Lottie.asset(
              'assets/animations/skip.json',
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
