import 'package:flutter/material.dart';
import 'package:showny/components/showny_image/showny_image.dart';
import 'package:showny/utils/showny_util.dart';

class ProfileContainer extends StatelessWidget {
  final double? height;
  final double? width;
  final double borderWidth;
  final String? url;
  final VoidCallback? onPressed;
  final Widget? overlay;
  final Clip clip;

  ProfileContainer.size16({
    this.clip = Clip.antiAlias,
    this.onPressed,
    this.url,
    this.overlay,
  })  : borderWidth = 1,
        height = 16.toWidth,
        width = 16.toWidth;

  ProfileContainer.size24({
    this.clip = Clip.antiAlias,
    this.onPressed,
    this.url,
    this.overlay,
  })  : borderWidth = 1,
        height = 24.toWidth,
        width = 24.toWidth;

  ProfileContainer.size36({
    this.clip = Clip.antiAlias,
    this.onPressed,
    this.url,
    this.overlay,
  })  : borderWidth = 1,
        height = 36.toWidth,
        width = 36.toWidth;

  ProfileContainer.size40({
    this.clip = Clip.antiAlias,
    this.onPressed,
    this.url,
    this.overlay,
  })  : borderWidth = 1,
        height = 40.toWidth,
        width = 40.toWidth;

  ProfileContainer.size48({
    this.clip = Clip.antiAlias,
    this.onPressed,
    this.url,
    this.overlay,
  })  : borderWidth = 1,
        height = 48.toWidth,
        width = 48.toWidth;

  ProfileContainer.size56({
    this.clip = Clip.antiAlias,
    this.onPressed,
    this.url,
    this.overlay,
  })  : borderWidth = 2,
        height = 56.toWidth,
        width = 56.toWidth;

  ProfileContainer.size64({
    this.clip = Clip.antiAlias,
    this.onPressed,
    this.url,
    this.overlay,
  })  : borderWidth = 2,
        height = 64.toWidth,
        width = 64.toWidth;

  ProfileContainer.size70({
    this.clip = Clip.antiAlias,
    this.onPressed,
    this.url,
    this.overlay,
  })  : borderWidth = 2,
        height = 70.toWidth,
        width = 70.toWidth;

  ProfileContainer.size84({
    this.clip = Clip.antiAlias,
    this.onPressed,
    this.url,
    this.overlay,
  })  : borderWidth = 3,
        height = 84.toWidth,
        width = 84.toWidth;

  ProfileContainer.size96({
    this.clip = Clip.antiAlias,
    this.onPressed,
    this.url,
    this.overlay,
  })  : borderWidth = 3,
        height = 96.toWidth,
        width = 96.toWidth;

  ProfileContainer.size136({
    this.clip = Clip.antiAlias,
    this.onPressed,
    this.url,
    this.overlay,
  })  : borderWidth = 3,
        height = 136.toWidth,
        width = 136.toWidth;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            alignment: Alignment.center,
            height: height,
            width: width,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Center(
              child: RepaintBoundary(
                child: ClipOval(
                  clipBehavior: clip,
                  child: Center(
                    child: Builder(
                      builder: (context) {
                        if (url == '' || url == null) {
                          return buildEmptyImage();
                        } else {
                          return buildUrlImage();
                        }
                      },
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Image buildEmptyImage() {
    return Image.asset(
      'assets/images/emptyProfile.png',
      height: height! + 1,
      width: width! + 1,
      cacheWidth: (width! * 3).toInt(),
      fit: BoxFit.cover,
    );
  }

  Widget buildUrlImage() {
    return ShownyImage(
        fit: BoxFit.cover,
        height: height! + 1,
        width: width! + 1,
        imageUrl: url!,
        memCacheWidth: (width! * 3).toInt(),
        cacheManager: CustomCacheManager(),
        errorWidget: (ctx, url, _) => buildEmptyImage());
  }
}
