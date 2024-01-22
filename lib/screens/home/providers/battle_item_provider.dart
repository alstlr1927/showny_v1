import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/components/logger/showny_logger.dart';
import 'package:showny/models/battle_vote_response_model.dart';
import 'package:showny/models/styleup_battle_item_model.dart';
import 'package:showny/screens/home/providers/home_provider.dart';
import 'package:showny/providers/user_model_provider.dart';

import '../widgets/battle_item.dart';

class BattleItemProvider with ChangeNotifier {
  State<BattleItem> state;

  Duration longPressDuration = const Duration(milliseconds: 100);
  double pressPosition = 0.0;
  bool isSelectMode = false;
  int focused = -1;

  // animation
  late AnimationController _animation;
  late Animation<double> scaleAnimationA;
  late Animation<double> scaleAnimationB;
  late Animation<Offset> positionA;
  late Animation<Offset> positionB;

  Future selectLeft() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(state.context, listen: false);
    final user = userProvider.user;
    StyleupBattleItemModel item = state.widget.battleItem;

    await ApiHelper.shared.selectStyleupBattleItem(
      state.widget.battleItem.battleRoundNo,
      item.styleup1.styleupNo,
      item.styleup2.styleupNo,
      user.memNo,
      (battleVoteResponse) {
        StyleupBattleItemModel copy = state.widget.battleItem.copyWith(
          isPoll: true,
          pollTag: 1,
          style1PollCnt: battleVoteResponse.style1PollCnt,
          style2PollCnt: battleVoteResponse.style2PollCnt,
        );
        ShownyLog().e('1Cnt_ : ${battleVoteResponse.style1PollCnt}');
        ShownyLog().e('2Cnt_ : ${battleVoteResponse.style2PollCnt}');
        state.widget.setData(
          roundNo: state.widget.battleItem.battleRoundNo,
          copy: copy,
        );
        if (state.widget.isMain) {
          HomeProvider homeProv =
              Provider.of<HomeProvider>(state.context, listen: false);
          homeProv.setIsBattleSelected(true);
        }
      },
      (error) {},
    );
  }

  Future selectRight() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(state.context, listen: false);
    final user = userProvider.user;
    StyleupBattleItemModel item = state.widget.battleItem;

    await ApiHelper.shared.selectStyleupBattleItem(
      state.widget.battleItem.battleRoundNo,
      item.styleup2.styleupNo,
      item.styleup1.styleupNo,
      user.memNo,
      (BattleVoteResponseModel battleVoteResponse) {
        StyleupBattleItemModel copy = state.widget.battleItem.copyWith(
          isPoll: true,
          pollTag: 2,
          style1PollCnt: battleVoteResponse.style1PollCnt,
          style2PollCnt: battleVoteResponse.style2PollCnt,
        );

        state.widget.setData(
          roundNo: state.widget.battleItem.battleRoundNo,
          copy: copy,
        );
        if (state.widget.isMain) {
          HomeProvider homeProv =
              Provider.of<HomeProvider>(state.context, listen: false);
          homeProv.setIsBattleSelected(true);
        }
      },
      (error) {},
    );
  }

  Future setFocused(int val) async {
    if (val != -1) {
      if (val == 0) {
        await selectLeft();
      } else if (val == 1) {
        await selectRight();
      }
    } else {
      if (state.widget.isMain) {
        HomeProvider homeProv =
            Provider.of<HomeProvider>(state.context, listen: false);
        homeProv.setIsBattleSelected(false);
      }
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
    if (item.isPoll) {
      if (item.pollTag == 1) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (state.widget.isMain) {
            HomeProvider homeProv =
                Provider.of<HomeProvider>(state.context, listen: false);
            homeProv.setIsBattleSelected(true);
          }
        });
        selectedLeft();
      } else if (item.pollTag == 2) {
        WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
          if (state.widget.isMain) {
            HomeProvider homeProv =
                Provider.of<HomeProvider>(state.context, listen: false);
            homeProv.setIsBattleSelected(true);
          }
        });
        selectedRight();
      }
    } else {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (state.widget.isMain) {
          HomeProvider homeProv =
              Provider.of<HomeProvider>(state.context, listen: false);
          homeProv.setIsBattleSelected(false);
        }
      });
      setupLeftAnimation();
    }
  }

  BattleItemProvider(this.state) {
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
    notifyListeners();
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
    notifyListeners();
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
