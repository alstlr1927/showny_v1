import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/components/showny_image/showny_image.dart';
import 'package:showny/models/battle_model.dart';
import 'package:showny/screens/upload/battle/models/battle_upload_model.dart';
import 'package:showny/screens/upload/battle/providers/select_battle_provider.dart';
import 'package:showny/screens/upload/battle/select_stylup.dart';
import 'package:showny/utils/formatter.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class SelectBattle extends StatefulWidget {
  const SelectBattle({super.key});

  @override
  State<SelectBattle> createState() => _SelectBattleState();
}

class _SelectBattleState extends State<SelectBattle> {
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
    return ChangeNotifierProvider<SelectBattleProvider>.value(
      value: provider,
      child: Consumer<SelectBattleProvider>(builder: (context, prov, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('배틀'),
            scrolledUnderElevation: 0,
            // actions: [
            //   ShownyButton(
            //     onPressed: () {},
            //     option: ShownyButtonOption.text(
            //       text: '등록',
            //       theme: ShownyButtonTextTheme.black,
            //       style: ShownyButtonTextStyle.regular,
            //     ),
            //   ),
            // ],
          ),
          body: prov.battleList.isEmpty
              ? Container(
                  margin: EdgeInsets.only(bottom: 140.toWidth),
                  child: Center(
                    child: Text(
                      '오픈된 배틀이 없습니다!',
                      style: ShownyStyle.body1(),
                    ),
                  ),
                )
              : Column(
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
      }),
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
              child: prov.battleList.length == 1
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
                BattleUploadModel uploadSample =
                    BattleUploadModel(battle: prov.battleList[prov.currentIdx]);

                Navigator.push(
                    context,
                    ShownyPageRoute(
                        builder: (context) =>
                            SelectStyleup(uploadSample: uploadSample),
                        settings: const RouteSettings(
                            name: PageName.SELECT_STYLEUP)));
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
