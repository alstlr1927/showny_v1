import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/slivers/sliver_tween.dart';
import 'package:showny/screens/battle_list/providers/battle_list_provider.dart';
import 'package:showny/screens/battle_list/widgets/battle_slider_item.dart';
import 'package:showny/screens/battle_list/widgets/status_chip.dart';
import 'package:showny/utils/showny_util.dart';

import '../../components/showny_image/showny_image.dart';
import '../../models/battle_model.dart';
import '../../utils/showny_style.dart';

class BattleList extends StatefulWidget {
  const BattleList({super.key});

  @override
  State<BattleList> createState() => _BattleListState();
}

class _BattleListState extends State<BattleList>
    with SingleTickerProviderStateMixin {
  late BattleListProvider provider;

  @override
  void initState() {
    super.initState();
    provider = BattleListProvider(this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BattleListProvider>.value(
      value: provider,
      builder: (context, _) {
        BattleListProvider listProv =
            Provider.of<BattleListProvider>(context, listen: false);
        return Scaffold(
          appBar: AppBar(
            title: const Text('배틀 리스트'),
            scrolledUnderElevation: 0,
          ),
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 16.toWidth),
            width: ScreenUtil().screenWidth,
            child: Column(
              children: [
                _buildTabbar(listProv),
                _buildBattlesView(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildTabbar(BattleListProvider prov) {
    return TabBar(
      controller: prov.tabController,
      splashFactory: NoSplash.splashFactory,
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.label,
      indicatorColor: Colors.black,
      indicatorWeight: 1,
      indicator: BoxDecoration(
          border: Border(bottom: BorderSide(width: 1, color: Colors.black))),
      labelColor: Colors.black,
      labelPadding: EdgeInsets.only(bottom: 3.toWidth),
      labelStyle:
          ShownyStyle.caption(color: Colors.black, weight: FontWeight.w700),
      unselectedLabelColor: Colors.black,
      unselectedLabelStyle: ShownyStyle.caption(color: const Color(0xff656565)),
      onTap: prov.onTabChanged,
      tabs: const [
        Text('진행중인 배틀'),
        Text('전체 배틀'),
        Text('참여한 배틀'),
        Text('종료된 배틀'),
      ],
    );
  }

  Widget _buildBattlesView() {
    return Consumer<BattleListProvider>(
      builder: (context, prov, child) {
        return Expanded(
          child: CustomScrollView(
            physics: const ClampingScrollPhysics(),
            slivers: [
              if (!prov.isDataLoading) ...{
                if (prov.curType == ListType.ongoing) ...{
                  _battleSlideView(),
                  _sliderIndicator(),
                  _battleInfo(),
                } else ...{
                  _battleListView(),
                },
              } else ...{
                SliverToBoxAdapter(
                  child: SizedBox(),
                ),
              },
            ],
          ),
        );
      },
    );
  }

  Widget _battleSlideView() {
    return Builder(
      builder: (context) {
        BattleListProvider prov =
            Provider.of<BattleListProvider>(context, listen: false);
        return SliverTween(
          child: SliverToBoxAdapter(
            child: Container(
              width: ScreenUtil().screenWidth,
              height: ScreenUtil().screenWidth,
              margin: EdgeInsets.only(top: 60.toWidth),
              child: CarouselSlider.builder(
                itemCount: prov.battleDataList.length,
                itemBuilder: (context, index, realIndex) {
                  BattleModel item = prov.battleDataList[index];
                  return BattleSliderItem(
                    item: item,
                    onClickListener: () {
                      prov.onClickItemButton(item);
                    },
                  );
                },
                options: CarouselOptions(
                  aspectRatio: .64,
                  viewportFraction: .70,
                  enlargeFactor: .2,
                  enableInfiniteScroll: false,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {
                    prov.onSliderPageChanged(index);
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _sliderIndicator() {
    return Builder(
      builder: (context) {
        BattleListProvider prov =
            Provider.of<BattleListProvider>(context, listen: false);
        double indicator = ScreenUtil().screenWidth * .7;
        double barWidth = indicator / prov.battleDataList.length;
        return SliverTween(
          child: SliverToBoxAdapter(
            child: Column(
              children: [
                Container(
                  width: indicator,
                  height: 4,
                  margin: EdgeInsets.only(top: 30.toWidth),
                  child: prov.battleDataList.length > 1
                      ? Stack(
                          children: [
                            Align(
                              alignment: Alignment.center,
                              child: Container(
                                width: ScreenUtil().screenWidth * .7,
                                height: 3,
                                color: const Color(0xffd9d9d9),
                              ),
                            ),
                            AnimatedPositioned(
                              left: prov.sliderIdx * barWidth,
                              duration: const Duration(milliseconds: 150),
                              curve: Curves.easeInOut,
                              child: Container(
                                width: barWidth,
                                height: 4,
                                decoration: BoxDecoration(
                                  color: ShownyStyle.mainPurple,
                                  borderRadius: BorderRadius.circular(2),
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _battleInfo() {
    return Builder(
      builder: (context) {
        BattleListProvider prov =
            Provider.of<BattleListProvider>(context, listen: false);
        BattleModel item = prov.battleDataList[prov.sliderIdx];
        return SliverTween(
          child: SliverToBoxAdapter(
            child: Column(
              children: [
                SizedBox(height: 16.toWidth),
                Text(
                  item.title,
                  style: ShownyStyle.h5(
                      color: ShownyStyle.black, weight: FontWeight.w700),
                ),
                SizedBox(height: 12.toWidth),
                StatusChip(
                  title: prov.battleStatusStringEn(item.status),
                  color: prov.battleStatusColor(item.status),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _battleListView() {
    return Builder(
      builder: (context) {
        return SliverToBoxAdapter();
      },
    );
  }
}
