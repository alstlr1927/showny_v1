import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/theme.dart';

import '../providers/store_wishlist_provider.dart';
import '../store_good_detail_screen.dart';

class WishListComponent extends StatefulWidget {
  const WishListComponent({super.key});

  @override
  State<WishListComponent> createState() => _WishListComponentState();
}

class _WishListComponentState extends State<WishListComponent> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SizedBox(
            height: 24,
            child: Text(
              tr("store.wishlist_tab.wishlist"),
              style: themeData().textTheme.titleMedium,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            tr("store.wishlist_tab.fav_products"),
            style: themeData().textTheme.labelSmall,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        Consumer<StoreWishListProvider>(
          builder: (context, value, child) {
            return value.getIsStoreWishListLoading()
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: value.storeGoodsWishList.length,
                    // value.storeMainListResponseModel!.data.homeList.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: ((size.width - 48) / 2) /
                            (((size.width - 48) / 2) + 152)),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 24),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              ShownyPageRoute(
                                builder: (context) => StoreGoodDetailScreen(
                                  goodsNo:
                                      value.storeGoodsWishList[index].goodsNo,
                                ),
                              ));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: (size.width - 48) / 2,
                              height: (size.width - 48) / 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  value.storeGoodsWishList[index]
                                      .goodsImageUrlList[0],
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Container(
                                      color: Colors.white,
                                    );
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              value.storeGoodsWishList[index].brandNm,
                              style: ShownyStyle.caption(),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              value.storeGoodsWishList[index].goodsNm,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: ShownyStyle.caption(),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              "${value.storeGoodsWishList[index].goodsPrice.formatPrice()} 원",
                              style: FontHelper.bold_14_000000,
                            ),
                            const SizedBox(
                              height: 6,
                            ),
                            Text(
                              "즉시 구매가",
                              style: ShownyStyle.caption(),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                GestureDetector(
                                    onTap: () {
                                      // value.updateHeartStatus(!value.isTrue[index], index);
                                      // value.getGoodsHeart(
                                      //     myMemNo,
                                      //     "${value.getStoreMainPageData()!.data!.homeList![index].goodsNo}");
                                    },
                                    child:
                                        // value.isTrue[index] == true ?
                                        Image.asset(
                                      heartSelectedIcon,
                                      height: 16,
                                      width: 16,
                                    )
                                    //     : const Icon(
                                    //   Icons.favorite_border,
                                    //   color: black,
                                    // ),
                                    ),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "${value.storeGoodsWishList[index].heartCount}",
                                  style: themeData()
                                      .textTheme
                                      .bodySmall!
                                      .apply(color: textColor),
                                ),
                                const SizedBox(
                                  width: 8,
                                ),
                                Image.asset(heartReport),
                                const SizedBox(
                                  width: 4,
                                ),
                                Text(
                                  "${value.storeGoodsWishList[index].reviewCount}",
                                  style: themeData()
                                      .textTheme
                                      .bodySmall!
                                      .apply(color: textColor),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ),
      ],
    );
  }
}
