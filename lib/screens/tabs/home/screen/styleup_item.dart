import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/back_blur/back_blur.dart';
import 'package:showny/components/custom_long_press/custom_long_press.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/providers/styleup_item_provider.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/tabs/home/components/drag_item_tag.dart';
import 'package:showny/screens/tabs/home/components/following_button.dart';
import 'package:showny/screens/tabs/home/components/product_container.dart';
import 'package:showny/screens/tabs/home/components/tool_box.dart';
import 'package:showny/screens/tabs/home/screen/styleup_image.dart';
import 'package:showny/screens/tabs/home/screen/styleup_video.dart';
import 'package:video_player/video_player.dart';

class StyleUpItem extends StatefulWidget {
  final StyleupModel styleUp;
  final VoidCallback? onSelect;
  final int index;
  const StyleUpItem({
    super.key,
    required this.styleUp,
    this.onSelect,
    required this.index,
  });

  @override
  State<StyleUpItem> createState() => _StyleUpItemState();
}

class _StyleUpItemState extends State<StyleUpItem> {
  bool isImage = true;
  @override
  void initState() {
    super.initState();
    if (widget.styleUp.type != 'img') {
      isImage = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StyleUpItemProvider>(
      create: (_) => StyleUpItemProvider(this),
      builder: (context, _) {
        return Consumer<StyleUpItemProvider>(builder: (context, prov, child) {
          return LayoutBuilder(
            builder: (context, layout) {
              return Stack(
                children: [
                  _buildStyleUp(prov, layout),
                  _buildOptions(prov),
                  _buildSelectLayer(prov),
                  _buildProductLayer(prov),
                ],
              );
            },
          );
        });
      },
    );
  }

  Widget _buildStyleUp(StyleUpItemProvider prov, BoxConstraints layout) {
    return Stack(
      children: [
        if (isImage) ...{
          BackBlurWidget2(image: widget.styleUp.imgUrlList.first)
        },
        SafeArea(
          bottom: false,
          top: isImage ? true : false,
          child: CustomLongPress(
            duration: prov.longPressDuration,
            onLongPress: prov.onLongPress,
            onLongPressStart: prov.onLongPressStart,
            onLongPressCancel: prov.onLongPressCancel,
            onLongPressMoveUpdate: prov.onLongPressMoveUpdate,
            onLongPressEnd: prov.onLongPressEnd,
            onLongPressUp: prov.onLongPressUp,
            child: isImage
                ? Column(
                    children: [
                      StyleUpImage(imageList: widget.styleUp.imgUrlList),
                      _buildDescription(prov),
                    ],
                  )
                : Stack(
                    children: [
                      StyleUpVideo(
                        videoUrl: widget.styleUp.videoUrl,
                        videoController: prov.videoController!,
                      ),
                      _buildDescription(prov),
                    ],
                  ),
          ),
        ),
        if (!isImage) ...{
          Align(
            alignment: Alignment.bottomCenter,
            child: VideoProgressIndicator(
              prov.videoController!,
              allowScrubbing: true,
              padding: const EdgeInsets.only(top: 30),
              colors: VideoProgressColors(
                backgroundColor: Colors.white.withOpacity(.5),
                bufferedColor: Colors.transparent,
                playedColor: const Color(0xff656565),
              ),
            ),
          ),
        },
      ],
    );
  }

  Widget _buildOptions(StyleUpItemProvider prov) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    return Container(
      alignment: Alignment.topRight,
      child: !prov.showTags
          ? ToolBox(
              isVideo: widget.styleUp.type == "video" ? true : false,
              styleupNo: widget.styleUp.styleupNo,
              memNo: user.memNo,
              tapTag: () => prov.setShowTags(true),
              tapComment: () => prov.onClickComment(
                  styleupNo: widget.styleUp.styleupNo, memNo: user.memNo),
              isBookmark: widget.styleUp.isBookmark,
              tapBookmark: prov.onClickBookMark,
              tapShare: prov.onClickShare,
              tapSeeMore: () => prov.onClickMore(
                  styleupNo: widget.styleUp.styleupNo,
                  contentMemNo: widget.styleUp.memNo,
                  memNo: user.memNo,
                  index: widget.index),
              // tapSeeMore: () {
              //   // tapSeeMoreButton(
              //   //     styleupNo: widget.styleUp.styleupNo,
              //   //     contentMemNo: widget.styleUp.memNo,
              //   //     memNo: user.memNo,
              //   //     index: index);
              // },
            )
          : null,
    );
  }

