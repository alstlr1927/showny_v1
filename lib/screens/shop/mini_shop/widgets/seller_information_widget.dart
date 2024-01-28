// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/components/user_profile/profile_container.dart';

import 'package:showny/models/minishop_product_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

import '../../../profile/other_profile_screen.dart';

class SellerInformationWidget extends StatefulWidget {
  final MinishopProductModel minishopProduct;

  const SellerInformationWidget({Key? key, required this.minishopProduct}) : super(key: key);

  @override
  State<SellerInformationWidget> createState() => _SellerInformationWidgetState();
}

class _SellerInformationWidgetState extends State<SellerInformationWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 14.toWidth, bottom: 20.toWidth),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                tr('product_detail.seller_information.headline'),
                style: ShownyStyle.body2(
                  weight: FontWeight.w700,
                  color: ShownyStyle.black,
                ),
              ),
            ),
          ),
          // Row(
          //   children: [
          //     Padding(
          //       padding: const EdgeInsets.symmetric(vertical: 13),
          //       child: GestureDetector(
          //         onTap: () {
          //           if (Provider.of<UserProvider>(context, listen: false).user.memNo == widget.minishopProduct.userInfo!.memNo) {
          //             Navigator.push(
          //                 context,
          //                 ShownyPageRoute(
          //                   builder: (context) => ProfileScreen(),
          //                 ));
          //           } else {
          //             Navigator.push(
          //                 context,
          //                 ShownyPageRoute(
          //                   builder: (context) => OtherProfileScreen(
          //                     memNo: widget.minishopProduct.userInfo!.memNo,
          //                     // initTap: 1,
          //                   ),
          //                 ));
          //           }
          //         },
          //         child: IntrinsicWidth(
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               Stack(
          //                 alignment: Alignment.bottomCenter,
          //                 children: [
          //                   Column(
          //                     children: [
          //                       Container(
          //                         height: 64,
          //                         width: 64.toWidth,
          //                         decoration: BoxDecoration(
          //                           shape: BoxShape.circle,
          //                           image: DecorationImage(
          //                             image: NetworkImage(widget.minishopProduct.userInfo!.profileImage),
          //                             fit: BoxFit.cover,
          //                           ),
          //                         ),
          //                       ),
          //                       SizedBox(height: 7),
          //                     ],
          //                   ),
          //                   Positioned(
          //                     child: Container(
          //                       width: 50.toWidth,
          //                       height: 15,
          //                       constraints: BoxConstraints(maxWidth: 50.toWidth),
          //                       decoration: BoxDecoration(
          //                         borderRadius: BorderRadius.circular(8),
          //                         color: ShownyStyle.mainPurple,
          //                       ),
          //                       child: Center(
          //                         child: Text(
          //                           '인증회원',
          //                           textAlign: TextAlign.center,
          //                           style: ShownyStyle.overline(
          //                             color: ShownyStyle.white,
          //                           ).copyWith(fontSize: 9),
          //                         ),
          //                       ),
          //                     ),
          //                   ),
          //                 ],
          //               ),
          //               SizedBox(
          //                 height: 24,
          //                 child: Align(
          //                   alignment: Alignment.center,
          //                   child: Text(
          //                     widget.minishopProduct.userInfo!.nickNm,
          //                     style: ShownyStyle.body2(
          //                       weight: FontWeight.w700,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ),
          //     Spacer(),

          //     Expanded(
          //       child: Row(
          //         children: [
          //           Expanded(
          //             child: Column(
          //               children: [
          //                 SizedBox(
          //                   width: 64.toWidth,
          //                   height: 24,
          //                   child: Center(
          //                     child: Text(
          //                       tr('product_detail.seller_information.followers_text'),
          //                       style: ShownyStyle.overline(
          //                         color: ShownyStyle.black,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 24,
          //                   child: Center(
          //                     child: Text(
          //                       "752",
          //                       style: ShownyStyle.body2(
          //                         color: ShownyStyle.black,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 24,
          //                   child: Center(
          //                     child: Text(
          //                       tr('product_detail.seller_information.grade_text'),
          //                       style: ShownyStyle.overline(
          //                         color: ShownyStyle.black,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 24,
          //                   child: Center(
          //                     child: Text(
          //                       "5.0",
          //                       style: ShownyStyle.body2(
          //                         color: ShownyStyle.black,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Expanded(
          //             child: Column(
          //               children: [
          //                 SizedBox(
          //                   height: 24,
          //                   child: Center(
          //                     child: Text(
          //                       tr('product_detail.seller_information.following_text'),
          //                       style: ShownyStyle.overline(
          //                         color: ShownyStyle.black,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 24,
          //                   child: Center(
          //                     child: Text(
          //                       "255",
          //                       style: ShownyStyle.body2(
          //                         color: ShownyStyle.black,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 GestureDetector(
          //                   onTap: () {
          //                     Navigator.push(
          //                         context,
          //                         MaterialPageRoute(
          //                           builder: (context) => OtherProfileScreen(memNo: widget.minishopProduct.userInfo!.memNo),
          //                         ));
          //                   },
          //                   child: Column(
          //                     children: [
          //                       SizedBox(
          //                         height: 24,
          //                         child: Center(
          //                           child: Text(
          //                             tr('product_detail.seller_information.review_text'),
          //                             style: ShownyStyle.overline(
          //                               color: ShownyStyle.bl    ack,
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                       SizedBox(
          //                         height: 24,
          //                         child: Center(
          //                           child: Text(
          //                             "18",
          //                             style: ShownyStyle.body2(
          //                               color: ShownyStyle.black,
          //                             ),
          //                           ),
          //                         ),
          //                       ),
          //                     ],
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //           Expanded(
          //             child: Column(
          //               children: [
          //                 SizedBox(
          //                   height: 24,
          //                   child: Center(
          //                     child: Text(
          //                       tr('product_detail.seller_information.sell_count_text'),
          //                       style: ShownyStyle.overline(
          //                         color: ShownyStyle.black,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 24,
          //                   child: Center(
          //                     child: Text(
          //                       "4",
          //                       style: ShownyStyle.body2(
          //                         color: ShownyStyle.black,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 24,
          //                   child: Center(
          //                     child: Text(
          //                       tr('product_detail.seller_information.sales_history_text'),
          //                       style: ShownyStyle.overline(
          //                         color: ShownyStyle.black,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //                 SizedBox(
          //                   height: 24,
          //                   child: Center(
          //                     child: Text(
          //                       "8",
          //                       style: ShownyStyle.body2(
          //                         color: ShownyStyle.black,
          //                       ),
          //                     ),
          //                   ),
          //                 ),
          //               ],
          //             ),
          //           ),
          //         ],
          //       ),
          //     )
          //   ],
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  if (Provider.of<UserProvider>(context, listen: false).user.memNo == widget.minishopProduct.userInfo!.memNo) {
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
                          memNo: widget.minishopProduct.userInfo!.memNo,
                          // initTap: 1,
                        ),
                      ),
                    );
                  }
                },
                child: _buildUserProfile(),
              ),
              Column(
                children: [
                  UserInfoCellWrap(
                    list: [
                      // 팔로워
                      UserInfoCell(
                        titleText: tr('product_detail.seller_information.followers_text'),
                        valueText: '752',
                      ),
                      // 팔로잉
                      UserInfoCell(
                        titleText: tr('product_detail.seller_information.following_text'),
                        valueText: '255',
                      ),
                      // 판매중
                      UserInfoCell(
                        titleText: tr('product_detail.seller_information.sell_count_text'),
                        valueText: '4',
                      ),
                    ],
                  ),
                  UserInfoCellWrap(
                    list: [
                      // 평점
                      UserInfoCell(
                        titleText: tr('product_detail.seller_information.grade_text'),
                        valueText: '5.0',
                      ),
                      // 후기
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OtherProfileScreen(memNo: widget.minishopProduct.userInfo!.memNo),
                            ),
                          );
                        },
                        child: UserInfoCell(
                          titleText: tr('product_detail.seller_information.review_text'),
                          valueText: '18',
                        ),
                      ),
                      // 판매내역
                      UserInfoCell(
                        titleText: tr('product_detail.seller_information.sales_history_text'),
                        valueText: '8',
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }

  IntrinsicWidth _buildUserProfile() {
    return IntrinsicWidth(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  ProfileContainer.size64(
                    url: widget.minishopProduct.userInfo!.profileImage,
                  ),
                  SizedBox(height: 7),
                ],
              ),
              Positioned(
                child: Container(
                  width: 50.toWidth,
                  height: 15,
                  constraints: BoxConstraints(maxWidth: 50.toWidth),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ShownyStyle.mainPurple,
                  ),
                  child: Center(
                    child: Text(
                      '인증회원',
                      textAlign: TextAlign.center,
                      style: ShownyStyle.overline(
                        color: ShownyStyle.white,
                      ).copyWith(fontSize: 9),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 24,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                widget.minishopProduct.userInfo!.nickNm,
                style: ShownyStyle.body2(
                  weight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class UserInfoCellWrap extends StatelessWidget {
  final List<Widget> list;
  const UserInfoCellWrap({
    Key? key,
    required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: list,
    );
  }
}

class UserInfoCell extends StatelessWidget {
  final String titleText;
  final String valueText;

  const UserInfoCell({
    super.key,
    required this.titleText,
    required this.valueText,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 64.toWidth,
          height: 24,
          child: Center(
            child: Text(
              titleText,
              style: ShownyStyle.overline(
                color: ShownyStyle.black,
              ),
            ),
          ),
        ),
        SizedBox(
          width: 64.toWidth,
          height: 24,
          child: Center(
            child: Text(
              valueText,
              style: ShownyStyle.body2(
                color: ShownyStyle.black,
                weight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
