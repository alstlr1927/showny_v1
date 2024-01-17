import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/components/showny_image/showny_image.dart';
import 'package:showny/models/battle_model.dart';
import 'package:showny/screens/upload/battle/models/battle_upload_model.dart';
import 'package:showny/screens/upload/battle/providers/select_battle_provider.dart';
import 'package:showny/utils/formatter.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class ReselectBattle extends StatefulWidget {
  final Function(BattleModel battle) onSelect;
  const ReselectBattle({
    super.key,
    required this.onSelect,
  });

  @override
  State<ReselectBattle> createState() => _ReselectBattleState();
}

class _ReselectBattleState extends State<ReselectBattle> {
  late SelectBattleProvider provider;

  @override
  void initState() {
    super.initState();
    provider = SelectBattleProvider(this);
  }

  @override
  void dispose() {
    provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      builder: (context, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('배틀선택'),
          ),
          body: Column(
            children: [
              SizedBox(height: 30.toWidth),
              _buildBattleSlider(),
              _buildSliderIndicator(),
              _buildBattleInfo(),
              const Spacer(),
              _buildSelectButton(),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBattleSlider() {
    return Consumer<SelectBattleProvider>(
      builder: (context, prov, child) {
        return SizedBox(
          width: ScreenUtil().screenWidth,
          height: ScreenUtil().screenWidth,
          child: CarouselSlider.builder(
            itemCount: prov.battleList.length,
            itemBuilder: (context, index, realIndex) {
              BattleModel item = prov.battleList[index];
              return ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: ShownyImage(
                  imageUrl: item.thumbnailUrl,
                  fit: BoxFit.cover,
                ),
                // child: Image.network(
                //   item.thumbnailUrl,
                //   fit: BoxFit.cover,
                // ),
              );
            },
            options: CarouselOptions(
              aspectRatio: 3 / 4,
              viewportFraction: .70,
              enlargeFactor: .2,
              enableInfiniteScroll: false,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                prov.onPageChanged(index);
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildSliderIndicator() {
    return Consumer<SelectBattleProvider>(
      builder: (context, prov, child) {
        double indicator = ScreenUtil().screenWidth * .7;
        double barWidth = indicator / prov.battleList.length;
        return Column(
          children: [
            Container(
              width: indicator,
              height: 4,
              margin: EdgeInsets.only(top: 30.toWidth),
              child: prov.battleList.length != 1
                  ? const SizedBox()
                  : Stack(
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
                          left: prov.currentIdx * barWidth,
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
                    ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBattleInfo() {
    return Consumer<SelectBattleProvider>(
      builder: (context, prov, child) {
        if (prov.battleList.isEmpty) {
          return Container();
        }
        BattleModel curModel = prov.battleList[prov.currentIdx];
        String recruitStart = Formatter.formatDateString(
            curModel.recruitmentStart,
            onlyMonthDay: true);
        String recruitEnd = Formatter.formatDateString(curModel.recruitmentEnd,
            onlyMonthDay: true);
        String participation = Formatter.formatDateString(
            curModel.participationStart,
            onlyMonthDay: true);
        return Column(
          children: [
            SizedBox(height: 16.toWidth),
            Text(
              curModel.title,
              style: ShownyStyle.h5(
                  color: ShownyStyle.black, weight: FontWeight.w700),
            ),
            SizedBox(height: 6.toWidth),
            Text(
              '모집기간 $recruitStart - $recruitEnd',
              style: ShownyStyle.overline(
                color: const Color(0xff555555),
              ),
            ),
            SizedBox(height: 2.toWidth),
            Text(
              '배틀시작 $participation',
              style: ShownyStyle.overline(
                color: const Color(0xff555555),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSelectButton() {
    return Consumer<SelectBattleProvider>(builder: (context, prov, child) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
        child: Column(
          children: [
            ShownyButton(
              onPressed: () {
                BattleModel battle = prov.battleList[prov.currentIdx]
                    .copyWith(title: 'heheheheh');
                widget.onSelect(battle);
                Navigator.pop(context);
              },
              option: ShownyButtonOption.fill(
                text: '선택완료',
                theme: ShownyButtonFillTheme.violet,
                style: ShownyButtonFillStyle.fullRegular,
              ),
            ),
            SizedBox(height: ShownyStyle.defaultBottomPadding() + 50 + 14)
          ],
        ),
      );
    });
  }
}
