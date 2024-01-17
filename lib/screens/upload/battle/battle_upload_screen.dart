import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/appbar/pinned_appbar.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/components/showny_image/showny_image.dart';
import 'package:showny/models/battle_model.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/screens/upload/battle/models/battle_upload_model.dart';
import 'package:showny/screens/upload/battle/providers/battle_upload_provider.dart';
import 'package:showny/screens/upload/battle/widgets/reselect_battle.dart';
import 'package:showny/screens/upload/battle/widgets/reselect_styleup.dart';
import 'package:showny/utils/formatter.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class BattleUploadScreen extends StatefulWidget {
  final BattleUploadModel uploadSample;
  const BattleUploadScreen({
    super.key,
    required this.uploadSample,
  });

  @override
  State<BattleUploadScreen> createState() => _BattleUploadScreeStaten();
}

class _BattleUploadScreeStaten extends State<BattleUploadScreen> {
  late BattleUploadProvider provider;
  @override
  void initState() {
    super.initState();
    provider = BattleUploadProvider(this);
  }

  @override
  void dispose() {
    provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BattleUploadProvider>.value(
      value: provider,
      builder: (context, _) {
        return Consumer<BattleUploadProvider>(
          builder: (context, prov, child) {
            return WillPopScope(
              onWillPop: () async {
                prov.showExitDialog(context);
                return false;
              },
              child: Scaffold(
                appBar: AppBar(
                  title: const Text('배틀'),
                  leading: CupertinoButton(
                    onPressed: () {
                      prov.showExitDialog(context);
                    },
                    child: const Icon(Icons.arrow_back_ios,
                        color: ShownyStyle.black),
                  ),
                  automaticallyImplyLeading: false,
                ),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                  child: Column(
                    children: [
                      SizedBox(height: 24.toWidth),
                      _buildBattleItem(prov.uploadModel.battle!),
                      SizedBox(height: 10.toWidth),
                      _buildStyleupItem(prov.uploadModel.styleup!),
                      const Spacer(),
                      _buildUploadButton(),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildBattleItem(BattleModel battle) {
    return Builder(builder: (context) {
      BattleUploadProvider prov =
          Provider.of<BattleUploadProvider>(context, listen: false);
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: double.infinity,
          height: 160.toWidth,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 118.toWidth),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(width: 1, color: const Color(0xffdddddd))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 14.toWidth),
                    Text(
                      battle.title,
                      style: ShownyStyle.body2(
                          color: ShownyStyle.black, weight: FontWeight.w700),
                    ),
                    Text(
                      battle.progress,
                      style: ShownyStyle.caption(
                          color: ShownyStyle.black, weight: FontWeight.w700),
                    ),
                    SizedBox(height: 4.toWidth),
                    Text(
                      '참여기간 : ${Formatter.formatDateString(battle.participationEnd)} 까지',
                      style: ShownyStyle.caption(color: ShownyStyle.black),
                    ),
                    const Spacer(),
                    CupertinoButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            ShownyPageRoute(
                                builder: (context) => ReselectBattle(
                                      onSelect: (battle) {
                                        prov.setUploadModel(prov.uploadModel
                                            .copyWith(battle: battle));
                                      },
                                    ),
                                settings: const RouteSettings(
                                    name: PageName.RESELECT_BATTLE)));
                      },
                      padding: EdgeInsets.zero,
                      minSize: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '다른 배틀 선택하기',
                            style: ShownyStyle.caption(
                              color: ShownyStyle.black,
                            ),
                          ),
                          SizedBox(width: 4.toWidth),
                          Image.asset(
                            'assets/icons/upload/right_arrow.png',
                            width: 12.toWidth,
                          ),
                          SizedBox(width: 12.toWidth),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.toWidth),
                  ],
                ),
              ),
              ShownyImage(
                imageUrl: battle.thumbnailUrl,
                fit: BoxFit.cover,
                width: 104.toWidth,
                height: 160.toWidth,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildStyleupItem(StyleupModel styleup) {
    return Builder(builder: (context) {
      BattleUploadProvider prov =
          Provider.of<BattleUploadProvider>(context, listen: false);
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: double.infinity,
          height: 160.toWidth,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.only(left: 118.toWidth),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border:
                        Border.all(width: 1, color: const Color(0xffdddddd))),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 14.toWidth),
                    Text(
                      styleup.description,
                      style: ShownyStyle.caption(color: ShownyStyle.black),
                    ),
                    const Spacer(),
                    CupertinoButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            ShownyPageRoute(
                              builder: (context) => ReselectStyleup(
                                onSelect: (file, styleup) {
                                  prov.setUploadModel(prov.uploadModel.copyWith(
                                      thumbNailFile: file, styleup: styleup));
                                },
                              ),
                            ));
                      },
                      padding: EdgeInsets.zero,
                      minSize: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            '다른 스타일 선택하기',
                            style: ShownyStyle.caption(
                              color: ShownyStyle.black,
                            ),
                          ),
                          SizedBox(width: 4.toWidth),
                          Image.asset(
                            'assets/icons/upload/right_arrow.png',
                            width: 12.toWidth,
                          ),
                          SizedBox(width: 12.toWidth),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.toWidth),
                  ],
                ),
              ),
              Image.file(
                prov.uploadModel.thumbNailFile!,
                fit: BoxFit.cover,
                width: 104.toWidth,
                height: 160.toWidth,
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildUploadButton() {
    return Consumer<BattleUploadProvider>(builder: (ctx, prov, child) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: ShownyStyle.defaultBottomPadding() + 24.toWidth,
        ),
        child: ShownyButton(
          onPressed: prov.handleBattleUpload,
          option: ShownyButtonOption.fill(
            text: '완료',
            theme: ShownyButtonFillTheme.violet,
            style: ShownyButtonFillStyle.fullRegular,
          ),
        ),
      );
    });
  }
}
