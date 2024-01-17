import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/models/styleup_battle_item_model.dart';
import 'package:showny/models/user_model.dart';
import 'package:showny/screens/common/scroll_physics/custom_scroll_physics.dart';
import 'package:provider/provider.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/home/widgets/battle_item.dart';
import 'package:showny/screens/profile/other_profile_screen.dart';

class BattleScreen extends StatefulWidget {
  const BattleScreen(
      {super.key,
      required this.battleList,
      required this.onPageChanged,
      required this.title,
      required this.battleRound,
      required this.isMain});

  final bool isMain;
  final String title;
  final List<StyleupBattleItemModel> battleList;
  final Function(int) onPageChanged;
  final String battleRound;

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  SwiperController swiperController = SwiperController();
  bool pollLock = false;

  @override
  void initState() {
    super.initState();
  }

  Widget profile({required UserModel profile, required String label}) {
    return Row(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: ShapeDecoration(
            image: DecorationImage(
              image: NetworkImage(profile.profileImage),
              fit: BoxFit.cover,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(200),
            ),
          ),
          child: GestureDetector(onTap: () {
            if (Provider.of<UserProvider>(context, listen: false).user.memNo ==
                profile.memNo) {
              //
            } else {
              Navigator.push(
                  context,
                  ShownyPageRoute(
                      builder: (context) => OtherProfileScreen(
                            memNo: profile.memNo,
                          ),
                      settings:
                          const RouteSettings(name: PageName.OTHER_PROFILE)));
            }
          }),
        ),
        const SizedBox(width: 6.0),
        GestureDetector(
          child: Text(
            label,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          onTap: () {
            if (Provider.of<UserProvider>(context, listen: false).user.memNo ==
                profile.memNo) {
              //
            } else {
              Navigator.push(
                  context,
                  ShownyPageRoute(
                      builder: (context) => OtherProfileScreen(
                            memNo: profile.memNo,
                          ),
                      settings:
                          const RouteSettings(name: PageName.OTHER_PROFILE)));
            }
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      physics: const CustomScrollPhysics(),
      scrollDirection: Axis.vertical,
      children: List.generate(widget.battleList.length, (index) {
        return BattleItem(
          battleItem: widget.battleList[index],
          index: index,
          battleRound: widget.battleRound,
          title: widget.title,
        );
      }),
    );

    // return Container(
    //     color: Colors.amber,
    //     child: widget.battleList.isEmpty
    //         ? Stack(
    //             children: [
    //               SizedBox(
    //                 width: double.infinity,
    //                 height: double.infinity,
    //                 child: Image.asset(
    //                   "assets/icons/battle_gradient.png",
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //               Container(
    //                   width: double.infinity,
    //                   height: double.infinity,
    //                   alignment: Alignment.center,
    //                   child: Column(
    //                     mainAxisSize: MainAxisSize.min,
    //                     children: [
    //                       Image.asset(
    //                         "assets/icons/unsmile.png",
    //                         width: 64,
    //                         height: 64,
    //                       ),
    //                       const SizedBox(height: 20.0),
    //                       const Text(
    //                         "참여 가능한 배틀이 없습니다.",
    //                         style: TextStyle(
    //                           fontSize: 12.0,
    //                           color: Color(0xff777777),
    //                         ),
    //                       ),
    //                       const SizedBox(height: 20.0),
    //                       ElevatedButton(
    //                         onPressed: () {
    //                           // Navigator.pushNamed(
    //                           //     context, BattleListScreen.routeName);
    //                         },
    //                         style: ElevatedButton.styleFrom(
    //                           backgroundColor: Colors.black,
    //                           padding: const EdgeInsets.symmetric(
    //                             horizontal: 40.0,
    //                             vertical: 12.0,
    //                           ),
    //                           textStyle: const TextStyle(
    //                               fontSize: 12.0, color: Colors.white),
    //                         ),
    //                         child: const Text("배틀리스트 보기"),
    //                       ),
    //                     ],
    //                   ))
    //             ],
    //           )
    //         : Swiper(
    //             loop: false,
    //             scrollDirection: Axis.vertical,
    //             itemCount: widget.battleList.length,
    //             controller: swiperController,
    //             onIndexChanged: (value) {
    //               widget.onPageChanged(value);
    //             },
    //             itemBuilder: (context, index) {
    //               final item = widget.battleList[index];
    //               debugPrint("widget.battleList.length");
    //               debugPrint(widget.battleList.length.toString());

    //               return Stack(
    //                 children: [
    //                   SizedBox(
    //                     width: double.infinity,
    //                     height: double.infinity,
    //                     child: Image.asset(
    //                       "assets/icons/battle_gradient.png",
    //                       fit: BoxFit.cover,
    //                     ),
    //                   ),
    //                   SafeArea(
    //                     child: Row(
    //                       children: [
    //                         widget.isMain == false
    //                             ? GestureDetector(
    //                                 onTap: () {
    //                                   Navigator.of(context).pop();
    //                                 },
    //                                 child: Padding(
    //                                   padding: const EdgeInsets.all(16),
    //                                   child: Image.asset(
    //                                     arrowBackward,
    //                                     height: 20,
    //                                     width: 20,
    //                                     color: Colors.white,
    //                                   ),
    //                                 ),
    //                               )
    //                             : const SizedBox(),
    //                         const Spacer(),
    //                         CupertinoButton(
    //                           minSize: 0,
    //                           padding: const EdgeInsets.all(16),
    //                           child: Image.asset(
    //                             'assets/icons/share.png',
    //                             width: 24,
    //                             height: 24,
    //                           ),
    //                           onPressed: () {
    //                             Share.share(
    //                                 'https://www.instagram.com/outfitbattles_korea/');
    //                           },
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   SafeArea(
    //                     child: Padding(
    //                       padding: const EdgeInsets.only(top: 64),
    //                       child: Column(
    //                         children: [
    //                           Center(
    //                             child: Text(
    //                               "$title 배틀 ${widget.battleRound}강전",
    //                               style: const TextStyle(
    //                                 color: Colors.white,
    //                                 fontSize: 12,
    //                                 fontWeight: FontWeight.w700,
    //                               ),
    //                             ),
    //                           ),
    //                           Padding(
    //                             padding: const EdgeInsets.all(8.0),
    //                             child: Row(
    //                               mainAxisAlignment: MainAxisAlignment.end,
    //                               children: [
    //                                 CupertinoButton(
    //                                   onPressed: () {
    //                                     // Navigator.pushNamed(
    //                                     //   context, BattleListScreen.routeName);
    //                                   },
    //                                   minSize: 0,
    //                                   padding: EdgeInsets.zero,
    //                                   child: Row(
    //                                     children: [
    //                                       const Text(
    //                                         '배틀 리스트',
    //                                         style: TextStyle(
    //                                           color: Colors.white,
    //                                           fontSize: 12,
    //                                           fontWeight: FontWeight.w400,
    //                                         ),
    //                                       ),
    //                                       const SizedBox(width: 4),
    //                                       Image.asset(
    //                                         "assets/icons/arrow_forward_white.png",
    //                                         width: 8,
    //                                         height: 8,
    //                                         color: Colors.white,
    //                                       ),
    //                                     ],
    //                                   ),
    //                                 )
    //                               ],
    //                             ),
    //                           ),
    //                           Row(
    //                             children: [
    //                               Container(
    //                                 color: Colors.grey.withOpacity(0.5),
    //                                 width: MediaQuery.sizeOf(context).width / 2,
    //                                 height: MediaQuery.sizeOf(context).width,
    //                                 child: Stack(
    //                                   children: [
    //                                     Container(
    //                                       color: Colors.grey.withOpacity(0.5),
    //                                       width:
    //                                           MediaQuery.sizeOf(context).width,
    //                                       height:
    //                                           MediaQuery.sizeOf(context).width *
    //                                               1.05,
    //                                       child: ClipRect(
    //                                         child: Image.network(
    //                                           item.styleup1.imgUrlList
    //                                                   .firstOrNull ??
    //                                               'https://via.placeholder.com/195x377',
    //                                           alignment: Alignment.topCenter,
    //                                           fit: BoxFit.cover,
    //                                         ),
    //                                       ),
    //                                     ),
    //                                     Container(
    //                                       color: Colors.black.withOpacity(widget
    //                                                   .battleList[index]
    //                                                   .pollTag ==
    //                                               2
    //                                           ? 0.6
    //                                           : 0),
    //                                       child: GestureDetector(
    //                                         onTap: () {
    //                                           ApiHelper.shared
    //                                               .getProfileStyleupList(
    //                                                   widget
    //                                                       .battleList[index]
    //                                                       .styleup1
    //                                                       .userInfo
    //                                                       .memNo,
    //                                                   2,
    //                                                   0, (styleupList) {
    //                                             String styleupNo = widget
    //                                                 .battleList[index]
    //                                                 .styleup1
    //                                                 .styleupNo;
    //                                             StyleupModel findStyleup =
    //                                                 styleupList.firstWhere(
    //                                                     (styleup) =>
    //                                                         styleup.styleupNo ==
    //                                                         styleupNo,
    //                                                     orElse: () =>
    //                                                         StyleupModel());
    //                                             if (findStyleup.styleupNo ==
    //                                                 "") {
    //                                               return;
    //                                             }
    //                                             styleupList.remove(findStyleup);
    //                                             styleupList.insert(
    //                                                 0, findStyleup);
    //                                             Navigator.push(
    //                                                 context,
    //                                                 PageRouteBuilderRightLeft(
    //                                                     child: StyleupScreen(
    //                                                   isMain: false,
    //                                                   initIndex: 0,
    //                                                   styleupList: styleupList,
    //                                                 )));
    //                                           }, (error) {});
    //                                         },
    //                                       ),
    //                                     )
    //                                   ],
    //                                 ),
    //                               ),
    //                               Container(
    //                                 color: Colors.grey.withOpacity(0.5),
    //                                 width: MediaQuery.sizeOf(context).width / 2,
    //                                 height: MediaQuery.sizeOf(context).width,
    //                                 child: Stack(
    //                                   children: [
    //                                     Container(
    //                                       color: Colors.grey.withOpacity(0.5),
    //                                       width:
    //                                           MediaQuery.sizeOf(context).width,
    //                                       height:
    //                                           MediaQuery.sizeOf(context).width *
    //                                               1.05,
    //                                       child: ClipRect(
    //                                         child: Image.network(
    //                                           item.styleup2.imgUrlList
    //                                                   .firstOrNull ??
    //                                               'https://via.placeholder.com/195x377',
    //                                           alignment: Alignment.topCenter,
    //                                           fit: BoxFit.cover,
    //                                         ),
    //                                       ),
    //                                     ),
    //                                     Container(
    //                                       color: Colors.black.withOpacity(widget
    //                                                   .battleList[index]
    //                                                   .pollTag ==
    //                                               1
    //                                           ? 0.6
    //                                           : 0),
    //                                       child: GestureDetector(
    //                                         onTap: () {
    //                                           ApiHelper.shared
    //                                               .getProfileStyleupList(
    //                                                   widget
    //                                                       .battleList[index]
    //                                                       .styleup2
    //                                                       .userInfo
    //                                                       .memNo,
    //                                                   2,
    //                                                   0, (styleupList) {
    //                                             String styleupNo = widget
    //                                                 .battleList[index]
    //                                                 .styleup2
    //                                                 .styleupNo;
    //                                             StyleupModel findStyleup =
    //                                                 styleupList.firstWhere(
    //                                                     (styleup) =>
    //                                                         styleup.styleupNo ==
    //                                                         styleupNo,
    //                                                     orElse: () =>
    //                                                         StyleupModel());
    //                                             if (findStyleup.styleupNo ==
    //                                                 "") {
    //                                               return;
    //                                             }
    //                                             styleupList.remove(findStyleup);
    //                                             styleupList.insert(
    //                                                 0, findStyleup);
    //                                             Navigator.push(
    //                                                 context,
    //                                                 PageRouteBuilderRightLeft(
    //                                                     child: StyleupScreen(
    //                                                   isMain: false,
    //                                                   initIndex: 0,
    //                                                   styleupList: styleupList,
    //                                                 )));
    //                                           }, (error) {});
    //                                         },
    //                                       ),
    //                                     )
    //                                   ],
    //                                 ),
    //                               ),
    //                             ],
    //                           ),
    //                           const SizedBox(height: 12.0),
    //                           Row(
    //                             mainAxisAlignment:
    //                                 MainAxisAlignment.spaceAround,
    //                             children: [
    //                               profile(
    //                                   profile: item.styleup1.userInfo,
    //                                   label: item.styleup1.userInfo.nickNm),
    //                               profile(
    //                                   profile: item.styleup2.userInfo,
    //                                   label: item.styleup2.userInfo.nickNm),
    //                             ],
    //                           ),
    //                           const SizedBox(height: 8.0),
    //                           Column(
    //                             children: [
    //                               selectionButton(
    //                                   isLeft: true,
    //                                   percent: (widget.battleList[index]
    //                                                   .style1PollCnt +
    //                                               widget.battleList[index]
    //                                                   .style2PollCnt) ==
    //                                           0
    //                                       ? 0
    //                                       : (widget.battleList[index]
    //                                               .style1PollCnt /
    //                                           (widget.battleList[index]
    //                                                   .style1PollCnt +
    //                                               widget.battleList[index]
    //                                                   .style2PollCnt)),
    //                                   isVoted: widget.battleList[index].isPoll,
    //                                   isSelected:
    //                                       widget.battleList[index].pollTag == 1,
    //                                   onPressed: () {
    //                                     UserProvider userProvider =
    //                                         Provider.of<UserProvider>(context,
    //                                             listen: false);
    //                                     final user = userProvider.user;

    //                                     debugPrint(user.memNo);
    //                                     if (user.memNo == "") {
    //                                       showModalBottomSheet(
    //                                           context: context,
    //                                           isScrollControlled: true,
    //                                           shape:
    //                                               const RoundedRectangleBorder(
    //                                             borderRadius: BorderRadius.only(
    //                                               topLeft:
    //                                                   Radius.circular(12.0),
    //                                               topRight:
    //                                                   Radius.circular(12.0),
    //                                             ),
    //                                           ),
    //                                           builder: (BuildContext context) {
    //                                             return const LoginPopupScreen();
    //                                           });
    //                                       return;
    //                                     }
    //                                     int selectedIndex = index;
    //                                     setState(() {
    //                                       if (pollLock == true) {
    //                                         return;
    //                                       }
    //                                       pollLock = true;

    //                                       ApiHelper.shared
    //                                           .selectStyleupBattleItem(
    //                                               widget
    //                                                   .battleList[selectedIndex]
    //                                                   .battleRoundNo,
    //                                               item.styleup1.styleupNo,
    //                                               item.styleup2.styleupNo,
    //                                               user.memNo,
    //                                               (battleVoteResponseModel) {
    //                                         setState(() {
    //                                           pollLock = false;
    //                                           widget.battleList[selectedIndex]
    //                                               .pollTag = 1;
    //                                           widget.battleList[selectedIndex]
    //                                               .isPoll = true;
    //                                           widget.battleList[selectedIndex]
    //                                                   .style1PollCnt =
    //                                               battleVoteResponseModel
    //                                                   .style1PollCnt;
    //                                           widget.battleList[selectedIndex]
    //                                                   .style2PollCnt =
    //                                               battleVoteResponseModel
    //                                                   .style2PollCnt;
    //                                         });
    //                                       }, (error) {
    //                                         setState(() {
    //                                           pollLock = false;
    //                                         });
    //                                       });
    //                                     });
    //                                     // swiperController.next();
    //                                   }),
    //                               const SizedBox(height: 8.0),
    //                               selectionButton(
    //                                   isLeft: false,
    //                                   percent: (widget.battleList[index]
    //                                                   .style1PollCnt +
    //                                               widget.battleList[index]
    //                                                   .style2PollCnt) ==
    //                                           0
    //                                       ? 0
    //                                       : (widget.battleList[index]
    //                                               .style2PollCnt /
    //                                           (widget.battleList[index]
    //                                                   .style1PollCnt +
    //                                               widget.battleList[index]
    //                                                   .style2PollCnt)),
    //                                   isVoted: widget.battleList[index].isPoll,
    //                                   isSelected:
    //                                       widget.battleList[index].pollTag == 2,
    //                                   onPressed: () {
    //                                     UserProvider userProvider =
    //                                         Provider.of<UserProvider>(context,
    //                                             listen: false);
    //                                     final user = userProvider.user;

    //                                     debugPrint(user.memNo);
    //                                     if (user.memNo == "") {
    //                                       showModalBottomSheet(
    //                                           context: context,
    //                                           isScrollControlled: true,
    //                                           shape:
    //                                               const RoundedRectangleBorder(
    //                                             borderRadius: BorderRadius.only(
    //                                               topLeft:
    //                                                   Radius.circular(12.0),
    //                                               topRight:
    //                                                   Radius.circular(12.0),
    //                                             ),
    //                                           ),
    //                                           builder: (BuildContext context) {
    //                                             return const LoginPopupScreen();
    //                                           });
    //                                       return;
    //                                     }
    //                                     int selectedIndex = index;
    //                                     setState(() {
    //                                       if (pollLock == true) {
    //                                         return;
    //                                       }
    //                                       pollLock = true;

    //                                       ApiHelper.shared
    //                                           .selectStyleupBattleItem(
    //                                               widget
    //                                                   .battleList[selectedIndex]
    //                                                   .battleRoundNo,
    //                                               item.styleup2.styleupNo,
    //                                               item.styleup1.styleupNo,
    //                                               user.memNo,
    //                                               (battleVoteResponseModel) {
    //                                         setState(() {
    //                                           pollLock = false;
    //                                           widget.battleList[selectedIndex]
    //                                               .pollTag = 2;
    //                                           widget.battleList[selectedIndex]
    //                                               .isPoll = true;
    //                                           widget.battleList[selectedIndex]
    //                                                   .style1PollCnt =
    //                                               battleVoteResponseModel
    //                                                   .style1PollCnt;
    //                                           widget.battleList[selectedIndex]
    //                                                   .style2PollCnt =
    //                                               battleVoteResponseModel
    //                                                   .style2PollCnt;
    //                                         });
    //                                       }, (error) {
    //                                         setState(() {
    //                                           pollLock = false;
    //                                         });
    //                                       });
    //                                     });

    //                                     // swiperController.next();
    //                                   }),
    //                               const SizedBox(height: 16.0),
    //                               Container(
    //                                 child: widget.battleList[index].styleup1
    //                                         .goodsDataList.isNotEmpty
    //                                     ? Padding(
    //                                         padding: const EdgeInsets.only(
    //                                             left: 16, right: 16),
    //                                         child: ProductContainerBattle(
    //                                           itemInfo1: widget
    //                                               .battleList[index]
    //                                               .styleup1
    //                                               .goodsDataList,
    //                                           itemInfo2: widget
    //                                               .battleList[index]
    //                                               .styleup2
    //                                               .goodsDataList,
    //                                           name1: widget.battleList[index]
    //                                               .styleup1.userInfo.nickNm,
    //                                           name2: widget.battleList[index]
    //                                               .styleup2.userInfo.nickNm,
    //                                           currentImageIdx: 0,
    //                                         ),
    //                                       )
    //                                     : null,
    //                               ),
    //                               const Padding(
    //                                 padding:
    //                                     EdgeInsets.symmetric(horizontal: 16.0),
    //                                 // child: ProductContainer(itemInfo: null, styleNo: '',currentImageIdx: 0,),
    //                               ),
    //                             ],
    //                           ),
    //                         ],
    //                       ),
    //                     ),
    //                   ),
    //                   GestureDetector(onHorizontalDragUpdate: (details) {
    //                     // Note: Sensitivity is integer used when you don't want to mess up vertical drag
    //                     int sensitivity = 8;
    //                     if (details.delta.dx > sensitivity) {
    //                       // Right Swipe
    //                       debugPrint("Detect Right Swipe");
    //                       UserProvider userProvider =
    //                           Provider.of<UserProvider>(context, listen: false);
    //                       final user = userProvider.user;

    //                       debugPrint(user.memNo);
    //                       if (user.memNo == "") {
    //                         showModalBottomSheet(
    //                             context: context,
    //                             isScrollControlled: true,
    //                             shape: const RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.only(
    //                                 topLeft: Radius.circular(12.0),
    //                                 topRight: Radius.circular(12.0),
    //                               ),
    //                             ),
    //                             builder: (BuildContext context) {
    //                               return const LoginPopupScreen();
    //                             });
    //                         return;
    //                       }

    //                       setState(() {
    //                         if (pollLock == true) {
    //                           return;
    //                         }
    //                         pollLock = true;

    //                         ApiHelper.shared.selectStyleupBattleItem(
    //                             widget.battleList[index].battleRoundNo,
    //                             item.styleup2.styleupNo,
    //                             item.styleup1.styleupNo,
    //                             user.memNo, (battleVoteResponseModel) {
    //                           setState(() {
    //                             pollLock = false;
    //                             widget.battleList[index].pollTag = 2;
    //                             widget.battleList[index].isPoll = true;
    //                             widget.battleList[index].style1PollCnt =
    //                                 battleVoteResponseModel.style1PollCnt;
    //                             widget.battleList[index].style2PollCnt =
    //                                 battleVoteResponseModel.style2PollCnt;
    //                           });
    //                         }, (error) {
    //                           setState(() {
    //                             pollLock = false;
    //                           });
    //                         });
    //                       });

    //                       // swiperController.next();
    //                     } else if (details.delta.dx < -sensitivity) {
    //                       //Left Swipe
    //                       debugPrint("Detect Left Swipe");
    //                       UserProvider userProvider =
    //                           Provider.of<UserProvider>(context, listen: false);
    //                       final user = userProvider.user;

    //                       debugPrint(user.memNo);
    //                       if (user.memNo == "") {
    //                         showModalBottomSheet(
    //                             context: context,
    //                             isScrollControlled: true,
    //                             shape: const RoundedRectangleBorder(
    //                               borderRadius: BorderRadius.only(
    //                                 topLeft: Radius.circular(12.0),
    //                                 topRight: Radius.circular(12.0),
    //                               ),
    //                             ),
    //                             builder: (BuildContext context) {
    //                               return const LoginPopupScreen();
    //                             });
    //                         return;
    //                       }

    //                       setState(() {
    //                         if (pollLock == true) {
    //                           return;
    //                         }
    //                         pollLock = true;

    //                         ApiHelper.shared.selectStyleupBattleItem(
    //                             widget.battleList[index].battleRoundNo,
    //                             item.styleup1.styleupNo,
    //                             item.styleup2.styleupNo,
    //                             user.memNo, (battleVoteResponseModel) {
    //                           setState(() {
    //                             pollLock = false;
    //                             widget.battleList[index].pollTag = 1;
    //                             widget.battleList[index].isPoll = true;
    //                             widget.battleList[index].style1PollCnt =
    //                                 battleVoteResponseModel.style1PollCnt;
    //                             widget.battleList[index].style2PollCnt =
    //                                 battleVoteResponseModel.style2PollCnt;
    //                           });
    //                         }, (error) {
    //                           setState(() {
    //                             pollLock = false;
    //                           });
    //                         });
    //                       });

    //                       // swiperController.next();
    //                     }
    //                   })
    //                 ],
    //               );
    //             },
    //           ));
  }

  //   Widget selectionButton({
  //   required bool isLeft,
  //   required bool isVoted,
  //   required bool isSelected,
  //   required double percent,
  //   required Function() onPressed,
  // }) {
  //   debugPrint(isLeft.toString());
  //   debugPrint(isVoted.toString());
  //   debugPrint(isSelected.toString());

  //   return CupertinoButton(
  //     onPressed: onPressed,
  //     padding: EdgeInsets.zero,
  //     minSize: 0,
  //     child: ClipRRect(
  //         borderRadius: BorderRadius.circular(12.0),
  //         child: SizedBox(
  //           width: 160.0,
  //           height: 40.0,
  //           child: Stack(
  //             alignment: Alignment.centerLeft,
  //             children: [
  //               WidgetMask(
  //                 mask: Container(
  //                   padding: const EdgeInsets.symmetric(horizontal: 12),
  //                   child: Row(
  //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                     children: [
  //                       Text(
  //                         isLeft ? '👈🏻 LEFT' : '👉🏻 RIGHT',
  //                         style: Constants.defaultTextStyle.copyWith(
  //                           color: Colors.white,
  //                           fontSize: 12.0,
  //                           fontWeight: FontWeight.w700,
  //                         ),
  //                       ),
  //                       if (isVoted)
  //                         Text(
  //                           '${(percent * 100).toInt()}%',
  //                           textAlign: TextAlign.right,
  //                           style: Constants.defaultTextStyle.copyWith(
  //                             color: Colors.white,
  //                             fontSize: 12.0,
  //                             fontWeight: FontWeight.w700,
  //                           ),
  //                         )
  //                     ],
  //                   ),
  //                 ),
  //                 // ignore: sort_child_properties_last
  //                 child: Row(
  //                   children: [
  //                     AnimatedContainer(
  //                       width: isVoted == true ? 160 * percent : 0,
  //                       height: 40,
  //                       color: Colors.black,
  //                       duration: const Duration(milliseconds: 250),
  //                     ),
  //                     AnimatedContainer(
  //                       width: isVoted == true ? 160 * (1 - percent) : 160,
  //                       height: 40,
  //                       color: Colors.black.withOpacity(0.08),
  //                       duration: const Duration(milliseconds: 250),
  //                     )
  //                   ],
  //                 ),
  //                 blendMode: BlendMode.difference,
  //               ),
  //               Container(
  //                 padding: const EdgeInsets.symmetric(horizontal: 12),
  //                 child: Text(
  //                   isLeft ? '👈🏻' : '👉🏻',
  //                   style: Constants.defaultTextStyle.copyWith(
  //                     color: Colors.white,
  //                     fontSize: 12.0,
  //                     fontWeight: FontWeight.w700,
  //                   ),
  //                 ),
  //               )
  //             ],
  //           ),
  //         )),
  //   );
  // }
}
