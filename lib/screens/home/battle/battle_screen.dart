import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

import '../../../components/page_route.dart';
import '../../../models/styleup_battle_item_model.dart';
import '../../../models/styleup_battle_model.dart';
import '../../battle_list/battle_list.dart';
import '../../common/scroll_physics/custom_scroll_physics.dart';
import 'providers/battle_screen_provider.dart';
import 'widgets/battle_item.dart';

class BattleScreen extends StatefulWidget {
  final bool isMain;
  final String battleNo;

  const BattleScreen.home({
    Key? key,
    this.isMain = true,
  })  : battleNo = '',
        super(key: key);

  const BattleScreen({
    super.key,
    this.isMain = true,
    required this.battleNo,
  });

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  // SwiperController swiperController = SwiperController();
  // bool pollLock = false;

  late BattleScreenProvider provider;

  @override
  void initState() {
    super.initState();
    provider = BattleScreenProvider(this);
  }

  @override
  void dispose() {
    provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BattleScreenProvider>.value(
      value: provider,
      builder: (context, _) {
        return Consumer<BattleScreenProvider>(
          builder: (context, prov, child) {
            StyleupBattleModel? styleUpBattle = prov.styleUpBattle;
            List<StyleupBattleItemModel> battleList =
                styleUpBattle?.battleItemList ?? [];
            if (battleList.isEmpty) {
              return Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '현재 참여하실 수 있는 배틀이 없어요',
                      style: ShownyStyle.body1(weight: FontWeight.w600),
                    ),
                    SizedBox(height: 14.toWidth),
                    ShownyButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            ShownyPageRoute(
                              builder: (context) => BattleList(),
                              settings:
                                  RouteSettings(name: PageName.BATTLE_LIST),
                            ));
                      },
                      option: ShownyButtonOption.line(
                        text: '배틀리스트',
                        theme: ShownyButtonLineTheme.violet,
                        style: ShownyButtonLineStyle.small,
                      ),
                    ),
                  ],
                ),
              );
            }
            return Material(
              color: ShownyStyle.black,
              child: Stack(
                children: [
                  PageView(
                    physics: const CustomScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    children: List.generate(battleList.length, (index) {
                      return BattleItem(
                        battleItem: battleList[index],
                        index: index,
                        battleRound: styleUpBattle?.round ?? '',
                        title: styleUpBattle?.title ?? '',
                        isMain: widget.isMain,
                        setData: prov.setBattleData,
                      );
                    }),
                  ),
                  if (!widget.isMain)
                    SafeArea(
                      child: SizedBox(
                        height: 48.toWidth,
                        child: Row(
                          children: [
                            CupertinoButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios_new,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
