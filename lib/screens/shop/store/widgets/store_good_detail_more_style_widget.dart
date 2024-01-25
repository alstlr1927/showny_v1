import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/helper/color_helper.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';

import '../../../../api/new_api/api_helper.dart';
import '../../../../models/GetGoodsStyleupListModel.dart';
import '../../../home/styleup/styleup_screen.dart';
import '../../../profile/other_profile_screen.dart';
import '../../../profile/profile_screen.dart';

class StoreGoodDetailMoreStyleWidget extends StatefulWidget {
  final StoreGoodModel goodsData;

  const StoreGoodDetailMoreStyleWidget({super.key, required this.goodsData});

  @override
  State<StoreGoodDetailMoreStyleWidget> createState() =>
      _StoreGoodDetailMoreStyleWidget();
}

class _StoreGoodDetailMoreStyleWidget
    extends State<StoreGoodDetailMoreStyleWidget> {
  GetGoodsStyleupListModel? goodsStyleupListModel;

  @override
  void initState() {
    super.initState();
    getGoodsStyleupListData();
  }

  getGoodsStyleupListData() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final String memNo = user.memNo;

    ApiHelper.shared.getGoodsStyleupList(memNo, widget.goodsData.goodsNo, 0,
        (getGoodsStyleupListModel) {
      setState(() {
        goodsStyleupListModel = getGoodsStyleupListModel;
      });
    }, (error) {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: goodsStyleupListModel == null
          ? (130 * 5 / 4) + 170
          : goodsStyleupListModel!.styleupDataList.isEmpty
              ? 0
              : (130 * 5 / 4) + 170,
      child: Center(
        child: goodsStyleupListModel == null
            ? const CircularProgressIndicator()
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 48,
                    child: Column(
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tr("profile_edit.style"),
                                style: FontHelper.regular_14_000000,
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      ShownyPageRoute(
                                        builder: (context) => StyleupScreen(
                                          isMain: false,
                                          initIndex: 0,
                                          styleupList: goodsStyleupListModel!
                                              .styleupDataList,
                                        ),
                                      ));
                                },
                                child: Container(
                                  color: Colors.transparent,
                                  child: Row(
                                    children: [
                                      Text(
                                        "${goodsStyleupListModel!.styleupCount}",
                                        style: ShownyStyle.caption(),
                                      ),
                                      const SizedBox(width: 4),
                                      Image.asset(
                                        arrowForward,
                                        height: 12,
                                        width: 12,
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 8)
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    height: (130 * 5 / 4) + 170 - 48,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: goodsStyleupListModel!.styleupDataList.length,
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: SizedBox(
                            width: 130,
                            height: (130 * 5 / 4) + 170 - 48,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        ShownyPageRoute(
                                          builder: (context) => StyleupScreen(
                                            isMain: false,
                                            initIndex: index,
                                            styleupList: goodsStyleupListModel!
                                                .styleupDataList,
                                          ),
                                        ));
                                  },
                                  child: SizedBox(
                                    width: 130,
                                    height: 130 * 5 / 4,
                                    child: Image.network(
                                        goodsStyleupListModel!
                                            .styleupDataList[index]
                                            .thumbnailUrl,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error,
                                                stackTrace) =>
                                            Container(
                                              color:
                                                  ColorHelper.placeholderColor,
                                            )),
                                  ),
                                ),
                                const SizedBox(height: 12),
                                GestureDetector(
                                  onTap: () {
                                    if (Provider.of<UserProvider>(context,
                                                listen: false)
                                            .user
                                            .memNo ==
                                        goodsStyleupListModel!
                                            .styleupDataList[index]
                                            .userInfo
                                            .memNo) {
                                      Navigator.push(
                                          context,
                                          ShownyPageRoute(
                                            builder: (context) =>
                                                ProfileScreen(),
                                          ));
                                    } else {
                                      Navigator.push(
                                          context,
                                          ShownyPageRoute(
                                            builder: (context) =>
                                                OtherProfileScreen(
                                                    memNo:
                                                        goodsStyleupListModel!
                                                            .styleupDataList[
                                                                index]
                                                            .userInfo
                                                            .memNo),
                                          ));
                                    }
                                  },
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: SizedBox(
                                          height: 24,
                                          width: 24,
                                          child: Image.network(
                                              goodsStyleupListModel!
                                                  .styleupDataList[index]
                                                  .userInfo
                                                  .profileImage,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  Container(
                                                    color: ColorHelper
                                                        .placeholderColor,
                                                  )),
                                        ),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        goodsStyleupListModel!
                                            .styleupDataList[index]
                                            .userInfo
                                            .memNm,
                                        style: ShownyStyle.overline(),
                                      )
                                    ],
                                  ),
                                ),
                                goodsStyleupListModel!.styleupDataList[index]
                                            .description ==
                                        ""
                                    ? const SizedBox()
                                    : Column(
                                        children: [
                                          const SizedBox(height: 8),
                                          Text(
                                              goodsStyleupListModel!
                                                  .styleupDataList[index]
                                                  .description,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: ShownyStyle.caption()),
                                        ],
                                      ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    Text(
                                        "좋아요 ${goodsStyleupListModel!.styleupDataList[index].heartCnt}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: ShownyStyle.caption()),
                                    const SizedBox(width: 4),
                                    Text(
                                        "댓글 ${goodsStyleupListModel!.styleupDataList[index].commentCnt}",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: ShownyStyle.caption()),
                                  ],
                                ),
                              ],
                            ),
                          )),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
