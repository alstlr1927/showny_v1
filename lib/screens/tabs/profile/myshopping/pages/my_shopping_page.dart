import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/tabs/profile/provider/request_return_provider.dart';
import 'package:showny/screens/tabs/profile/provider/get_profile_provider.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';
import 'package:showny/utils/theme.dart';

import '../../../../profile/model/get_myshopping_response_model.dart';

class MyShoppingPage extends StatefulWidget {
  const MyShoppingPage({Key? key}) : super(key: key);

  @override
  State<MyShoppingPage> createState() => _MyShoppingPageState();
}

class _MyShoppingPageState extends State<MyShoppingPage> {
  List shoppingData = [
    tr("my_shopping.shopping_basket"),
    tr("my_shopping.withdraw_order"),
    tr("my_shopping.exchange_return"),
  ];

  @override
  void initState() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    Provider.of<GetProfileProvider>(context, listen: false)
        .getMyShoppingData(user.memNo, "");
    Provider.of<GetProfileProvider>(context, listen: false)
        .getProfileData(user.memNo);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '내 쇼핑',
          style: ShownyStyle.body1(
            color: ShownyStyle.black,
            weight: FontWeight.w600,
          ),
        ),
      ),
      body: Consumer<GetProfileProvider>(
        builder: (context, getProfileProvider, child) => getProfileProvider
                    .getIsShoppingLoading() ||
                getProfileProvider.getIsProfileLoading()
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 200),
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.toWidth),
                  Padding(
                    padding: EdgeInsets.only(left: 16.toWidth),
                    child: Text(
                      user.memId,
                      style: ShownyStyle.body2(
                          color: ShownyStyle.black, weight: FontWeight.w700),
                    ),
                  ),
                  SizedBox(height: 18.toWidth),
                  _buildPointCouponArea(
                      getProfileProvider.getMyShoppingResponseModel!.data!),
                  _buildOrderStateArea(
                      getProfileProvider.getMyShoppingResponseModel!.data!),
                  _divider(),
                  const SizedBox(
                    height: 12,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          getProfileProvider
                                  .getProfileResponseModel!.data!.nickNm ??
                              "",
                          style: FontHelper.bold_12_000000,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          getProfileProvider
                                  .getProfileResponseModel!.data!.introduce ??
                              "",
                          style: FontHelper.regualr_12_000000,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Consumer<RequestReturnProvider>(
                    builder: (context, value, child) => SizedBox(
                      height: 40,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              value.setSelectedIndex(0);
                              log(value.selectedIndex.toString());
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "${shoppingData[0]}",
                                style: 0 == value.selectedIndex
                                    ? themeData()
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontWeight: FontWeight.bold)
                                        .apply(color: black)
                                    : themeData()
                                        .textTheme
                                        .titleSmall!
                                        .apply(color: black),
                              ),
                            ),
                          ),
                          Container(
                              width: 1,
                              height: 12,
                              color: const Color(0xFF444444)),
                          GestureDetector(
                            onTap: () {
                              value.setSelectedIndex(1);
                              log(value.selectedIndex.toString());
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "${shoppingData[1]}",
                                style: 1 == value.selectedIndex
                                    ? themeData()
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontWeight: FontWeight.bold)
                                        .apply(color: black)
                                    : themeData()
                                        .textTheme
                                        .titleSmall!
                                        .apply(color: black),
                              ),
                            ),
                          ),
                          Container(
                              width: 1,
                              height: 12,
                              color: const Color(0xFF444444)),
                          GestureDetector(
                            onTap: () {
                              value.setSelectedIndex(2);
                              log(value.selectedIndex.toString());
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "${shoppingData[2]}",
                                style: 2 == value.selectedIndex
                                    ? themeData()
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontWeight: FontWeight.bold)
                                        .apply(color: black)
                                    : themeData()
                                        .textTheme
                                        .titleSmall!
                                        .apply(color: black),
                              ),
                            ),
                          )
                        ],
                      ),

                      // ListView.builder(
                      //   itemCount: shoppingData.length,
                      //   shrinkWrap: true,
                      //   scrollDirection: Axis.horizontal,
                      //   physics: const NeverScrollableScrollPhysics(),
                      //   itemBuilder: (context, index) {
                      //     return GestureDetector(
                      //       onTap: () {
                      //         value.setSelectedIndex(index);
                      //         log(value.selectedIndex.toString());
                      //       },
                      //       child: Container(
                      //         padding: const EdgeInsets.only(right: 25.0),
                      //         child: Text(
                      //           "${shoppingData[index]}",
                      //           style: index == value.selectedIndex
                      //               ? themeData()
                      //                   .textTheme
                      //                   .titleSmall
                      //                   ?.copyWith(fontWeight: FontWeight.bold)
                      //                   .apply(color: black)
                      //               : themeData()
                      //                   .textTheme
                      //                   .titleSmall!
                      //                   .apply(color: black),
                      //         ),
                      //       ),
                      //     );
                      //   },
                      // ),
                    ),
                  ),
                  (Provider.of<RequestReturnProvider>(context).selectedIndex ==
                          1)
                      ? const SizedBox()
                      : (Provider.of<RequestReturnProvider>(context)
                                  .selectedIndex ==
                              2)
                          ? const SizedBox()
                          : const SizedBox(),
                ],
              ),
      ),
    );
  }

  Widget _buildPointCouponArea(Data myShopping) {
    return Container(
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.fromLTRB(25.toWidth, 10.toWidth, 0, 10.toWidth),
      color: ShownyStyle.mainPurple,
      child: Row(
        children: [
          Column(
            children: [
              SizedBox(
                width: ScreenUtil().screenWidth * .3,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/shopping/point.png',
                      width: 16.toWidth,
                    ),
                    SizedBox(width: 10.toWidth),
                    Text(
                      '포인트',
                      style: ShownyStyle.overline(color: ShownyStyle.white),
                    ),
                    const Spacer(),
                    Text(
                      '${myShopping.point} P',
                      style: ShownyStyle.overline(
                          color: ShownyStyle.white, weight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 8.toWidth),
              SizedBox(
                width: ScreenUtil().screenWidth * .3,
                child: Row(
                  children: [
                    Image.asset(
                      'assets/icons/shopping/coupon.png',
                      width: 16.toWidth,
                    ),
                    SizedBox(width: 10.toWidth),
                    Text(
                      '마이쿠폰',
                      style: ShownyStyle.overline(color: ShownyStyle.white),
                    ),
                    const Spacer(),
                    Text(
                      '${myShopping.couponCnt}',
                      style: ShownyStyle.overline(
                          color: ShownyStyle.white, weight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          CupertinoButton(
            onPressed: () {},
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '자세히 보기',
                  style: ShownyStyle.overline(color: ShownyStyle.white),
                ),
                SizedBox(width: 4.5.toWidth),
                Image.asset(
                  'assets/icons/shopping/right_arrow.png',
                  width: 10.toWidth,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderStateArea(Data myShopping) {
    return Container(
      margin:
          EdgeInsets.symmetric(vertical: 14.toWidth, horizontal: 24.toWidth),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _orderStateItem(
            title: tr("order_list_page.order_list"),
            count: '-',
            icon: 'assets/icons/shopping/order_list.png',
          ),
          _orderStateItem(
            title: tr("my_shopping.payment"),
            count: myShopping.chargeCnt ?? '',
            icon: 'assets/icons/shopping/purchase.png',
          ),
          _orderStateItem(
            title: tr("order_list_page.purchase_confirmation"),
            count: myShopping.confirmedCnt ?? '',
            icon: 'assets/icons/shopping/purchase_confirm.png',
          ),
          _orderStateItem(
            title: '배송중',
            count: myShopping.deliveryCnt ?? '',
            icon: 'assets/icons/shopping/shipping.png',
          ),
        ],
      ),
    );
  }

  Widget _orderStateItem(
      {required String title, required String count, required String icon}) {
    return Container(
      width: 70.toWidth,
      padding: EdgeInsets.symmetric(vertical: 5.toWidth),
      child: Column(
        children: [
          Image.asset(
            icon,
            width: 28.toWidth,
          ),
          Text(
            title,
            style: ShownyStyle.overline(color: ShownyStyle.black),
          ),
          Text(
            count,
            style: ShownyStyle.caption(
                color: ShownyStyle.black, weight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: double.infinity,
      height: 1,
      color: ShownyStyle.gray040,
    );
  }
}