  Widget _buildSelectLayer(StyleUpItemProvider prov) {
    return Stack(
      children: <Widget>[
        Column(
          children: <Widget>[
            if (prov.isSelectMode) ...{
              _buildSelectArea(
                areaIdx: 1,
                selected: prov.selected,
                type: 'UP',
              ),
              _buildSelectArea(
                areaIdx: 2,
                selected: prov.selected,
                type: 'DOWN',
              ),
            },
          ],
        ),
        if (prov.isSelectMode) ...{
          Align(
            alignment: Alignment.center,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 56),
              color: const Color(0xffd8d8d8),
              height: 1,
            ),
          ),
        },
        if (prov.isSelectMode && prov.startPosition != Offset.zero) ...{
          _virtualPadArea(prov),
          _virtualPad(prov),
        },
      ],
    );
  }

  Widget _buildSelectArea(
      {required int selected, required String type, required int areaIdx}) {
    bool isSelect = selected == areaIdx;
    TextStyle selectedStyle = const TextStyle(
        fontSize: 44, color: Colors.white, fontWeight: FontWeight.w800);
    TextStyle unSelectedStyle = const TextStyle(
        fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold);
    return Flexible(
      flex: 1,
      child: Container(
        color: Colors.black.withOpacity(isSelect ? .3 : .6),
        child: Center(
          child: Text(
            type,
            style: isSelect ? selectedStyle : unSelectedStyle,
          ),
        ),
      ),
    );
  }

  Widget _virtualPadArea(StyleUpItemProvider prov) {
    return Positioned(
      top: prov.startPosition.dy - (prov.virtualPadAreaDiameter / 2),
      left: prov.startPosition.dx - (prov.virtualPadAreaDiameter / 2),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: prov.virtualPadAreaDiameter,
        height: prov.virtualPadAreaDiameter,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: prov.selected != 0
              ? Colors.white.withOpacity(.6)
              : Colors.white.withOpacity(.3),
        ),
      ),
    );
  }

  Widget _virtualPad(StyleUpItemProvider prov) {
    return AnimatedPositioned(
      duration: Duration.zero,
      top: prov.movePosition.dy - (prov.movePadDiameter / 2),
      left: prov.movePosition.dx - (prov.movePadDiameter / 2),
      child: Container(
        width: prov.movePadDiameter,
        height: prov.movePadDiameter,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDescription(StyleUpItemProvider prov) {
    UserProvider userProv = Provider.of<UserProvider>(context, listen: false);
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: 210,
        width: double.infinity,
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 24),
        decoration: const BoxDecoration(
          color: Colors.transparent,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: Image.network(
                    widget.styleUp.userInfo.profileImage,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  widget.styleUp.userInfo.nickNm,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 8),
                if (userProv.user.memNo != widget.styleUp.userInfo.memNo) ...{
                  FollowingButton(
                    isFollow: widget.styleUp.userInfo.isFollow,
                    memNo: widget.styleUp.memNo,
                    onCompleted: prov.setIsFollow,
                  ),
                },
                // Text(
                //   widget.styleUp.upDownType == 1
                //       ? 'UP'
                //       : (widget.styleUp.upDownType == 2 ? 'DOWN' : ''),
                //   style: const TextStyle(
                //     color: Colors.white,
                //     fontSize: 16,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.styleUp.description,
              maxLines: 2,
              style: const TextStyle(
                overflow: TextOverflow.ellipsis,
                color: Colors.white,
              ),
            ),
            const Spacer(),
            _buildBottomBanner(),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomBanner() {
    return Container(
      child: widget.styleUp.goodsDataList.isNotEmpty
          ? ProductContainer(
              itemInfo: widget.styleUp.goodsDataList,
              styleNo: widget.styleUp.styleupNo,
              currentImageIdx: 0,
            )
          : null,
    );
  }

  Widget _buildProductLayer(StyleUpItemProvider prov) {
    final Size size = MediaQuery.of(context).size;
    return prov.showTags
        ? GestureDetector(
            onTap: () => prov.setShowTags(false),
            child: Container(
              width: size.width,
              height: size.height,
              color: Colors.black.withOpacity(.7),
              child: Stack(
                children: [
                  ...widget.styleUp.goodsDataList[prov.curImgIdx].map((item) {
                    return Positioned(
                      left: item.left * size.width,
                      top: item.top * size.width * 6 / 4,
                      child: tagWidget(
                        goodsNm: item.goodsNm,
                        price: item.goodsPrice.formatPrice(),
                        size: item.optionKey != ""
                            ? '${item.optionKey} : ${item.optionValue}'
                            : "",
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
          )
        : Container();
  }
}
