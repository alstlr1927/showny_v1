import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/indicator/showny_indicator.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/components/user_profile/profile_container.dart';
import 'package:showny/helper/color_helper.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

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
    if (goodsStyleupListModel == null) {
      return Container(
        width: double.infinity,
        height: 100,
        child: Center(
          child: ShownyIndicator(
            color: ShownyStyle.mainPurple,
            radius: 15,
          ),
        ),
      );
    }
    if (goodsStyleupListModel!.styleupDataList.isEmpty) {
      return SizedBox();
    }

    return SizedBox(
      width: size.width,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 14.toWidth),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 16.toWidth, vertical: 10.toWidth),
              child: Row(
                children: [
                  Text(
                    tr("profile_edit.style"),
                    style: ShownyStyle.body2(
                        color: ShownyStyle.black, weight: FontWeight.w700),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          ShownyPageRoute(
                            builder: (context) => StyleupScreen(
                              isMain: false,
                              initIndex: 0,
                              styleupList:
                                  goodsStyleupListModel!.styleupDataList,
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
                            'assets/icons/shop/right_arrow.png',
                            height: 10.toWidth,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: size.width,
              height: 320.toWidth,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: goodsStyleupListModel!.styleupDataList.length,
                padding: EdgeInsets.only(left: 16.toWidth, right: 16.toWidth),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(right: 8.toWidth),
                  width: 130.toWidth,
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
                                  styleupList:
                                      goodsStyleupListModel!.styleupDataList,
                                ),
                              ));
                        },
                        child: SizedBox(
                          width: 130.toWidth,
                          height: 200.toWidth,
                          child: Image.network(
                              goodsStyleupListModel!
                                  .styleupDataList[index].thumbnailUrl,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    color: ColorHelper.placeholderColor,
                                  )),
                        ),
                      ),
                      SizedBox(height: 12.toWidth),
                      GestureDetector(
                        onTap: () {
                          if (Provider.of<UserProvider>(context, listen: false)
                                  .user
                                  .memNo ==
                              goodsStyleupListModel!
                                  .styleupDataList[index].userInfo.memNo) {
                            // Navigator.push(
                            //     context,
                            //     ShownyPageRoute(
                            //       builder: (context) => ProfileScreen(),
                            //     ));
                          } else {
                            Navigator.push(
                                context,
                                ShownyPageRoute(
                                  builder: (context) => OtherProfileScreen(
                                      memNo: goodsStyleupListModel!
                                          .styleupDataList[index]
                                          .userInfo
                                          .memNo),
                                ));
                          }
                        },
                        child: Row(
                          children: [
                            ProfileContainer.size24(
                              url: goodsStyleupListModel!
                                  .styleupDataList[index].userInfo.profileImage,
                            ),
                            SizedBox(width: 4.toWidth),
                            Text(
                              goodsStyleupListModel!
                                  .styleupDataList[index].userInfo.memNm,
                              style:
                                  ShownyStyle.overline(weight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 10.toWidth),
                      if (goodsStyleupListModel!
                          .styleupDataList[index].description.isNotEmpty) ...{
                        SizedBox(
                          height: 45.toWidth,
                          child: Text(
                              goodsStyleupListModel!
                                  .styleupDataList[index].description,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: ShownyStyle.overline()),
                        ),
                      } else ...{
                        SizedBox(height: 8.toWidth),
                      },
                      Row(
                        children: [
                          Text(
                              "좋아요 ${goodsStyleupListModel!.styleupDataList[index].heartCnt}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: ShownyStyle.overline(
                                  color: Color(0xff777777))),
                          const SizedBox(width: 4),
                          Text(
                              "댓글 ${goodsStyleupListModel!.styleupDataList[index].commentCnt}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: ShownyStyle.overline(
                                  color: Color(0xff777777))),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
