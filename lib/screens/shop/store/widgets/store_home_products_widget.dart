import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/theme.dart';
import 'package:showny/widgets/shoping_emptyBasket_widget.dart';

import '../../helper/store_helper.dart';
import '../providers/store_provider.dart';
import '../store_good_detail_screen.dart';

class StoreHomeProductsWidget extends StatefulWidget {
  const StoreHomeProductsWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<StoreHomeProductsWidget> createState() =>
      _StoreHomeProductsWidgetState();
}

class _StoreHomeProductsWidgetState extends State<StoreHomeProductsWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: SizedBox(
              height: 24,
              child: Text(
                tr('store.home_title'),
                style: themeData().textTheme.titleMedium,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              tr('store.home_desc'),
              style: themeData().textTheme.labelSmall?.apply(color: textColor),
            ),
          ),
          const SizedBox(height: 24),
          Consumer<StoreProvider>(
            builder: (context, provider, child) => provider
                    .getIsStoreMainDataLoading()
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : provider.getBattleInGoods().isEmpty
                    ? Center(
                        child: ShoppingEmptyBasketWidget(
                            emptyMessage: tr('empty_errors.no_data_found')))
                    : Stack(
                        children: [
                          GridView.builder(
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 2,
                              childAspectRatio: (size.width / 3 * (5 / 4)) /
                                  ((size.width / 3 * (5 / 4)) + 190),
                            ),
                            itemCount:
                                // _gridProductImages.length,
                                provider.getBattleInGoods().length,
                            itemBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                width: size.width / 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: size.width / 3 * (5 / 4),
                                      width: size.width,
                                      child: ClipRect(
                                        child: FittedBox(
                                            fit: BoxFit.cover,
                                            child: GestureDetector(
                                              onTap: () async {
                                                String goodsNo = provider
                                                    .getBattleInGoods()[index]
                                                    .goodsNo;
                                                if (goodsNo == "") {
                                                  return;
                                                }
                                                await Navigator.push(
                                                    context,
                                                    ShownyPageRoute(
                                                      builder: (context) =>
                                                          StoreGoodDetailScreen(
                                                        goodsNo: provider
                                                            .getBattleInGoods()[
                                                                index]
                                                            .goodsNo,
                                                      ),
                                                    ));
                                                setState(() {});
                                              },
                                              child: Image.network(
                                                  // _gridProductImages[index],
                                                  provider
                                                      .getBattleInGoods()[index]
                                                      .goodsImageUrlList[0],
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                return Container(
                                                  color: Colors.white,
                                                );
                                              }),
                                            )),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                    // _gridProductCategory[index],
                                                    provider
                                                        .getBattleInGoods()[
                                                            index]
                                                        .brandNm,
                                                    style: themeData()
                                                        .textTheme
                                                        .labelMedium
                                                        ?.copyWith(
                                                          color: greyLight,
                                                        )),
                                                GestureDetector(
                                                  onTap: () {
                                                    UserProvider userProvider =
                                                        Provider.of<
                                                                UserProvider>(
                                                            context,
                                                            listen: false);
                                                    final user =
                                                        userProvider.user;
                                                    StoreHelper.setHeartClick(
                                                        context,
                                                        user.memNo,
                                                        provider.getBattleInGoods()[
                                                            index]);
                                                  },
                                                  child: (provider
                                                          .getBattleInGoods()[
                                                              index]
                                                          .isHeart)
                                                      ? Image.asset(
                                                          heartSelectedIcon,
                                                          height: 20,
                                                          width: 20,
                                                        )
                                                      : Image.asset(
                                                          unselectedHeartIcon,
                                                          height: 20,
                                                          width: 20,
                                                        ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                                // _gridProdcutTitle[index],
                                                provider
                                                    .getBattleInGoods()[index]
                                                    .goodsNm,
                                                style: themeData()
                                                    .textTheme
                                                    .bodySmall,
                                                maxLines: 2,
                                                overflow:
                                                    TextOverflow.ellipsis),
                                            const SizedBox(
                                              height: 12,
                                            ),
                                            Text(
                                                // _gridProductPrice[index],
                                                "${provider.getBattleInGoods()[index].goodsPrice.formatPrice()} 원",
                                                style: themeData()
                                                    .textTheme
                                                    .titleSmall),
                                          ],
                                        )),
                                  ],
                                ),
                              );
                            },
                          ),
                          const Positioned.fill(child: SizedBox())
                        ],
                      ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
