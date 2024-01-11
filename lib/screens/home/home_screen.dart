import 'package:flutter/material.dart';
import 'package:showny/components/keep_alive_widget/keep_alive_widget.dart';
import 'package:showny/screens/common/scroll_physics/custom_scroll_physics.dart';

import 'package:showny/screens/home/providers/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:showny/screens/home/battle_screen.dart';
import 'package:showny/screens/home/styleup_screen.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late HomeProvider provider;

  @override
  void initState() {
    super.initState();
    provider = HomeProvider(this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomeProvider>.value(
        value: provider,
        builder: (context, _) {
          return Consumer<HomeProvider>(builder: (ctx, prov, child) {
            return Stack(
              children: [
                PageView.builder(
                  itemCount: 2,
                  physics: prov.getPhysics(),
                  controller: prov.pageController,
                  onPageChanged: prov.setTab,
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      return KeepAliveWidget(
                        child: StyleupScreen(
                          initIndex: 0,
                          styleupList: prov.styleUpList,
                          isMain: true,
                          afterFollowAction: prov.setStyleUpFollow,
                          afterUpDownAction: prov.setStyleUpDown,
                        ),
                      );
                    } else {
                      // return PageView.builder(
                      //   physics: const CustomScrollPhysics(),
                      //   scrollDirection: Axis.vertical,
                      //   itemCount: 8,
                      //   itemBuilder: (context, i) {
                      //     return Container(
                      //       color: Colors.green[100 + 100 * i],
                      //     );
                      //   },
                      // );
                      return BattleScreen(
                        battleList: prov.styleUpBattle?.battleItemList ?? [],
                        onPageChanged: prov.setCurrentBattle,
                        title: prov.styleUpBattle?.title ?? '',
                        battleRound: prov.styleUpBattle?.round ?? '',
                        isMain: true,
                      );
                    }
                  },
                ),
                // PageView(
                //   physics: prov.getPhysics(),
                //   controller: prov.pageController,
                //   onPageChanged: prov.setTab,
                //   children: [
                //     StyleupScreen(
                //       initIndex: 0,
                //       styleupList: prov.styleUpList,
                //       isMain: true,
                //       afterFollowAction: prov.setStyleUpFollow,
                //       afterUpDownAction: prov.setStyleUpDown,
                //     ),
                //     BattleScreen(
                //       battleList: prov.styleUpBattle?.battleItemList ?? [],
                //       onPageChanged: prov.setCurrentBattle,
                //       title: prov.styleUpBattle?.title ?? '',
                //       battleRound: prov.styleUpBattle?.round ?? '',
                //       isMain: true,
                //     ),
                //   ],
                // ),
                SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(top: 15.toWidth),
                    child: TabBar(
                      controller: prov.tabController,
                      dividerColor: Colors.transparent,
                      indicatorColor: Colors.white,
                      indicatorSize: TabBarIndicatorSize.label,
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.white,
                      labelPadding: EdgeInsets.only(bottom: 3.toWidth),
                      labelStyle: ShownyStyle.body2(
                          color: Colors.white, weight: FontWeight.w700),
                      unselectedLabelStyle:
                          ShownyStyle.caption(color: Colors.white),
                      tabs: const [
                        Text('스타일업'),
                        Text('배틀'),
                      ],
                      onTap: prov.setpage,
                    ),
                  ),
                ),
                // Stack(
                //   children: [
                //     SafeArea(
                //       left: false,
                //       right: false,
                //       top: false,
                //       child: prov.currentScreen,
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
                //                       const Spacer(),
                //                       !prov.showTag
                //                           ? homeMenuButton(
                //                               label: "스타일업",
                //                               index: 0,
                //                               prov: prov,
                //                             )
                //                           : const SizedBox(),
                //                       const SizedBox(width: 24),
                //                       !prov.showTag
                //                           ? homeMenuButton(
                //                               label: "배틀",
                //                               index: 1,
                //                               prov: prov,
                //                             )
                //                           : const SizedBox(),
                //                       const Spacer(),
                //                     ],
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //           const Spacer(),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
              ],
            );
          });
        });
  }

  // Widget homeMenuButton(
  //     {required String label, required int index, required HomeProvider prov}) {
  //   bool isSelected = index == prov.selectedMenuIdx; // 현재 탭이 선택된 탭인지 여부

  //   var text = Text(
  //     label,
  //     style: TextStyle(
  //       fontSize: 16, // 폰트 크기
  //       fontWeight: isSelected
  //           ? FontWeight.w700
  //           : FontWeight.w400, // 선택된 탭은 w700, 선택되지 않은 탭은 w400
  //       color: Colors.white,
  //       shadows: const [
  //         Shadow(
  //           blurRadius: 4.0,
  //           color: Color(0xA3000000), // 그림자의 이동 방향과 거리
  //         ),
  //       ],
  //     ),
  //   );

  //   return CupertinoButton(
  //     // onPressed: () => setState(() => _selectedMenuIdx = index),
  //     onPressed: () {
  //       prov.setSelectedMenuIdx(index);
  //     },
  //     padding: EdgeInsets.zero,
  //     minSize: 0,
  //     child: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.only(
  //             bottom: 8,
  //           ),
  //           child: text,
  //         ),
  //         if (isSelected) ...[
  //           Container(
  //             decoration: const BoxDecoration(
  //               color: Colors.white,
  //               boxShadow: [
  //                 BoxShadow(
  //                   blurRadius: 4.0,
  //                   color: Color(0xA3000000),
  //                 ),
  //               ],
  //             ),
  //             height: 2.0,
  //             width: calculateTextSize(
  //                   text: text.data ?? "",
  //                   style: text.style ?? const TextStyle(),
  //                   context: context,
  //                 ).width +
  //                 2,
  //           ),
  //         ]
  //       ],
  //     ),
  //   );
  // }
}
