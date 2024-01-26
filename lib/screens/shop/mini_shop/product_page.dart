import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/models/minishop_product_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/widgets/common_appbar_widget.dart';
import 'package:showny/widgets/common_button_widget.dart';

import '../../../api/new_api/api_helper.dart';
import 'widgets/product_catalogue.dart';
import 'widgets/product_details_widget.dart';
import 'widgets/product_feed_widget.dart';
import 'widgets/product_image_slider_widget.dart';
import 'widgets/seller_information_widget.dart';

class ProductDetailScreen extends StatefulWidget {
  final String productId;

  const ProductDetailScreen({Key? key, required this.productId}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool isHeartFilled = true;

  MinishopProductModel? minishopProduct;

  @override
  void initState() {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

    ApiHelper.shared.getMinishopProductById(userProvider.user.memNo, widget.productId, (minishopProduct) {
      setState(() {
        this.minishopProduct = minishopProduct;
      });
    }, (error) {});

    ApiHelper.shared.viewMinishopProduct(userProvider.user.memNo, widget.productId, (success) {}, (p0) {});

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: white,
      appBar: RoundedAppBar(
        bgColor: white,
        action: [
          Expanded(
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Image.asset(
                      arrowBackward,
                      height: 20,
                      width: 20,
                      color: Colors.black,
                    ),
                  ),
                ),
                const Spacer(),
                CupertinoButton(
                  minSize: 0,
                  padding: const EdgeInsets.all(16),
                  child: Image.asset(shareIcon),
                  onPressed: () {
                    Share.share('https://www.instagram.com/outfitbattles_korea/');
                  },
                ),
              ],
            ),
          )
        ],
        shadow: 0,
      ),
      body: SafeArea(
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            SizedBox(
              child: minishopProduct == null
                  ? const SizedBox()
                  : SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: size.width,
                            color: greyExtraLight,
                            child: ProductImageSliderWidget(imageList: minishopProduct!.productImageUrlList),
                          ),
                          // 상품 정보
                          ProductDetailsWidget(
                            minishopProduct: minishopProduct!,
                          ),
                          const Divider(
                            thickness: 8,
                            color: divider,
                          ),
                          // 판매자 정보
                          SellerInformationWidget(
                            minishopProduct: minishopProduct!,
                          ),
                          const Divider(
                            thickness: 8,
                            height: 8,
                            color: divider,
                          ),
                          // 판매중인 상품
                          ProductCatalogueWidget(minishopProduct: minishopProduct!),
                          const SizedBox(height: 24),
                          const Divider(
                            thickness: 8,
                            height: 8,
                            color: divider,
                          ),
                          ProductFeedWidget(minishopProduct: minishopProduct!),
                          const SizedBox(
                            height: 56,
                          ),
                        ],
                      ),
                    ),
            ),
            Container(
              color: Colors.white,
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            UserProvider userProvider = Provider.of<UserProvider>(context, listen: false);
                            ApiHelper.shared.heartMinishopProduct(userProvider.user.memNo, minishopProduct!.id, !minishopProduct!.isHeart, (success) {}, (error) {});
                            setState(() {
                              minishopProduct!.isHeart = !minishopProduct!.isHeart;
                            });
                          },
                          // child: Padding(
                          //   padding: const EdgeInsets.all(4),
                          //   child: Icon(
                          //     minishopProduct?.isHeart == true ? Icons.favorite : Icons.favorite_border,
                          //     color: minishopProduct?.isHeart == true ? ShownyStyle.mainRed : ShownyStyle.black,
                          //     size: 24,
                          //   ),
                          // ),
                          child: Image.asset(
                            minishopProduct?.isHeart == true ? heartSelected : heartUnselected,
                            width: 22,
                            gaplessPlayback: true,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          minishopProduct?.isHeart == true ? '1' : '0',
                          style: FontHelper.regular_10_000000,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 17,
                  ),
                  Expanded(
                    child: CommonButtonWidget2(
                      onTap: () {
                        if (minishopProduct?.status == 0) {
                          if (minishopProduct?.memNo != userProvider.user.memNo) {
                            // context
                            //     .read<ChatStyleProvider>()
                            //     .connectToServer(
                            //         myUserId: userProvider.user.memNo,
                            //         otherUserId: minishopProduct!.memNo,
                            //         minishopProduct: minishopProduct,
                            //         success: () {
                            //           Navigator.push(
                            //               context,
                            //               MaterialPageRoute(
                            //                 builder: (context) =>
                            //                     ChatDetailScreen(
                            //                         otherUser:
                            //                             minishopProduct!
                            //                                 .userInfo!,
                            //                         minishopProduct:
                            //                             minishopProduct!),
                            //               )).then((value) {
                            //             Provider.of<ChatStyleProvider>(
                            //                     context,
                            //                     listen: false)
                            //                 .disposeMessageCollection();
                            //             Provider.of<ChatStyleProvider>(
                            //                     context,
                            //                     listen: false)
                            //                 .channel = null;
                            //             Provider.of<ChatStyleProvider>(
                            //                     context,
                            //                     listen: false)
                            //                 .getSalesTalkList();
                            //             Provider.of<ChatStyleProvider>(
                            //                     context,
                            //                     listen: false)
                            //                 .getStyleTalkList();
                            //           });
                            //         },
                            //         errorCode: (errorCode) {
                            //           if (errorCode == "400701") {
                            //             showDialog(
                            //               context: context,
                            //               builder: (BuildContext context) {
                            //                 return ShownyDialog(
                            //                   message: "차단한 유저의 상품입니다.",
                            //                   primaryLabel:
                            //                       tr("common.confirm"),
                            //                 );
                            //               },
                            //             );
                            //           }
                            //         });
                          } else {
                            ApiHelper.shared.updateMinishopProductStatus(userProvider.user.memNo, minishopProduct?.id, "1", (success) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return ShownyDialog(
                                    message: "판매완료로 변경되었습니다.",
                                    primaryLabel: tr("common.confirm"),
                                  );
                                },
                              );
                              setState(() {
                                minishopProduct?.status = 1;
                              });
                            }, (error) {});
                          }
                        } else {}
                      },
                      color: minishopProduct?.status == 0 ? ShownyStyle.mainPurple : const Color(0xFFEEEEEE),
                      text: minishopProduct?.status == 0
                          ? minishopProduct?.memNo != userProvider.user.memNo
                              ? '구매하기'
                              : '판매완료로 변경'
                          : minishopProduct?.status == 1
                              ? '판매완료'
                              : '',
                      textcolor: minishopProduct?.status == 0 ? white : const Color(0xFF555555),
                      radius: 8,
                      height: 48,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
