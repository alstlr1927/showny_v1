import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:showny/components/showny_image/showny_image.dart';

import 'package:showny/models/styleup_model.dart';

class FeedItem extends StatelessWidget {
  const FeedItem({
    super.key,
    // this.naviagtorKey,
    required this.item,
    this.isBattleUpload = false,
    this.selectedStyleup,
    required this.onSelected,
  });

  final StyleupModel item;
  final bool isBattleUpload;
  final StyleupModel? selectedStyleup;
  final Function() onSelected;

  @override
  Widget build(BuildContext context) {
    bool isVideo = true;
    if (item.type == "img") {
      isVideo = false;
    }

    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Stack(children: [
        ShownyImage(
          imageUrl: item.thumbnailUrl,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
        Positioned(
            top: 8,
            right: 8,
            child: Image.asset(isVideo
                ? "assets/icons/feed_item_video.png"
                : "assets/icons/feed_item_image.png")),
      ]),
      onPressed: () => {
        onSelected(),
      },
    );
  }
}
