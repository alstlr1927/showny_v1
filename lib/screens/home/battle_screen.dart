import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/models/styleup_battle_item_model.dart';
import 'package:showny/models/user_model.dart';
import 'package:showny/screens/common/scroll_physics/custom_scroll_physics.dart';
import 'package:provider/provider.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/home/providers/battle_screen_provider.dart';
import 'package:showny/screens/home/widgets/battle_item.dart';
import 'package:showny/screens/profile/other_profile_screen.dart';

import '../../models/styleup_battle_model.dart';

class BattleScreen extends StatefulWidget {
  const BattleScreen({
    super.key,
    // required this.battleList,
    // required this.title,
    // required this.battleRound,
    this.isMain = true,
  });

  final bool isMain;
  // final String title;
  // final List<StyleupBattleItemModel> battleList;
  // final String battleRound;

  @override
  State<BattleScreen> createState() => _BattleScreenState();
}

class _BattleScreenState extends State<BattleScreen> {
  SwiperController swiperController = SwiperController();
  bool pollLock = false;

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
            return Material(
              child: PageView(
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
            );
          },
        );
      },
    );
  }
}
