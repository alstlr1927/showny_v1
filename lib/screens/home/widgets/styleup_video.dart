import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class StyleUpVideo extends StatefulWidget {
  final String videoUrl;
  final VideoPlayerController videoController;
  const StyleUpVideo({
    super.key,
    required this.videoUrl,
    required this.videoController,
  });

  @override
  State<StyleUpVideo> createState() => _StyleUpVideoState();
}

class _StyleUpVideoState extends State<StyleUpVideo> {
  // late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    // _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    // _controller.setLooping(true);
    // _controller.initialize().then((_) {
    //   setState(() {});
    // });
  }

  @override
  void dispose() {
    // _controller.pause();
    // _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.videoUrl),
      onVisibilityChanged: (info) {
        if (info.visibleFraction == 0) {
          widget.videoController.pause();
        } else {
          widget.videoController.play();
        }
      },
      child: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                if (widget.videoController.value.isPlaying) {
                  widget.videoController.pause();
                } else {
                  widget.videoController.play();
                }
              },
              child: VideoPlayer(widget.videoController),
            ),
          ),
          // Slider(
          //   value: _isSeeking
          //       ? _controller.value.position.inSeconds.toDouble()
          //       : _controller.value.position.inSeconds.toDouble(),
          //   min: 0,
          //   max: _controller.value.duration.inSeconds.toDouble(),
          //   onChanged: (value) {
          //     _isSeeking = true;
          //     _controller.seekTo(Duration(seconds: value.toInt()));
          //     setState(() {});
          //   },
          //   onChangeEnd: (value) {
          //     setState(() {
          //       _isSeeking = false;
          //       _controller.seekTo(Duration(seconds: value.toInt()));
          //     });
          //   },
          // ),
        ],
      ),
    );
  }
}
