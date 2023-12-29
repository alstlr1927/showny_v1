import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/constants.dart';
import 'package:showny/models/goods_item_model.dart';
import 'package:showny/screens/tabs/home/components/wearing_items_sheet_screen_battle.dart';

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
      {required List<GoodsItemModel> itemInfo1, required List<GoodsItemModel> itemInfo2}) {
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
        return WearingItemsSheetScreenBattle(itemInfo1: itemInfo1, itemInfo2: itemInfo2, name1: widget.name1, name2: widget.name2,);
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
            showMoreItem(context, itemInfo1: goodsDataList1, itemInfo2: goodsDataList2);
          },
          child: Container(
            height: 48,
            decoration: const ShapeDecoration(
              color: Color.fromRGBO(0, 0, 0, 0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(4),
                  bottomLeft: Radius.circular(4),
                ),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 4.0),
                ClipRRect(
                  borderRadius: BorderRadius.circular(2.0),
                  child: Image.network(goodsDataList1[0].goodsImg,
                      width: 40.0, height: 40.0, fit: BoxFit.cover,
                      errorBuilder: (context, error, StackTrace) {
                    return Container(
                      color: Colors.white,
                    );
                  }),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        Flexible(
                          child: Text(
                            goodsDataList1[0].goodsNm,
                            style: Constants.defaultTextStyle.copyWith(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ]),
                )),
                CupertinoButton(
                  onPressed: () {
                    showMoreItem(context, itemInfo1: goodsDataList1, itemInfo2: goodsDataList2);
                  },
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  child: const SizedBox(
                    width: 56,
                    height: 48,
                    child: Center(
                      child: Text(
                        '더보기',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                        ),
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
