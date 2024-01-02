import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/models/styleup_battle_item_model.dart';
import 'package:showny/providers/home_provider.dart';
import 'package:showny/providers/user_model_provider.dart';

import '../screens/tabs/home/screen/battle_item.dart';

class BattleItemProvider with ChangeNotifier {
  State<BattleItem> state;

  Duration longPressDuration = const Duration(milliseconds: 100);
  double pressPosition = 0.0;
  bool isSelectMode = false;
  int focused = -1;

  late HomeProvider homeProv;

  // animation
  late AnimationController _animation;
  late Animation<double> scaleAnimationA;
  late Animation<double> scaleAnimationB;
  late Animation<Offset> positionA;
  late Animation<Offset> positionB;

  Future<StyleupBattleItemModel?> selectLeft() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(state.context, listen: false);
    final user = userProvider.user;
    StyleupBattleItemModel item = state.widget.battleItem;

    // ApiHelper.shared.selectStyleupBattleItem(
    //   state.widget.battleItem.battleRoundNo,
    //   item.styleup1.styleupNo,
    //   item.styleup2.styleupNo,
    //   user.memNo,
    //   (battleVoteResponse) {
    //     print('?????? api call : ');
    //     StyleupBattleItemModel copy = state.widget.battleItem.copyWith(
    //       isPoll: true,
    //       pollTag: 1,
    //       style1PollCnt: battleVoteResponse.style1PollCnt,
    //       style2PollCnt: battleVoteResponse.style2PollCnt,
    //     );
    //     return copy;
    //   },
    //   (error) {
    //     return null;
    //   },
    // );

    StyleupBattleItemModel copy = state.widget.battleItem.copyWith(
      isPoll: true,
      pollTag: 1,
      style1PollCnt: state.widget.battleItem.style1PollCnt + 1,
      style2PollCnt: state.widget.battleItem.style2PollCnt,
    );

    return copy;

    return null;
  }

  Future<StyleupBattleItemModel?> selectRight() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(state.context, listen: false);
    final user = userProvider.user;
    StyleupBattleItemModel item = state.widget.battleItem;

    // ApiHelper.shared.selectStyleupBattleItem(
    //   state.widget.battleItem.battleRoundNo,
    //   item.styleup2.styleupNo,
    //   item.styleup1.styleupNo,
    //   user.memNo,
    //   (battleVoteResponse) {
    //     print('?????? api call');
    //     StyleupBattleItemModel copy = state.widget.battleItem.copyWith(
    //       isPoll: true,
    //       pollTag: 2,
    //       style1PollCnt: battleVoteResponse.style1PollCnt,
    //       style2PollCnt: battleVoteResponse.style2PollCnt,
    //     );
    //     return copy;
    //   },
    //   (error) {
    //     return null;
    //   },
    // );
    StyleupBattleItemModel copy = state.widget.battleItem.copyWith(
      isPoll: true,
      pollTag: 2,
      style1PollCnt: state.widget.battleItem.style1PollCnt,
      style2PollCnt: state.widget.battleItem.style2PollCnt + 1,
    );
    return copy;
    return null;
  }

  Future setFocused(int val) async {
    if (val != -1) {
      if (val == 0) {
        StyleupBattleItemModel? copy = await selectLeft();
        if (copy != null) {
          homeProv.setBattleData(
            roundNo: state.widget.battleItem.battleRoundNo,
            copy: copy,
          );
        } else {
          // error
        }
      } else if (val == 1) {
        StyleupBattleItemModel? copy = await selectRight();
        if (copy != null) {
          homeProv.setBattleData(
            roundNo: state.widget.battleItem.battleRoundNo,
            copy: copy,
          );
        } else {
          // error
        }
      }
      homeProv.setIsBattleSelected(true);
    } else {
      homeProv.setIsBattleSelected(false);
    }

    focused = val;
    notifyListeners();
  }

  Future onPanUpdate(DragUpdateDetails details) async {
    if (state.widget.battleItem.isPoll) return;
    if (!_animation.isAnimating) {
      if (details.delta.dx < -2) {
        await startRightAnimation();
      } else if (details.delta.dx > 2) {
        await startLeftAnimation();
      }
    }

    notifyListeners();
  }

  Future startLeftAnimation() async {
    if (!_animation.isAnimating) {
      if (focused == 0) return;
      _animation.reset();
      setupLeftAnimation();
      setFocused(0);
      await _animation.forward();
      HapticFeedback.lightImpact();
    }
  }

  Future startRightAnimation() async {
    if (!_animation.isAnimating) {
      if (focused == 1) return;
      _animation.reset();
      setupRightAnimation();
      setFocused(1);
      await _animation.forward();
      HapticFeedback.lightImpact();
    }
  }

  @override
  void notifyListeners() {
    if (state.mounted) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    _animation.dispose();
    super.dispose();
  }

  void _initSetting() {
    _animation = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: state as TickerProvider,
    );

    StyleupBattleItemModel item = state.widget.battleItem;
    print('isPoll : ${item.isPoll}');
    print('pollTag : ${item.pollTag}');

    if (item.isPoll) {
      if (item.pollTag == 1) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          homeProv.setIsBattleSelected(true);
        });
        selectedLeft();
      } else if (item.pollTag == 2) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          homeProv.setIsBattleSelected(true);
        });
        selectedRight();
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        homeProv.setIsBattleSelected(false);
      });
      setupLeftAnimation();
    }
  }

  BattleItemProvider(this.state) {
    homeProv = Provider.of<HomeProvider>(state.context, listen: false);
    _initSetting();
  }

  void selectedLeft() {
    focused = 0;
    notifyListeners();
    scaleAnimationA = Tween<double>(begin: 1.5, end: 1.5).animate(_animation);
    scaleAnimationB = Tween<double>(begin: 1.0, end: 1.0).animate(_animation);
    positionA =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, 0))
            .animate(_animation);
    positionB =
        Tween<Offset>(begin: const Offset(.6, 0), end: const Offset(.6, 0))
            .animate(_animation);
  }

  void selectedRight() {
    focused = 1;
    notifyListeners();
    scaleAnimationA = Tween<double>(begin: 1.0, end: 1.0).animate(_animation);
    scaleAnimationB = Tween<double>(begin: 1.5, end: 1.5).animate(_animation);
    positionA =
        Tween<Offset>(begin: const Offset(-.6, 0), end: const Offset(-.6, .0))
            .animate(_animation);
    positionB =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(0, 0))
            .animate(_animation);
  }

  void setupLeftAnimation() {
    scaleAnimationA = Tween<double>(begin: 1.0, end: 1.5).animate(_animation);
    scaleAnimationB = Tween<double>(begin: 1.0, end: 1.0).animate(_animation);
    positionA =
        Tween<Offset>(begin: const Offset(-.6, 0), end: const Offset(0, 0))
            .animate(_animation);
    positionB =
        Tween<Offset>(begin: const Offset(.6, 0), end: const Offset(.6, .0))
            .animate(_animation);
  }

  void setupRightAnimation() {
    scaleAnimationA = Tween<double>(begin: 1.0, end: 1.0).animate(_animation);
    scaleAnimationB = Tween<double>(begin: 1.0, end: 1.5).animate(_animation);
    positionA =
        Tween<Offset>(begin: const Offset(-.6, 0), end: const Offset(-.6, .0))
            .animate(_animation);
    positionB =
        Tween<Offset>(begin: const Offset(.6, 0), end: const Offset(0, 0))
            .animate(_animation);
  }
}
