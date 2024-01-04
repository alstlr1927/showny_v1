import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/common/components/page_route_builder_right_left.dart';
import 'package:showny/screens/tabs/profile/my_shop/provider/report_provider.dart';
import 'package:showny/utils/images.dart';

import '../../../../providers/FetchGetMemberMinishopProductProvider.dart';
import '../../../../utils/colors.dart';
import '../../../../utils/theme.dart';
import '../../../../widgets/common_button_widget.dart';
import '../profile_tab_button.dart';
import 'components/my_shop_grid_item.dart';
import 'package:provider/provider.dart';

class MyShopScreen extends StatefulWidget {
  const MyShopScreen({
    super.key,
  });

  @override
  State<MyShopScreen> createState() => _MyShopScreenState();
}

class _MyShopScreenState extends State<MyShopScreen> {
  @override
  void initState() {
    Provider.of<ReportProvider>(context, listen: false)
        .getStoreCartListData(context);
    Provider.of<FetchGetMemberMinishopProductProvider>(context, listen: false)
        .getStoreCartListData(context);
    super.initState();
  }

  MyShopPageCategory category = MyShopPageCategory.all;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 22),
            Container(
              height: 110,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(user.profileImage),
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
                              "0",
                              style: FontHelper.light_14_000000,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "판매상품",
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
                              "0",
                              style: FontHelper.light_14_000000,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "평점",
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
                            //           context,
                            //           PageRouteBuilderRightLeft(
                            //               child: OrderListScreen()));
                          },
                          child: Container(
                            child: Column(
                              children: [
                                Text(
                                  "0",
                                  style: FontHelper.light_14_000000,
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "판매내역",
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
                              "OK",
                              style: FontHelper.light_14_000000,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "본인인증",
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
                      Column(
                        children: [
                          Text(
                            "0",
                            style: FontHelper.light_14_000000,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            "후기",
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
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.nickNm,
                    style: FontHelper.bold_12_000000,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user.introduce,
                    style: FontHelper.regualr_12_000000,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Row(
                children: [
                  ProfieTabButton<MyShopPageCategory>(
                      onTap: () {
                        setState(() {
                          category = MyShopPageCategory.all;
                          Provider.of<FetchGetMemberMinishopProductProvider>(
                                  context,
                                  listen: false)
                              .updateStatus(2, context);
                        });
                      },
                      category: MyShopPageCategory.all,
                      currentCategory: category),
                  Container(
                      width: 1, height: 12, color: const Color(0xFF444444)),
                  ProfieTabButton<MyShopPageCategory>(
                      onTap: () {
                        setState(() {
                          category = MyShopPageCategory.onSale;
                          Provider.of<FetchGetMemberMinishopProductProvider>(
                                  context,
                                  listen: false)
                              .updateStatus(0, context);
                        });
                      },
                      category: MyShopPageCategory.onSale,
                      currentCategory: category),
                  Container(
                      width: 1, height: 12, color: const Color(0xFF444444)),
                  ProfieTabButton<MyShopPageCategory>(
                      onTap: () {
                        setState(() {
                          category = MyShopPageCategory.soldOut;
                          Provider.of<FetchGetMemberMinishopProductProvider>(
                                  context,
                                  listen: false)
                              .updateStatus(1, context);
                        });
                      },
                      category: MyShopPageCategory.soldOut,
                      currentCategory: category),
                  Container(
                      width: 1, height: 12, color: const Color(0xFF444444)),
                  ProfieTabButton<MyShopPageCategory>(
                      onTap: () {
                        setState(() {
                          category = MyShopPageCategory.review;
                        });
                      },
                      category: MyShopPageCategory.review,
                      currentCategory: category),
                ],
              ),
            ),
            const SizedBox(height: 25),
            pageAtCategory(MediaQuery.of(context).size),
          ],
        ));
  }

  Widget pageAtCategory(Size size) {
    switch (category) {
      case MyShopPageCategory.all:
        return Consumer<FetchGetMemberMinishopProductProvider>(
          builder: (context, value, child) {
            return value.getIsStoreCartLoading()
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : value.fetchGetMemberMinishopProductModel!.data!.isEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                            child:
                                // ShopingEmptyBasketWidget()
                                SizedBox()))
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value
                            .fetchGetMemberMinishopProductModel!.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 1,
                          crossAxisCount: 3,
                          childAspectRatio: (size.width / 3) /
                              (((size.width / 3) * 5 / 4) + 100),
                        ),
                        itemBuilder: (context, index) {
                          return MyShopGridItem(
                            brandName:
                                "${value.fetchGetMemberMinishopProductModel!.data![index].brand}",
                            title:
                                "${value.fetchGetMemberMinishopProductModel!.data![index].name}",
                            price:
                                "${value.fetchGetMemberMinishopProductModel!.data![index].price}",
                            imageUrl:
                                "${value.fetchGetMemberMinishopProductModel!.data![index].productImageUrlList![0]}",
                            onTap: () {
                              String productId = value
                                      .fetchGetMemberMinishopProductModel!
                                      .data![index]
                                      .id ??
                                  "";
                              if (productId == "") {
                                return;
                              }
                              // Navigator.push(
                              //   context,
                              //   PageRouteBuilderRightLeft(
                              //       child: ProductDetailScreen(productId: productId)));
                            },
                          );
                        },
                      );
          },
        );
      case MyShopPageCategory.onSale:
        return Consumer<FetchGetMemberMinishopProductProvider>(
          builder: (context, value, child) {
            return value.getIsStoreCartLoading()
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : value.fetchGetMemberMinishopProductModel!.data!.isEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                            child:
                                // ShopingEmptyBasketWidget()
                                SizedBox()))
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value
                            .fetchGetMemberMinishopProductModel!.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 1,
                          crossAxisCount: 3,
                          childAspectRatio: (size.width / 3) /
                              (((size.width / 3) * 5 / 4) + 100),
                        ),
                        itemBuilder: (context, index) {
                          return MyShopGridItem(
                            brandName:
                                "${value.fetchGetMemberMinishopProductModel!.data![index].brand}",
                            title:
                                "${value.fetchGetMemberMinishopProductModel!.data![index].name}",
                            price:
                                "${value.fetchGetMemberMinishopProductModel!.data![index].price}",
                            imageUrl:
                                "${value.fetchGetMemberMinishopProductModel!.data![index].productImageUrlList![0]}",
                            onTap: () {
                              String productId = value
                                      .fetchGetMemberMinishopProductModel!
                                      .data![index]
                                      .id ??
                                  "";
                              if (productId == "") {
                                return;
                              }

                              // Navigator.push(
                              //   context,
                              //   PageRouteBuilderRightLeft(
                              //       child: ProductDetailScreen(productId: productId)));
                            },
                          );
                        },
                      );
          },
        );
      case MyShopPageCategory.soldOut:
        return Consumer<FetchGetMemberMinishopProductProvider>(
          builder: (context, value, child) {
            return value.getIsStoreCartLoading()
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : value.fetchGetMemberMinishopProductModel!.data!.isEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * 0.5,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                            child:
                                // ShopingEmptyBasketWidget()
                                SizedBox()))
                    : GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: value
                            .fetchGetMemberMinishopProductModel!.data!.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          mainAxisSpacing: 1,
                          crossAxisCount: 3,
                          childAspectRatio: (size.width / 3) /
                              (((size.width / 3) * 5 / 4) + 100),
                        ),
                        itemBuilder: (context, index) {
                          return MyShopGridItem(
                            brandName:
                                "${value.fetchGetMemberMinishopProductModel!.data![index].brand}",
                            title:
                                "${value.fetchGetMemberMinishopProductModel!.data![index].name}",
                            price:
                                "${value.fetchGetMemberMinishopProductModel!.data![index].price}",
                            imageUrl:
                                "${value.fetchGetMemberMinishopProductModel!.data![index].productImageUrlList![0]}",
                            onTap: () {
                              String productId = value
                                      .fetchGetMemberMinishopProductModel!
                                      .data![index]
                                      .id ??
                                  "";
                              if (productId == "") {
                                return;
                              }

                              // Navigator.push(
                              //   context,
                              //   PageRouteBuilderRightLeft(
                              //       child: ProductDetailScreen(productId: productId)));
                            },
                          );
                        },
                      );
          },
        );
      case MyShopPageCategory.review:
        return Column(
          children: [
            // Container(
            //   color: Colors.black,
            //   height: 28,
            //   width: double.infinity,
            //   child: const Center(
            //     child: Text(
            //       '거래후기 8건',
            //       textAlign: TextAlign.center,
            //       style: TextStyle(
            //         color: Colors.white,
            //         fontSize: 12,
            //         fontFamily: 'pretendard',
            //         fontWeight: FontWeight.w700,
            //       ),
            //     ),
            //   ),
            // ),
            // const SizedBox(height: 16),
            //
            Consumer<ReportProvider>(
              builder: (context, reportProvider, child) {
                return reportProvider.getIsStoreCartLoading()
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        itemCount: reportProvider
                            .memberMinishopProductReviewModel!.data!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.network(
                                      "${reportProvider.memberMinishopProductReviewModel!.data![index].minishopProduct!.brandImageUrl}",
                                      errorBuilder:
                                          (context, error, stackTrace) =>
                                              Image.asset(splash),
                                      width: 64,
                                      height: 64,
                                      fit: BoxFit.cover,
                                    ),
                                    const SizedBox(
                                      width: 10.0,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${reportProvider.memberMinishopProductReviewModel!.data![index].minishopProduct!.brand}",
                                          style: const TextStyle(
                                              color: textColor, fontSize: 12),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "${reportProvider.memberMinishopProductReviewModel!.data![index].minishopProduct!.name}",
                                          style: const TextStyle(
                                              color: black, fontSize: 12),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          "${reportProvider.memberMinishopProductReviewModel!.data![index].minishopProduct!.price} 원",
                                          style: const TextStyle(
                                              color: textColor, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                    const Spacer(),
                                    GestureDetector(
                                      onTap: () {
                                        _showBottomSheet(context);
                                      },
                                      child: Container(
                                          height: size.height * 0.1,
                                          alignment: Alignment.topRight,
                                          child: const Icon(Icons.more_vert)),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.star,
                                      color: textColor,
                                      size: 20,
                                    ),
                                    SizedBox(
                                      width: size.width * 0.01,
                                    ),
                                    Text(
                                      "${reportProvider.memberMinishopProductReviewModel!.data![index].grade}",
                                      style: const TextStyle(
                                          fontSize: 14, color: textColor),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${reportProvider.memberMinishopProductReviewModel!.data![index].content}",
                                  style: const TextStyle(
                                      fontSize: 12, color: black),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${reportProvider.memberMinishopProductReviewModel!.data![index].reviewer!.nickNm} • ${reportProvider.memberMinishopProductReviewModel!.data![index].createdAt!.split(" ")[0]}",
                                  style: const TextStyle(
                                      fontSize: 10, color: textColor),
                                ),
                              ],
                            ),
                          );
                        },
                      );
              },
            ),
          ],
        );
    }
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext bc) {
        return Container(
          height: 400,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
            ),
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 8.0, vertical: 40),
              child: Consumer<ReportProvider>(
                builder: (context, reportProvider, child) => Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                tr("review_screen_bottom.report"),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                tr("review_screen_bottom.select_reason_for_report"),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 60, right: 5),
                          child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Icon(Icons.close)),
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: reportProvider
                          .memberMinishopProductSheetModel!.data!.length,
                      itemBuilder: (context, index) {
                        return Row(
                          children: [
                            Radio(
                              activeColor: black,
                              value: reportProvider
                                  .memberMinishopProductSheetModel!
                                  .data![index]
                                  .reportTypeNo,
                              onChanged: (value) {
                                if (value != null) {
                                  reportProvider.setSelectedValue(value);
                                }
                              },
                              groupValue: reportProvider.selectedValue,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                    ("${reportProvider.memberMinishopProductSheetModel!.data![index].title}"),
                                    style: themeData().textTheme.titleMedium),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  "${reportProvider.memberMinishopProductSheetModel!.data![index].description}",
                                  style: themeData()
                                      .textTheme
                                      .titleMedium!
                                      .apply(color: textColor),
                                ),
                              ],
                            )
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CommonButtonWidget(
                      text: "신고",
                      radius: 12,
                      height: 48,
                      color: black,
                      textcolor: white,
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

enum MyShopPageCategory with CategoryMixin {
  all,
  onSale,
  soldOut,
  review;

  @override
  String get name {
    switch (this) {
      case MyShopPageCategory.all:
        return "전체";
      case MyShopPageCategory.onSale:
        return "판매중";
      case MyShopPageCategory.soldOut:
        return "판매완료";
      case MyShopPageCategory.review:
        return "후기";
    }
  }
}
