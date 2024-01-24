import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/slivers/sliver_tween.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

import '../../../../components/page_route.dart';
import '../../../../models/store_good_model.dart';
import '../../../../utils/images.dart';
import '../providers/store_wishlist_provider.dart';
import '../store_good_detail_screen.dart';

class TabStoreWishList extends StatefulWidget {
  const TabStoreWishList({super.key});

  @override
  State<TabStoreWishList> createState() => _TabStoreWishListState();
}

class _TabStoreWishListState extends State<TabStoreWishList> {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverTween(
          child: SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.toWidth),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                  child: Text(
                    tr("store.wishlist_tab.wishlist"),
                    style: ShownyStyle.body2(
                        color: ShownyStyle.black, weight: FontWeight.w700),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 16.toWidth),
                  child: Text(
                    tr("store.wishlist_tab.fav_products"),
                    style: ShownyStyle.overline(
                      color: ShownyStyle.black,
                    ),
                  ),
                ),
                SizedBox(height: 24.toWidth),
                Consumer<StoreWishListProvider>(
                  builder: (context, prov, child) {
                    return prov.getIsStoreWishListLoading()
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : GridView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: prov.storeGoodsWishList.length,
                            shrinkWrap: true,
                            padding:
                                EdgeInsets.symmetric(horizontal: 16.toWidth),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.toWidth,
                              childAspectRatio: 170 / 335,
                            ),
                            itemBuilder: (context, index) {
                              return _WishListItem(
                                index: index,
                                item: prov.storeGoodsWishList[index],
                              );
                            },
                          );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _WishListItem extends StatefulWidget {
  final int index;
  final StoreGoodModel item;
  const _WishListItem({
    Key? key,
    required this.index,
    required this.item,
  }) : super(key: key);

  @override
  State<_WishListItem> createState() => __WishListItemState();
}

class __WishListItemState extends State<_WishListItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            ShownyPageRoute(
              builder: (context) => StoreGoodDetailScreen(
                goodsNo: widget.item.goodsNo,
              ),
            ));
      },
      behavior: HitTestBehavior.translucent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                widget.item.goodsImageUrlList[0],
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.white,
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 8.toWidth),
          Text(
            widget.item.brandNm,
            style: ShownyStyle.caption(
                color: ShownyStyle.black, weight: FontWeight.w600),
          ),
          SizedBox(height: 4.toWidth),
          Text(
            widget.item.goodsNm,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: ShownyStyle.caption(color: ShownyStyle.black),
          ),
          SizedBox(height: 8.toWidth),
          Text(
            "${widget.item.goodsPrice.formatPrice()} 원",
            style: ShownyStyle.body2(
                color: ShownyStyle.black, weight: FontWeight.w700),
          ),
          SizedBox(height: 2.toWidth),
          Text(
            "즉시 구매가",
            style: ShownyStyle.caption(color: Color(0xffaaaaaa)),
          ),
          SizedBox(height: 4.toWidth),
          Row(
            children: [
              Image.asset('assets/icons/shop/heart_icon.png',
                  height: 14.toWidth, width: 14.toWidth),
              SizedBox(width: 4.toWidth),
              Text(
                "${widget.item.heartCount}",
                style: ShownyStyle.caption(color: Color(0xffaaaaaa)),
              ),
              SizedBox(width: 8.toWidth),
              Image.asset('assets/icons/shop/grade_icon.png',
                  height: 14.toWidth, width: 14.toWidth),
              SizedBox(width: 4.toWidth),
              Text(
                "${widget.item.grade}(${widget.item.reviewCount})",
                style: ShownyStyle.caption(color: Color(0xffaaaaaa)),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
