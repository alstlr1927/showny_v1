import 'package:blur/blur.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class StyleUpVideo extends StatefulWidget {
  final String videoUrl;
  final VideoPlayerController videoController;
  final BoxConstraints layout;
  const StyleUpVideo({
    super.key,
    required this.videoUrl,
    required this.videoController,
    required this.layout,
  });

  @override
  State<StyleUpVideo> createState() => _StyleUpVideoState();
}

class _StyleUpVideoState extends State<StyleUpVideo> {
  // late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    print('link : ${widget.videoUrl}');
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
    double videoWid = widget.videoController.value.size.width;
    double videoHei = widget.videoController.value.size.height;
    return SizedBox(
      width: widget.layout.maxWidth,
      height: widget.layout.maxHeight,
      child: VisibilityDetector(
        key: Key(widget.videoUrl),
        onVisibilityChanged: (info) {
          if (info.visibleFraction == 0) {
            widget.videoController.pause();
          } else {
            widget.videoController.play();
          }
        },
        child: GestureDetector(
          onTap: () {
            print('ratio : ${widget.videoController.value.aspectRatio}');
            if (widget.videoController.value.isPlaying) {
              widget.videoController.pause();
            } else {
              widget.videoController.play();
            }
          },
          child: videoHei <= videoWid
              ? Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        width: widget.layout.maxWidth,
                        height: widget.layout.maxHeight - 10,
                        color: Colors.black,
                      ),
                    ),
                    AspectRatio(
                      aspectRatio: widget.videoController.value.aspectRatio,
                      child: VideoPlayer(
                        widget.videoController,
                      ),
                    ),
                  ],
                )
              // : VideoPlayer(widget.videoController),
              : AspectRatio(
                  aspectRatio: widget.videoController.value.aspectRatio,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      width: widget.videoController.value.size.width,
                      height: widget.videoController.value.size.height,
                      child: VideoPlayer(widget.videoController),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
