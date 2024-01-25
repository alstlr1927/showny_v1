import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/components/error/image_error.dart';
import 'package:showny/components/showny_image/showny_image.dart';
import 'package:showny/constants.dart';
import 'package:showny/models/goods_item_model.dart';
import 'package:showny/screens/home/battle/widgets/wearing_items_sheet_screen_battle.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class ProductContainerBattle extends StatefulWidget {
  const ProductContainerBattle({
    super.key,
    required this.itemInfo1,
    required this.itemInfo2,
    required this.name1,
    required this.name2,
    required this.currentImageIdx,
  });

  final List<List<GoodsItemModel>> itemInfo1;
  final List<List<GoodsItemModel>> itemInfo2;
  final int currentImageIdx;
  final String name1;
  final String name2;

  @override
  State<ProductContainerBattle> createState() => _ProductContainerBattle();
}

class _ProductContainerBattle extends State<ProductContainerBattle> {
  List<GoodsItemModel> goodsDataList1 = [];
  List<GoodsItemModel> goodsDataList2 = [];

  void showMoreItem(BuildContext context,
      {required List<GoodsItemModel> itemInfo1,
      required List<GoodsItemModel> itemInfo2}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      enableDrag: false,
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      builder: (context) {
        return WearingItemsSheetScreenBattle(
          itemInfo1: itemInfo1,
          itemInfo2: itemInfo2,
          name1: widget.name1,
          name2: widget.name2,
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    goodsDataList1.clear();
    for (var goodsList in widget.itemInfo1) {
      for (var goodsItem in goodsList) {
        goodsDataList1.add(goodsItem);
      }
    }

    goodsDataList2.clear();
    for (var goodsList in widget.itemInfo2) {
      for (var goodsItem in goodsList) {
        goodsDataList2.add(goodsItem);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (goodsDataList1.isNotEmpty) {
      return GestureDetector(
          onTap: () {
            showMoreItem(context,
                itemInfo1: goodsDataList1, itemInfo2: goodsDataList2);
          },
          child: Container(
            padding: EdgeInsets.all(4.toWidth),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.4),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: ShownyImage(
                    imageUrl: goodsDataList1.first.goodsImg,
                    width: 40.toWidth,
                    height: 40.toWidth,
                    fit: BoxFit.cover,
                  ),
                  // child: Image.network(goodsDataList1[0].goodsImg,
                  //     width: 40.toWidth,
                  //     height: 40.toWidth,
                  //     fit: BoxFit.cover,
                  //     errorBuilder: (context, error, stack) =>
                  //         const ImageError()),
                ),
                SizedBox(width: 12.toWidth),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goodsDataList1[0].brandNm,
                      style: Constants.defaultTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      goodsDataList1[0].goodsNm,
                      style: Constants.defaultTextStyle.copyWith(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
                const Spacer(),
                CupertinoButton(
                  onPressed: () {
                    showMoreItem(context,
                        itemInfo1: goodsDataList1, itemInfo2: goodsDataList2);
                  },
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  child: SizedBox(
                    width: 50,
                    height: 30,
                    child: Center(
                      child: Text(
                        '더보기',
                        style: ShownyStyle.overline(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ));
    } else {
      return const SizedBox();
    }
  }
}
