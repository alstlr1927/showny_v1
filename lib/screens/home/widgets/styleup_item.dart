import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/back_blur/back_blur.dart';
import 'package:showny/components/custom_long_press/custom_long_press.dart';
import 'package:showny/components/user_profile/profile_container.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/screens/home/providers/styleup_item_provider.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/home/widgets/drag_item_tag.dart';
import 'package:showny/screens/home/widgets/following_button.dart';
import 'package:showny/screens/home/widgets/product_container.dart';
import 'package:showny/screens/home/widgets/tool_box.dart';
import 'package:showny/screens/home/widgets/styleup_image.dart';
import 'package:showny/screens/home/widgets/styleup_video.dart';
import 'package:showny/screens/profile/other_profile_screen.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';
import 'package:video_player/video_player.dart';

class StyleUpItem extends StatefulWidget {
  final bool isMain;
  final StyleupModel styleUp;
  final VoidCallback? onSelect;
  final int index;

  final Function({required String styleUpNo, required bool value})?
      afterFollowAction;
  final Function({required String styleUpNo, required int value})?
      afterUpDownAction;
  const StyleUpItem({
    super.key,
    required this.styleUp,
    this.onSelect,
    required this.index,
    this.isMain = false,
    this.afterFollowAction,
    this.afterUpDownAction,
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
          return Material(
            child: Column(
              children: [
                Expanded(
                  child: LayoutBuilder(
                    builder: (context, layout) {
                      return Stack(
                        children: [
                          _buildStyleUp(prov, layout),
                          _buildOptions(prov, layout),
                          _buildSelectLayer(prov),
                          _buildProductLayer(prov),
                        ],
                      );
                    },
                  ),
                ),
                if (!widget.isMain) ...{
                  Container(
                    width: double.infinity,
                    height: 56 + MediaQuery.of(context).padding.bottom,
                    color: Colors.black,
                    padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                    child: Column(
                      children: [
                        SizedBox(height: 5.toWidth),
                        _buildBottomBanner(),
                      ],
                    ),
                  ),
                },
              ],
            ),
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
            child: Stack(
              children: [
                if (isImage) ...{
                  StyleUpImage(imageList: widget.styleUp.imgUrlList),
                } else ...{
                  StyleUpVideo(
                    videoUrl: widget.styleUp.videoUrl,
                    videoController: prov.videoController!,
                    layout: layout,
                  ),
                },
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

  Widget _buildOptions(StyleUpItemProvider prov, BoxConstraints layout) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    return Container(
      alignment: Alignment.topRight,
      child: !prov.showTags
          ? ToolBox(
              upDownType: widget.styleUp.upDownType,
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
              tapUpDown: prov.updateUpDownType,

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
              margin: EdgeInsets.symmetric(horizontal: 26.toWidth),
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
    TextStyle selectedStyle = TextStyle(
        fontSize: ScreenUtil().setSp(44),
        color: Colors.white,
        fontWeight: FontWeight.w800,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
    TextStyle unSelectedStyle = TextStyle(
        fontSize: ScreenUtil().setSp(36),
        color: Colors.white,
        fontWeight: FontWeight.bold,
        leadingDistribution: TextLeadingDistribution.even,
        fontFamily: 'pretendard');
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
            gradient: RadialGradient(
              colors: [
                Colors.white.withOpacity(.3),
                Colors.white,
              ],
            )),
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
    return LayoutBuilder(builder: (context, layout) {
      double min = layout.maxHeight - (ScreenUtil().screenWidth * 4 / 3);

      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          // height: 190.toWidth,
          // width: double.infinity,
          constraints: BoxConstraints(
            minHeight: min <= 0 ? 0 : min,
          ),
          padding: EdgeInsets.all(16.toWidth),
          decoration: const BoxDecoration(
            color: Colors.transparent,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {
                  if (Provider.of<UserProvider>(context, listen: false)
                          .user
                          .memNo ==
                      widget.styleUp.userInfo.memNo) {
                    //
                  } else {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OtherProfileScreen(
                            memNo: widget.styleUp.userInfo.memNo,
                          ),
                        ));
                  }
                },
                child: Row(
                  children: [
                    ProfileContainer.size40(
                      url: widget.styleUp.userInfo.profileImage,
                    ),
                    SizedBox(width: 8.toWidth),
                    Text(
                      widget.styleUp.userInfo.nickNm,
                      style: ShownyStyle.body1(
                        color: Colors.white,
                        weight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(width: 8.toWidth),
                    if (userProv.user.memNo != widget.styleUp.userInfo.memNo &&
                        !widget.styleUp.userInfo.isFollow) ...{
                      FollowingButton(
                        isFollow: widget.styleUp.userInfo.isFollow,
                        memNo: widget.styleUp.memNo,
                        onCompleted: prov.setIsFollow,
                      ),
                    },
                  ],
                ),
              ),
              SizedBox(height: 10.toHeight),
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: prov.setExtendedText,
                child: Container(
                  constraints: BoxConstraints(
                    minHeight: 40.toWidth,
                  ),
                  child: Text(
                    widget.styleUp.description,
                    maxLines: prov.isExtendedText ? 15 : 2,
                    style: ShownyStyle.caption(color: Colors.white),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              SizedBox(height: 14.toHeight),
              if (widget.isMain) ...{
                _buildBottomBanner(),
              }
            ],
          ),
        ),
      );
    });
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
    return prov.showTags
        ? GestureDetector(
            onTap: () => prov.setShowTags(false),
            child: Container(
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenHeight,
              color: Colors.black.withOpacity(.7),
              child: Stack(
                children: [
                  ...widget.styleUp.goodsDataList[prov.curImgIdx].map((item) {
                    return Positioned(
                      left: item.left * ScreenUtil().screenWidth,
                      top: item.top * ScreenUtil().screenWidth * 6 / 4,
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
