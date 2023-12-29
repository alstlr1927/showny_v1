import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/common/scroll_physics/custom_scroll_physics.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';
import 'package:showny/screens/intro/screen/login_popup_screen.dart';
import 'package:showny/screens/tabs/home/components/drag_item_tag.dart';
import 'package:showny/screens/tabs/home/components/product_container.dart';
import 'package:showny/screens/tabs/home/components/see_more_action_sheet.dart';
import 'package:showny/screens/tabs/home/components/tool_box.dart';
import 'package:showny/screens/tabs/home/components/up_down_buttons.dart';
import 'package:provider/provider.dart';
import 'package:showny/screens/tabs/home/screen/report_sheet_screen.dart';
import 'package:showny/screens/tabs/home/screen/styleup_item.dart';
import 'package:showny/screens/tabs/home/screen/styleup_screen_profile.dart';
import 'package:showny/screens/tabs/profile/provider/get_my_profile_provider.dart';
import 'package:showny/utils/images.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class StyleupScreen extends StatefulWidget {
  const StyleupScreen(
      {super.key,
      required this.initIndex,
      required this.styleupList,
      this.updateShowMenu,
      required this.isMain});

  final bool isMain;
  final int initIndex;
  final List<StyleupModel> styleupList;
  final Function? updateShowMenu;

  @override
  State<StyleupScreen> createState() => _StyleupScreenState();
}

class _StyleupScreenState extends State<StyleupScreen> {
  bool showTags = false;
  double navigatorHeight = 0.0; // 네비게이션 바 높이 변수를 추가

  List<StyleupModel> styleupList = [];
  // SwiperController swiperController = SwiperController();
  // SwiperController swiperControllerHorizontal = SwiperController();

  // bool isMoveInitIndex = false;
  // bool isVideoInit = false;

  // int horizontalSwiperIndex = 0;

  // String? reportValue;

  PageController pageController = PageController();

