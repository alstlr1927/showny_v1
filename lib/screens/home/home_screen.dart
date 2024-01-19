import 'package:flutter/material.dart';
import 'package:showny/components/keep_alive_widget/keep_alive_widget.dart';

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
                      return KeepAliveWidget(
                        child: BattleScreen.home(),
                      );
                    }
                  },
                ),
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
              ],
            );
          });
        });
  }
}
