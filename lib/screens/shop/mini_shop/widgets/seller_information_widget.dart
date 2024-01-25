import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/models/minishop_product_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/utils/theme.dart';

import '../../../profile/other_profile_screen.dart';
import '../../../profile/profile_screen.dart';

class SellerInformationWidget extends StatefulWidget {
  final MinishopProductModel minishopProduct;

  const SellerInformationWidget({Key? key, required this.minishopProduct})
      : super(key: key);

  @override
  State<SellerInformationWidget> createState() =>
      _SellerInformationWidgetState();
}

class _SellerInformationWidgetState extends State<SellerInformationWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: size.width,
            height: 32,
            child: Text(
              tr('product_detail.seller_information.headline'),
              style: themeData().textTheme.titleMedium,
            ),
          ),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: GestureDetector(
                    onTap: () {
                      if (Provider.of<UserProvider>(context, listen: false)
                              .user
                              .memNo ==
                          widget.minishopProduct.userInfo!.memNo) {
                        Navigator.push(
                            context,
                            ShownyPageRoute(
                              builder: (context) => ProfileScreen(),
                            ));
                      } else {
                        Navigator.push(
                            context,
                            ShownyPageRoute(
                              builder: (context) => OtherProfileScreen(
                                memNo: widget.minishopProduct.userInfo!.memNo,
                                // initTap: 1,
                              ),
                            ));
                      }
                    },
                    child: Row(
                      children: [
                        Container(
                          height: 64,
                          width: 64,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: NetworkImage(widget
                                      .minishopProduct.userInfo!.profileImage),
                                  fit: BoxFit.cover)),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 32,
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                widget.minishopProduct.userInfo!.nickNm,
                                style: themeData().textTheme.titleMedium,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 24,
                            child: Center(
                                child: Text(
                              tr('product_detail.seller_information.followers_text'),
                              style: themeData().textTheme.labelSmall,
                            )),
                          ),
                          SizedBox(
                            height: 24,
                            child: Center(
                                child: Text("0",
                                    style:
                                        themeData().textTheme.displayMedium)),
                          ),
                          SizedBox(
                            height: 24,
                            child: Center(
                                child: Text(
                              tr('product_detail.seller_information.grade_text'),
                              style: themeData().textTheme.labelSmall,
                            )),
                          ),
                          SizedBox(
                            height: 24,
                            child: Center(
                                child: Text("0",
                                    style:
                                        themeData().textTheme.displayMedium)),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                              height: 24,
                              child: Center(
                                  child: Text(
                                tr('product_detail.seller_information.following_text'),
                                style: themeData().textTheme.labelSmall,
                              ))),
                          SizedBox(
                              height: 24,
                              child: Center(
                                  child: Text("0",
                                      style: themeData()
                                          .textTheme
                                          .displayMedium))),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OtherProfileScreen(
                                        memNo: widget
                                            .minishopProduct.userInfo!.memNo),
                                  ));
                            },
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 24,
                                  child: Center(
                                    child: Text(
                                      tr('product_detail.seller_information.review_text'),
                                      style: themeData().textTheme.labelSmall,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 24,
                                  child: Center(
                                      child: Text("0",
                                          style: themeData()
                                              .textTheme
                                              .displayMedium)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 24,
                            child: Center(
                                child: Text(
                              tr('product_detail.seller_information.verification_text'),
                              style: themeData().textTheme.labelSmall,
                            )),
                          ),
                          SizedBox(
                            height: 24,
                            child: Center(
                                child: Text("OK",
                                    style:
                                        themeData().textTheme.displayMedium)),
                          ),
                          SizedBox(
                            height: 24,
                            child: Center(
                                child: Text(
                              tr('product_detail.seller_information.sales_history_text'),
                              style: themeData().textTheme.labelSmall,
                            )),
                          ),
                          SizedBox(
                            height: 24,
                            child: Center(
                                child: Text("0",
                                    style:
                                        themeData().textTheme.displayMedium)),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 42)
        ],
      ),
    );
  }
}