  void tapSeeMoreButton(
      {required String styleupNo,
      required String contentMemNo,
      required String memNo,
      required int index}) {
    final bool isMine = (contentMemNo == memNo);

    var tempContext = context;

    showModalBottomSheet(
      context: tempContext,
      useRootNavigator: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context2) {
        return SizedBox(
          height: 210.0,
          child: SeeMoreActionSheet(
            styleupNo: styleupNo,
            memNo: memNo,
            report: isMine ? false : true,
            primaryLabel: isMine ? '삭제하기' : '신고하기',
            primaryAction: () {
              isMine
                  ?
                  //삭제
                  showDialog(
                      context: tempContext,
                      builder: (context3) {
                        return ShownyDialog(
                          message: '게시글을 삭제하시겠습니까?',
                          primaryLabel: '취소',
                          secondaryLabel: '확인',
                          secondaryAction: () {
                            ApiHelper.shared.deleteStyleup(memNo, styleupNo,
                                (success) {
                              showDialog(
                                  context: tempContext,
                                  builder: (context2) {
                                    return ShownyDialog(
                                      message: '삭제가 완료되었습니다.',
                                      primaryLabel: '확인',
                                      primaryAction: () {
                                        Navigator.pop(tempContext);
                                        setState(() {
                                          styleupList.removeAt(index);
                                          debugPrint(
                                              styleupList.length.toString());
                                          debugPrint(
                                              styleupList.length.toString());
                                          Provider.of<GetMyProfileProvider>(
                                                  context,
                                                  listen: false)
                                              .removeMyStyleupList();
                                          Provider.of<GetMyProfileProvider>(
                                                  context,
                                                  listen: false)
                                              .getMyStyleupList(context);
                                          Provider.of<GetMyProfileProvider>(
                                                  context,
                                                  listen: false)
                                              .removeMyBookmarkList();
                                          Provider.of<GetMyProfileProvider>(
                                                  context,
                                                  listen: false)
                                              .getMyBookmarkList(context);
                                          // swiperController.move(index, animation: true);
                                          if (styleupList.isEmpty &&
                                              widget.isMain == false) {
                                            Navigator.pop(tempContext);
                                          }
                                        });
                                      },
                                    );
                                  });
                            }, (error) {
                              debugPrint(error);
                            });
                          },
                        );
                      })
                  :
                  //신고
                  showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 510.0,
                          child: ReportSheetScreen(
                            onCompleted: (int type) {
                              ApiHelper.shared.insertStyleupReport(
                                  styleupNo, memNo, type + 1, (success) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ShownyDialog(
                                        message: '신고가 완료되었습니다.',
                                        primaryLabel: '확인',
                                        primaryAction: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      );
                                    });
                              }, (error) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ShownyDialog(
                                        message: error,
                                        primaryLabel: '확인',
                                      );
                                    });
                              });
                            },
                          ),
                        );
                      },
                    );
            },
          ),
        );
      },
    );
  }

  void tapCommentButton(
    BuildContext context, {
    required String styleupNo,
    required String memNo,
  }) {
    // showModalBottomSheet(
    //   context: context,
    //   isScrollControlled: true,
    //   backgroundColor: Colors.transparent,
    //   useRootNavigator: true,
    //   isDismissible: true,
    //   enableDrag: false,
    //   builder: (context) {
    //     return CommentSheetScreen(
    //         memNo: memNo,
    //         styleupNo: styleupNo,
    //         onAddComment: () => setState(() {}));
    //   },
    // );
  }

  void updateShowTag(bool isShow) {
    setState(() {
      showTags = isShow;
    });
    if (widget.updateShowMenu != null) {
      widget.updateShowMenu!(isShow);
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      styleupList = widget.styleupList;
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  void didUpdateWidget(covariant StyleupScreen oldWidget) {
    styleupList = widget.styleupList;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    // UserProvider userProvider =
    //     Provider.of<UserProvider>(context, listen: false);
    // final user = userProvider.user;

    // double parentWidth = MediaQuery.of(context).size.width;

    // int? initIndex;
    // if (isMoveInitIndex == false) {
    //   initIndex = widget.initIndex;
    //   isMoveInitIndex = true;
    // }

    // VideoPlayerController? videoController;
    // Future<void>? initVideoController;

    return PageView(
      controller: pageController,
      scrollDirection: Axis.vertical,
      physics: const CustomScrollPhysics(),
      children: List.generate(
        widget.styleupList.length,
        (index) => StyleUpItem(
          styleUp: styleupList[index],
          index: index,
          onSelect: () {
            pageController.animateToPage(
              index + 1,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeIn,
            );
          },
        ),
      ),
    );

    // return Scaffold(
    //     body: Stack(
    //   alignment: Alignment.center,
    //   children: [
    //     Container(
    //       color: Colors.white,
    //     ),
    //     Swiper(
    //       index: initIndex,
    //       itemCount: styleupList.length,
    //       loop: false,
    //       controller: swiperController,
    //       scrollDirection: Axis.vertical,
    //       onIndexChanged: (int index) {
    //         horizontalSwiperIndex = 0;
    //         StyleupModel styleupData = styleupList[index];
    //         if (styleupData.type == "video") {
    //           if (videoController != null) {
    //             videoController!.pause();
    //             videoController!.dispose();
    //           }
    //           videoController = VideoPlayerController.networkUrl(
    //             Uri.parse(styleupData.videoUrl),
    //           );
    //           initVideoController = videoController!.initialize().then((value) {
    //             videoController?.setLooping(true);
    //             videoController?.play();
    //           });
    //         }
    //       },
    //       itemBuilder: (BuildContext context2, int index) {
    //         StyleupModel styleupData = styleupList[index];
    //         bool isVideo = true;

    //         if (styleupData.type == "img") {
    //           isVideo = false;
    //         } else {
    //           if (isVideoInit == false) {
    //             isVideoInit = true;

    //             StyleupModel styleupData = styleupList[index];
    //             if (styleupData.type == "video") {
    //               if (videoController != null) {
    //                 videoController!.pause();
    //                 videoController!.dispose();
    //               }

    //               videoController = VideoPlayerController.networkUrl(
    //                   Uri.parse(styleupData.videoUrl));
    //               initVideoController =
    //                   videoController!.initialize().then((value) {
    //                 debugPrint(styleupData.videoUrl);
    //                 videoController?.setLooping(true);
    //                 videoController?.play();
    //               });
    //             }

    //             debugPrint(styleupData.videoUrl);
    //           }
    //         }

    //         return Stack(
    //           children: [
    //             isVideo
    //                 ? Stack(
    //                     children: [
    //                       Image.network(styleupData.thumbnailUrl,
    //                           width: double.infinity,
    //                           height: double.infinity,
    //                           fit: BoxFit.cover,
    //                           errorBuilder: (context, error, StackTrace) {
    //                         return Container(
    //                           color: Colors.white,
    //                         );
    //                       }),
    //                       VisibilityDetector(
    //                           key: const Key('styleup_video'),
    //                           child: Stack(
    //                             children: [
    //                               videoController != null
    //                                   ? FutureBuilder(
    //                                       future: initVideoController,
    //                                       builder: (context, snapshot) {
    //                                         if (snapshot.connectionState ==
    //                                             ConnectionState.done) {
    //                                           return SizedBox.expand(
    //                                             child: FittedBox(
    //                                               fit: BoxFit.cover,
    //                                               child: SizedBox(
    //                                                 width: videoController
    //                                                         ?.value
    //                                                         .size
    //                                                         .width ??
    //                                                     0,
    //                                                 height: videoController
    //                                                         ?.value
    //                                                         .size
    //                                                         .height ??
    //                                                     0,
    //                                                 child: VideoPlayer(
    //                                                     videoController!),
    //                                               ),
    //                                             ),
    //                                           );
    //                                         } else if (snapshot.hasError) {
    //                                           debugPrint(
    //                                               "Error loading video: ${snapshot.error}");
    //                                           return Text(
    //                                             "Error loading video: ${snapshot.error}",
    //                                             style: TextStyle(
    //                                                 color: Colors.red),
    //                                           );
    //                                         } else {
    //                                           return Image.network(
    //                                             styleupData.thumbnailUrl,
    //                                             width: double.infinity,
    //                                             height: double.infinity,
    //                                             fit: BoxFit.cover,
    //                                             errorBuilder: (context, error,
    //                                                 StackTrace) {
    //                                               return Container(
    //                                                 color: Colors.white,
    //                                               );
    //                                             },
    //                                           );
    //                                         }
    //                                       })
    //                                   : Container(),
    //                               videoController != null
    //                                   ? StyleupVideoScreen(
    //                                       videoController: videoController!)
    //                                   : const SizedBox()
    //                               // GestureDetector(
    //                               //   onTap: () {
    //                               //     if (videoController?.value.isPlaying ==
    //                               //         true) {
    //                               //       videoController?.pause();
    //                               //     } else {
    //                               //       videoController?.play();
    //                               //     }
    //                               //   },
    //                               // ),
    //                               // Center(
    //                               //   child: videoController?.value.isPlaying == false ? Image.asset(play,
    //                               //   width: 40,
    //                               //   height: 40,) : const SizedBox(),
    //                               // )
    //                             ],
    //                           ),
    //                           onVisibilityChanged: (visibilityInfo) {
    //                             if (visibilityInfo.visibleFraction == 0) {
    //                               videoController?.pause();
    //                             } else {
    //                               videoController?.play();
    //                             }
    //                           }),
    //                     ],
    //                   )
    //                 : SizedBox(
    //                     height: double.infinity,
    //                     child: Stack(
    //                       children: [
    //                         SizedBox(
    //                           height: parentWidth * (6 / 4),
    //                           child: Padding(
    //                             padding: EdgeInsets.only(
    //                                 top: MediaQuery.of(context).padding.top),
    //                             child: Swiper(
    //                               index: horizontalSwiperIndex,
    //                               itemCount: styleupData.imgUrlList.length,
    //                               loop: false,
    //                               controller: swiperControllerHorizontal,
    //                               scrollDirection: Axis.horizontal,
    //                               onIndexChanged: (value) {
    //                                 horizontalSwiperIndex = value;
    //                               },
    //                               pagination: styleupData.imgUrlList.length >
    //                                           1 &&
    //                                       !showTags
    //                                   ? const SwiperPagination(
    //                                       alignment: Alignment.bottomCenter,
    //                                       margin: EdgeInsets.only(bottom: 16),
    //                                       builder: DotSwiperPaginationBuilder(
    //                                           color: Color(0x4Dffffff),
    //                                           activeColor: Colors.white,
    //                                           size: 8,
    //                                           activeSize: 8,
    //                                           space: 4))
    //                                   : null,
    //                               itemBuilder:
    //                                   (BuildContext context3, int index2) {
    //                                 return Container(
    //                                     color: Colors.white,
    //                                     child: Stack(
    //                                       alignment: Alignment.center,
    //                                       children: [
    //                                         Container(
    //                                           child:
    //                                               styleupData.imgUrlList[
    //                                                           index2] !=
    //                                                       ""
    //                                                   ? Container(
    //                                                       alignment: Alignment
    //                                                           .topCenter,
    //                                                       child: Stack(
    //                                                           children: [
    //                                                             Image.network(
    //                                                                 styleupData
    //                                                                         .imgUrlList[
    //                                                                     index2],
    //                                                                 fit: BoxFit
    //                                                                     .cover,
    //                                                                 width: double
    //                                                                     .infinity,
    //                                                                 height: double
    //                                                                     .infinity,
    //                                                                 errorBuilder:
    //                                                                     (context,
    //                                                                         error,
    //                                                                         StackTrace) {
    //                                                               return Container(
    //                                                                 color: Colors
    //                                                                     .white,
    //                                                               );
    //                                                             }),
    //                                                             if (showTags ==
    //                                                                 true)
    //                                                               Container(
    //                                                                 child: showTags
    //                                                                     ? InkWell(
    //                                                                         onTap:
    //                                                                             () {
    //                                                                           setState(() {
    //                                                                             updateShowTag(false);
    //                                                                           });
    //                                                                         },
    //                                                                       )
    //                                                                     : null,
    //                                                               ),
    //                                                             if (showTags ==
    //                                                                 true)
    //                                                               for (int i =
    //                                                                       0;
    //                                                                   i <
    //                                                                       styleupData
    //                                                                           .goodsDataList[index2]
    //                                                                           .length;
    //                                                                   i++)
    //                                                                 Positioned(
    //                                                                   left: styleupData
    //                                                                           .goodsDataList[index2][
    //                                                                               i]
    //                                                                           .left *
    //                                                                       MediaQuery.of(context)
    //                                                                           .size
    //                                                                           .width,
    //                                                                   top: styleupData
    //                                                                           .goodsDataList[index2][
    //                                                                               i]
    //                                                                           .top *
    //                                                                       MediaQuery.of(context)
    //                                                                           .size
    //                                                                           .width *
    //                                                                       (6 /
    //                                                                           4),
    //                                                                   child:
    //                                                                       GestureDetector(
    //                                                                     onTap:
    //                                                                         () {
    //                                                                       // StorePage(
    //                                                                       //       goodsNo: styleupData.goodsDataList[index2][i].goodsNo,
    //                                                                       //     ),
    //                                                                       //   ));
    //                                                                     },
    //                                                                     child:
    //                                                                         tagWidget(
    //                                                                       goodsNm: styleupData
    //                                                                           .goodsDataList[index2][i]
    //                                                                           .brandNm,
    //                                                                       price: styleupData
    //                                                                           .goodsDataList[index2][i]
    //                                                                           .goodsPrice
    //                                                                           .formatPrice(),
    //                                                                       size: styleupData.goodsDataList[index2][i].optionKey != ""
    //                                                                           ? '${styleupData.goodsDataList[index2][i].optionKey} : ${styleupData.goodsDataList[index2][i].optionValue}'
    //                                                                           : "",
    //                                                                     ),
    //                                                                   ),
    //                                                                 )
    //                                                           ]),
    //                                                     )
    //                                                   : null,
    //                                         ),
    //                                         styleupData.imgUrlList.length > 1
    //                                             ? Container(
    //                                                 alignment:
    //                                                     Alignment.topLeft,
    //                                                 width: double.infinity,
    //                                                 height: double.infinity,
    //                                                 child: !showTags
    //                                                     ? SizedBox(
    //                                                         width: 150,
    //                                                         height:
    //                                                             double.infinity,
    //                                                         child: InkWell(
    //                                                             onTap: () {
    //                                                           swiperControllerHorizontal
    //                                                               .previous();
    //                                                         }),
    //                                                       )
    //                                                     : null,
    //                                               )
    //                                             : const SizedBox(
    //                                                 width: 0,
    //                                                 height: 0,
    //                                               ),
    //                                         styleupData.imgUrlList.length > 1
    //                                             ? Container(
    //                                                 alignment:
    //                                                     Alignment.topRight,
    //                                                 width: double.infinity,
    //                                                 height: double.infinity,
    //                                                 child: !showTags
    //                                                     ? SizedBox(
    //                                                         width: 150,
    //                                                         height:
    //                                                             double.infinity,
    //                                                         child: InkWell(
    //                                                             onTap: () {
    //                                                           swiperControllerHorizontal
    //                                                               .next();
    //                                                         }),
    //                                                       )
    //                                                     : null,
    //                                               )
    //                                             : const SizedBox(
    //                                                 width: 0,
    //                                                 height: 0,
    //                                               ),
    //                                       ],
    //                                     ));
    //                               },
    //                             ),
    //                           ),
    //                         ),
    //                       ],
    //                     )),
    //             Container(
    //                 alignment: Alignment.topCenter,
    //                 child: Image.asset(
    //                   'assets/icons/gradient_top.png',
    //                   fit: BoxFit.fill,
    //                   width: double.infinity,
    //                   height: 120,
    //                 )),
    //             Container(
    //                 alignment: Alignment.bottomCenter,
    //                 child: Image.asset(
    //                   'assets/icons/gradient_bottom.png',
    //                   fit: BoxFit.fill,
    //                   width: double.infinity,
    //                   height: 170,
    //                 )),
    //             Container(
    //               alignment: Alignment.topRight,
    //               child: !showTags
    //                   ? ToolBox(
    //                       isVideo: styleupData.type == "video" ? true : false,
    //                       styleupNo: styleupData.styleupNo,
    //                       memNo: user.memNo,
    //                       tapTag: () {
    //                         setState(() {
    //                           updateShowTag(true);
    //                         });
    //                       },
    //                       tapComment: () {
    //                         tapCommentButton(
    //                           context,
    //                           memNo: user.memNo,
    //                           styleupNo: styleupData.styleupNo,
    //                         );
    //                       },
    //                       isBookmark: styleupData.isBookmark,
    //                       tapBookmark: (value) {
    //                         styleupList[index].isBookmark = value;
    //                       },
    //                       tapShare: () {
    //                         Share.share(
    //                             'https://www.instagram.com/outfitbattles_korea/');
    //                       },
    //                       tapSeeMore: () {
    //                         tapSeeMoreButton(
    //                             styleupNo: styleupData.styleupNo,
    //                             contentMemNo: styleupData.memNo,
    //                             memNo: user.memNo,
    //                             index: index);
    //                       },
    //                     )
    //                   : null,
    //             ),
    //             Container(
    //               alignment: Alignment.bottomCenter,
    //               child: !showTags
    //                   ? Padding(
    //                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
    //                       child: Column(
    //                         crossAxisAlignment: CrossAxisAlignment.start,
    //                         children: [
    //                           const Spacer(),
    //                           StyleupScreenProfile(
    //                             styleupModel: styleupData,
    //                           ),
    //                           const SizedBox(height: 16),
    //                           Container(
    //                             child: styleupData.goodsDataList.isNotEmpty
    //                                 ? ProductContainer(
    //                                     itemInfo: styleupData.goodsDataList,
    //                                     styleNo: styleupData.styleupNo,
    //                                     currentImageIdx: 0,
    //                                   )
    //                                 : null,
    //                           ),
    //                           UpDownButtons(
    //                             styleup: styleupList[index],
    //                             onCompleted: (value) {
    //                               styleupList[index].upDownType = value;
    //                               videoController?.pause();
    //                               swiperController.next(animation: true);
    //                             },
    //                           ),
    //                         ],
    //                       ),
    //                     )
    //                   : null,
    //             ),
    //             GestureDetector(onHorizontalDragUpdate: (details) {
    //               // Note: Sensitivity is integer used when you don't want to mess up vertical drag
    //               int sensitivity = 8;
    //               if (details.delta.dx > sensitivity) {
    //                 // Right Swipe
    //                 debugPrint("Detect Right Swipe");
    //                 setState(() {
    //                   styleupList[index].upDownType = 1;
    //                   videoController?.pause();
    //                   swiperController.next(animation: true);
    //                 });
    //               } else if (details.delta.dx < -sensitivity) {
    //                 //Left Swipe
    //                 debugPrint("Detect Left Swipe");
    //                 setState(() {
    //                   styleupList[index].upDownType = 2;
    //                   videoController?.pause();
    //                   swiperController.next(animation: true);
    //                 });
    //               }
    //             }),
    //             if (showTags == true)
    //               Padding(
    //                   padding: EdgeInsets.only(top: parentWidth * (6 / 4)),
    //                   child: Stack(
    //                     children: [
    //                       if (showTags == true)
    //                         GestureDetector(
    //                           onTap: () {
    //                             setState(() {
    //                               updateShowTag(false);
    //                             });
    //                           },
    //                           child: Container(
    //                             width: double.infinity,
    //                             height: double.infinity,
    //                             color: Colors.transparent,
    //                           ),
    //                         )
    //                     ],
    //                   ))
    //           ],
    //         );
    //       },
    //     ),
    //     SafeArea(
    //       child: Container(
    //         alignment: Alignment.topLeft,
    //         child: Navigator.canPop(context)
    //             ? CupertinoButton(
    //                 padding: EdgeInsets.zero,
    //                 child: Image.asset(
    //                   'assets/icons/back_button_white.png',
    //                   width: 20.0,
    //                   height: 56.0,
    //                 ),
    //                 onPressed: () => Navigator.pop(context),
    //               )
    //             : null,
    //       ),
    //     ),
    //     SafeArea(
    //       child: Column(
    //         children: [
    //           Padding(
    //             padding: const EdgeInsets.all(16.0),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.center,
    //               children: [
    //                 Expanded(
    //                   child: Row(
    //                     children: [
    //                       const SizedBox(),
    //                       const Spacer(),
    //                       !showTags
    //                           ? CupertinoButton(
    //                               minSize: 0,
    //                               padding:
    //                                   const EdgeInsets.symmetric(horizontal: 0),
    //                               child: Image.asset(
    //                                 'assets/icons/direct_message.png',
    //                                 width: 28,
    //                                 height: 28,
    //                               ),
    //                               onPressed: () {
    //                                 UserProvider userProvider =
    //                                     Provider.of<UserProvider>(context,
    //                                         listen: false);
    //                                 final user = userProvider.user;

    //                                 debugPrint(user.memNo);
    //                                 if (user.memNo == "") {
    //                                   showModalBottomSheet(
    //                                       context: context,
    //                                       isScrollControlled: true,
    //                                       shape: const RoundedRectangleBorder(
    //                                         borderRadius: BorderRadius.only(
    //                                           topLeft: Radius.circular(12.0),
    //                                           topRight: Radius.circular(12.0),
    //                                         ),
    //                                       ),
    //                                       builder: (BuildContext context) {
    //                                         return const LoginPopupScreen();
    //                                       });
    //                                   return;
    //                                 }
    //                                 // Navigator.push(
    //                                 //     context,
    //                                 //     PageRouteBuilderRightLeft(
    //                                 //       child: const AllChatListScreen(),
    //                                 //     ));
    //                               },
    //                             )
    //                           : const SizedBox(),
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //           const Spacer(),
    //         ],
    //       ),
    //     )
    //   ],
    // ));
  }
}

class StyleupVideoScreen extends StatefulWidget {
  const StyleupVideoScreen({
    super.key,
    required this.videoController,
  });

  final VideoPlayerController videoController;

  @override
  State<StyleupVideoScreen> createState() => _StyleupVideoScreen();
}

class _StyleupVideoScreen extends State<StyleupVideoScreen> {
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            if (widget.videoController.value.isPlaying == true) {
              widget.videoController.pause();
              setState(() {
                isPlaying = false;
              });
            } else {
              widget.videoController.play();
              setState(() {
                isPlaying = true;
              });
            }
          },
        ),
        Center(
          child: isPlaying == false
              ? GestureDetector(
                  onTap: () {
                    if (widget.videoController.value.isPlaying == true) {
                      widget.videoController.pause();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      widget.videoController.play();
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                  child: Image.asset(
                    play,
                    width: 40,
                    height: 40,
                  ),
                )
              : const SizedBox(),
        )
      ],
    );
  }
}
