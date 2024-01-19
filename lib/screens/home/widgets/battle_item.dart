import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/back_blur/back_blur.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/models/styleup_battle_item_model.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/screens/battle_list/battle_list.dart';
import 'package:showny/screens/home/providers/battle_item_provider.dart';
import 'package:showny/screens/home/widgets/battle_user.dart';
import 'package:showny/screens/home/widgets/product_container_battle.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class BattleItem extends StatefulWidget {
  final StyleupBattleItemModel battleItem;
  final String title;
  final String battleRound;
  final int index;
  const BattleItem({
    super.key,
    required this.battleItem,
    required this.index,
    required this.title,
    required this.battleRound,
  });

  @override
  State<BattleItem> createState() => _BattleItemState();
}

class _BattleItemState extends State<BattleItem> with TickerProviderStateMixin {
  double defaultImgWidth = 160;
  double imgRatio = 9 / 16;
  Duration aniDuration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    defaultImgWidth = ScreenUtil().screenWidth * .41;
    return ChangeNotifierProvider<BattleItemProvider>(
        create: (_) => BattleItemProvider(this),
        builder: (context, _) {
          return Consumer<BattleItemProvider>(
            builder: (ctx, prov, child) {
              return GestureDetector(
                onPanUpdate: prov.onPanUpdate,
                onTapUp: (details) {
                  if (widget.battleItem.isPoll) return;
                  if (details.localPosition.dx < ScreenUtil().screenWidth / 2) {
                    prov.startLeftAnimation();
                  } else {
                    prov.startRightAnimation();
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    BackBlurWidget(
                      image1: widget.battleItem.styleup1.thumbnailUrl,
                      image2: widget.battleItem.styleup2.thumbnailUrl,
                    ),
                    BattleUser.left(
                      defaultImgWidth: defaultImgWidth,
                      item: widget.battleItem,
                    ),
                    BattleUser.right(
                      defaultImgWidth: defaultImgWidth,
                      item: widget.battleItem,
                    ),
                    if (prov.focused == 0) ...{
                      BattleUser.left(
                        defaultImgWidth: defaultImgWidth,
                        item: widget.battleItem,
                      ),
                    },
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SafeArea(
                          child: Padding(
                            padding: EdgeInsets.only(top: 45.toHeight),
                            child: Column(
                              children: [
                                Text(
                                  "${widget.title} ${widget.battleRound}강전",
                                  style: ShownyStyle.body2(
                                      color: Colors.white,
                                      weight: FontWeight.w700),
                                ),
                                SizedBox(height: 4.toHeight),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CupertinoButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            ShownyPageRoute(
                                              builder: (context) =>
                                                  BattleList(),
                                              settings: RouteSettings(
                                                  name: PageName.BATTLE_LIST),
                                            ));
                                      },
                                      minSize: 0,
                                      padding: EdgeInsets.zero,
                                      child: Row(
                                        children: [
                                          Text(
                                            '배틀 리스트',
                                            style: ShownyStyle.overline(
                                                color: Colors.white,
                                                weight: FontWeight.w600),
                                          ),
                                          Image.asset(
                                            'assets/icons/home/right_arrow.png',
                                            width: 15.toWidth,
                                            height: 15.toWidth,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        _buildBottomBanner(),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        });
  }

  // Widget _buildBattleListBtn() {
  //   return Row(
  //     children: [
  //       const Spacer(),
  //       CupertinoButton(
  //         onPressed: () {},
  //         child: const Row(
  //           children: [
  //             Text(
  //               '배틀리스트',
  //               style: TextStyle(
  //                 color: Colors.white,
  //                 fontSize: 10,
  //                 fontWeight: FontWeight.w400,
  //               ),
  //             ),
  //             Icon(
  //               Icons.arrow_forward_ios,
  //               color: Colors.white,
  //               size: 10,
  //             ),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(width: 10),
  //     ],
  //   );
  // }

  Widget _buildBottomBanner() {
    return Container(
      child: widget.battleItem.styleup1.goodsDataList.isNotEmpty
          ? Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 34),
              child: ProductContainerBattle(
                itemInfo1: widget.battleItem.styleup1.goodsDataList,
                itemInfo2: widget.battleItem.styleup2.goodsDataList,
                name1: widget.battleItem.styleup1.userInfo.nickNm,
                name2: widget.battleItem.styleup2.userInfo.nickNm,
                currentImageIdx: 0,
              ),
            )
          : null,
    );
  }
}
