import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/back_blur/back_blur.dart';
import 'package:showny/models/styleup_battle_item_model.dart';
import 'package:showny/providers/battle_item_provider.dart';
import 'package:showny/screens/tabs/home/components/battle_user.dart';
import 'package:showny/screens/tabs/home/components/product_container_battle.dart';

class BattleItem extends StatefulWidget {
  final StyleupBattleItemModel battleItem;
  final int index;
  const BattleItem({
    super.key,
    required this.battleItem,
    required this.index,
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
    print('isPoll : ${widget.battleItem.isPoll}');
    print('1 cnt : ${widget.battleItem.style1PollCnt}');
    print('2 cnt : ${widget.battleItem.style2PollCnt}');
    final Size size = MediaQuery.of(context).size;
    defaultImgWidth = size.width * .41;
    return ChangeNotifierProvider<BattleItemProvider>(
        create: (_) => BattleItemProvider(this),
        builder: (context, _) {
          return Consumer<BattleItemProvider>(
            builder: (ctx, prov, child) {
              return GestureDetector(
                onPanUpdate: prov.onPanUpdate,
                onTapUp: (details) {
                  if (widget.battleItem.isPoll) return;
                  if (details.localPosition.dx < size.width / 2) {
                    prov.startLeftAnimation();
                  } else {
                    prov.startRightAnimation();
                  }
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    BackBlurWidget(
                      width: size.width,
                      height: double.infinity,
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
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _buildBattleListBtn(),
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

  Widget _buildBattleListBtn() {
    return Row(
      children: [
        const Spacer(),
        CupertinoButton(
          onPressed: () {},
          child: const Row(
            children: [
              Text(
                '배틀리스트',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 10,
              ),
            ],
          ),
        ),
        const SizedBox(width: 10),
      ],
    );
  }

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
    return Align(
      alignment: Alignment.bottomCenter,
      child: GestureDetector(
        onTap: () {},
        child: Container(
          margin: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          padding: const EdgeInsets.all(4),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(.4),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(2),
                child: Image.asset(
                  'assets/images/1.jpg',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CIDER',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Text(
                    '솔리드 컷아웃 하이웨스트 와이드 레그 팬츠',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              CupertinoButton(
                onPressed: () {},
                child: const Text(
                  '더보기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
