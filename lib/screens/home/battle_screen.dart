import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/styleup_battle_item_model.dart';
import '../../models/styleup_battle_model.dart';
import '../common/scroll_physics/custom_scroll_physics.dart';
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
