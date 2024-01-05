import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/tabs/profile/myshopping/pages/product_list_widget.dart';
import 'package:showny/screens/tabs/profile/provider/request_return_provider.dart';
import 'package:showny/screens/tabs/profile/provider/get_profile_provider.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/theme.dart';

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
          user.memId,
          style: ShownyStyle.body1(
            color: ShownyStyle.black,
            weight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Consumer<GetProfileProvider>(
          builder: (context, getProfileProvider, child) =>
              getProfileProvider.getIsShoppingLoading() ||
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
                        const SizedBox(height: 22),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          height: 110,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      "${getProfileProvider.getProfileResponseModel!.data!.profileImage}"),
                                  radius: 44,
                                ),
                              ),
                              const SizedBox(
                                width: 24,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          getProfileProvider
                                                  .getMyShoppingResponseModel!
                                                  .data![0]
                                                  .chargeCnt ??
                                              "0",
                                          style: FontHelper.light_14_000000,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          tr("my_shopping.payment"),
                                          style: FontHelper.regualr_12_000000,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          getProfileProvider
                                                  .getMyShoppingResponseModel!
                                                  .data![0]
                                                  .point ??
                                              "0",
                                          style: FontHelper.light_14_000000,
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          tr("my_shopping.point"),
                                          style: FontHelper.regualr_12_000000,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //     context,
                                      //     PageRouteBuilderRightLeft(
                                      //         child: OrderListScreen()));
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Text(
                                            getProfileProvider
                                                    .getMyShoppingResponseModel!
                                                    .data![0]
                                                    .deliveryCnt ??
                                                "",
                                            style: FontHelper.light_14_000000,
                                          ),
                                          const SizedBox(
                                            height: 8,
                                          ),
                                          Text(
                                            tr("my_shopping.delivery_progress"),
                                            style: FontHelper.regualr_12_000000,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        getProfileProvider
                                                .getMyShoppingResponseModel!
                                                .data![0]
                                                .couponCnt ??
                                            "",
                                        style: FontHelper.light_14_000000,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        tr("my_shopping.coupen"),
                                        style: FontHelper.regualr_12_000000,
                                      ),
                                    ],
                                  ),
                                ],
                              )),
                              Expanded(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                        getProfileProvider
                                                .getMyShoppingResponseModel!
                                                .data![0]
                                                .confirmedCnt ??
                                            "0",
                                        style: FontHelper.light_14_000000,
                                      ),
                                      const SizedBox(
                                        height: 8,
                                      ),
                                      Text(
                                        tr("my_shopping.purchase_conformation"),
                                        style: FontHelper.regualr_12_000000,
                                      ),
                                      const SizedBox(
                                        height: 12,
                                      ),
                                      const Text(""),
                                      const SizedBox(
                                        height: 0,
                                      ),
                                      Text(tr("")),
                                    ],
                                  ),
                                ],
                              )),
                              const SizedBox(
                                width: 16,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                getProfileProvider.getProfileResponseModel!
                                        .data!.nickNm ??
                                    "",
                                style: FontHelper.bold_12_000000,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                getProfileProvider.getProfileResponseModel!
                                        .data!.introduce ??
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        "${shoppingData[0]}",
                                        style: 0 == value.selectedIndex
                                            ? themeData()
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(
                                                    fontWeight: FontWeight.bold)
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        "${shoppingData[1]}",
                                        style: 1 == value.selectedIndex
                                            ? themeData()
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(
                                                    fontWeight: FontWeight.bold)
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
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        "${shoppingData[2]}",
                                        style: 2 == value.selectedIndex
                                            ? themeData()
                                                .textTheme
                                                .titleSmall
                                                ?.copyWith(
                                                    fontWeight: FontWeight.bold)
                                                .apply(color: black)
                                            : themeData()
                                                .textTheme
                                                .titleSmall!
                                                .apply(color: black),
                                      ),
                                    ),
                                  )
                                ],
                              )

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
                        (Provider.of<RequestReturnProvider>(context)
                                    .selectedIndex ==
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
      ),
    );
  }
}
