import 'package:flutter/material.dart';
import 'package:showny/screens/tabs/home/screen/styleup_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class StyleUpVideo extends StatefulWidget {
  final String videoUrl;
  const StyleUpVideo({
    super.key,
    required this.videoUrl,
  });

  @override
  State<StyleUpVideo> createState() => _StyleUpVideoState();
}

class _StyleUpVideoState extends State<StyleUpVideo> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
  }

  @override
  void dispose() {
    _controller.pause();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.videoUrl),
      onVisibilityChanged: (info) {
        if (info.visibleFraction == 0) {
          _controller.pause();
        } else {
          _controller.play();
        }
      },
      child: GestureDetector(
        onTap: () {
          if (_controller.value.isPlaying) {
            _controller.pause();
          } else {
            _controller.play();
          }
        },
        child: VideoPlayer(_controller),
      ),
    );
  }
}
