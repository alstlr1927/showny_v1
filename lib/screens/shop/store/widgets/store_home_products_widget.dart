import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';
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
            padding: EdgeInsets.only(left: 16.toWidth),
            child: Text(
              tr('store.home_title'),
              style: ShownyStyle.body2(
                  weight: FontWeight.w700, color: ShownyStyle.black),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 16.toWidth),
            child: Text(
              tr('store.home_desc'),
              style: ShownyStyle.overline(color: ShownyStyle.black),
            ),
          ),
          SizedBox(height: 24.toWidth),
          Consumer<StoreProvider>(
            builder: (context, provider, child) =>
                provider.getIsStoreMainDataLoading()
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
                                        crossAxisSpacing: 2.toWidth,
                                        childAspectRatio: 130 / 240),
                                itemCount:
                                    // _gridProductImages.length,
                                    provider.getBattleInGoods().length,
                                itemBuilder: (BuildContext context, int index) {
                                  return _ProductInBattleItem(
                                    item: provider.getBattleInGoods()[index],
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

class _ProductInBattleItem extends StatefulWidget {
  // final int index;
  final StoreGoodModel item;
  const _ProductInBattleItem({
    Key? key,
    // required this.index,
    required this.item,
  }) : super(key: key);

  @override
  State<_ProductInBattleItem> createState() => _ProductInBattleItemState();
}

class _ProductInBattleItemState extends State<_ProductInBattleItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: FittedBox(
                fit: BoxFit.cover,
                child: GestureDetector(
                  onTap: () async {
                    String goodsNo = widget.item.goodsNo;
                    if (goodsNo == "") {
                      return;
                    }
                    await Navigator.push(
                        context,
                        ShownyPageRoute(
                          builder: (context) => StoreGoodDetailScreen(
                            goodsNo: widget.item.goodsNo,
                          ),
                        ));
                    setState(() {});
                  },
                  child: Image.network(widget.item.goodsImageUrlList[0],
                      errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.white,
                    );
                  }),
                )),
          ),
        ),
        SizedBox(height: 8.toWidth),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.toWidth),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      // _gridProductCategory[index],
                      widget.item.brandNm,
                      style: ShownyStyle.overline(
                          color: ShownyStyle.gray070, weight: FontWeight.w700),
                    ),
                    BaseButton(
                      onPressed: () {
                        UserProvider userProvider =
                            Provider.of<UserProvider>(context, listen: false);
                        final user = userProvider.user;
                        StoreHelper.setHeartClick(
                            context, user.memNo, widget.item);
                      },
                      child: (widget.item.isHeart)
                          ? Image.asset(
                              'assets/icons/home/comment_like.png',
                              height: 14.toWidth,
                              width: 14.toWidth,
                            )
                          : Image.asset(
                              'assets/icons/home/comment_unlike.png',
                              height: 14.toWidth,
                              width: 14.toWidth,
                            ),
                    ),
                  ],
                ),
                Text(
                  widget.item.goodsNm,
                  style: ShownyStyle.caption(color: ShownyStyle.black),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 6.toWidth),
                Text(
                  "${widget.item.goodsPrice.formatPrice()} 원",
                  style: ShownyStyle.caption(
                      color: ShownyStyle.black, weight: FontWeight.w700),
                ),
              ],
            )),
      ],
    );
  }
}
