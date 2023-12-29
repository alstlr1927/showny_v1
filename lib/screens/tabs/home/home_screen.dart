import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:share_plus/share_plus.dart';

import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/models/styleup_battle_model.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/tabs/home/screen/battle_screen.dart';
import 'package:showny/screens/tabs/home/screen/styleup_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedMenuIdx = 0;
  late List<Widget> _homeMenu;
  int currentBattle = 0;
  StyleupBattleModel? styleupBattle;
  List<StyleupModel> styleupList = [];

  var showTag = false;

  void getStyleupList() {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

    ApiHelper.shared.getStyleupList(
      userProvider.user.memNo,
      '0',
      (styleupList) {
        debugPrint("Styleup list loaded successfully");
        setState(() {
          this.styleupList = styleupList;
          _homeMenu[0] = StyleupScreen(isMain: true, initIndex: 0, styleupList: styleupList, updateShowMenu: updateShowMenu);
        });
      },
      (error) {
        debugPrint("Error loading styleup list: $error");
      },
    );
  }

  void getBattleItemList() {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

    ApiHelper.shared.getStyleupBattleItemList(
      userProvider.user.memNo,
      (styleupBattleModel) {
        debugPrint("Battle list loaded successfully");
        setState(() {
          styleupBattle = styleupBattleModel;
          debugPrint(styleupBattleModel.battleItemList.length.toString());
          _homeMenu[1] = BattleScreen(
            battleList: styleupBattleModel.battleItemList,
            onPageChanged: (p0) {
              setState(() => currentBattle = p0);
            },
            title: styleupBattleModel.title,
            battleRound: styleupBattleModel.round, isMain: true,
            );
        });
      },
      (error) {
        debugPrint("Error loading styleup list: $error");
      },
    );
  }

  void updateShowMenu(bool isShow) {
    debugPrint("updateShowMenu");
    setState(() {
      showTag = isShow;
    });
  }

  @override
  void initState() {
    super.initState();

    _homeMenu = [
      StyleupScreen(
        isMain: true,
        initIndex: 0,
        styleupList: styleupList,
        updateShowMenu: updateShowMenu,
      ),
      BattleScreen(
        battleList: styleupBattle?.battleItemList ?? [],
        onPageChanged: (p0) {
          setState(() => currentBattle = p0);
        },
        title: "",
        battleRound: "",
        isMain: true,
      ),
    ];
    getStyleupList();
    getBattleItemList();
  }

  Size calculateTextSize({
    required String text,
    required TextStyle style,
    required BuildContext context,
  }) {
    final double textScaleFactor = MediaQuery.of(context).textScaleFactor;

    final ui.TextDirection textDirection = Directionality.of(context);

    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      textDirection: textDirection,
      textScaleFactor: textScaleFactor,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size;
  }

  @override
  Widget build(BuildContext context) {
    Widget homeMenuButton({required String label, required int index}) {
      bool isSelected = index == _selectedMenuIdx; // 현재 탭이 선택된 탭인지 여부

      var text = Text(
        label,
        style: TextStyle(
          fontSize: 16, // 폰트 크기
          fontWeight: isSelected
              ? FontWeight.w700
              : FontWeight.w400, // 선택된 탭은 w700, 선택되지 않은 탭은 w400
          color: Colors.white,
          shadows: const [
            Shadow(
              blurRadius: 4.0,
              color: Color(0xA3000000), // 그림자의 이동 방향과 거리
            ),
          ],
        ),
      );

      return CupertinoButton(
        onPressed: () => setState(() => _selectedMenuIdx = index),
        padding: EdgeInsets.zero,
        minSize: 0,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                bottom: 8,
              ),
              child: text,
            ),
            if (isSelected) ...[
              Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4.0,
                      color: Color(0xA3000000),
                    ),
                  ],
                ),
                height: 2.0,
                width: calculateTextSize(
                      text: text.data ?? "",
                      style: text.style ?? const TextStyle(),
                      context: context,
                    ).width + 2,
              ),
            ]
          ],
        ),
      );
    }

    return Stack(
      children: [
        Stack(
          children: [
            SafeArea(
              left: false,
              right: false,
              top: false,
              child: _homeMenu[_selectedMenuIdx],
            ),
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              const Spacer(),
                              !showTag ? homeMenuButton(label: "스타일업", index: 0) : const SizedBox(),
                              const SizedBox(width: 24),
                              !showTag ? homeMenuButton(label: "배틀", index: 1) : const SizedBox(),
                              const Spacer(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
