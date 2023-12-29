import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/constants.dart';
import 'package:showny/models/goods_item_model.dart';
import 'package:showny/screens/tabs/home/components/wearing_items_sheet_screen.dart';

class ProductContainer extends StatefulWidget {
  const ProductContainer({
    super.key,
    required this.itemInfo,
    required this.styleNo,
    required this.currentImageIdx,
  });

  final List<List<GoodsItemModel>> itemInfo;
  final int currentImageIdx;
  final String styleNo;

  @override
  State<ProductContainer> createState() => _ProductContainerState();
}

class _ProductContainerState extends State<ProductContainer> {
  List<GoodsItemModel> goodsDataList = [];

  void showMoreItem(BuildContext context,
      {required List<GoodsItemModel> itemInfo}) {
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
        return WearingItemsSheetScreen(itemInfo: itemInfo);
      },
    );
  }

  @override
  void initState() {
    super.initState();

    goodsDataList.clear();
    for (var goodsList in widget.itemInfo) {
      for (var goodsItem in goodsList) {
        goodsDataList.add(goodsItem);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (goodsDataList.isNotEmpty) {
      return GestureDetector(
          onTap: () {
            showMoreItem(context, itemInfo: goodsDataList);
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
                  child: Image.network(goodsDataList[0].goodsImg,
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
                          goodsDataList[0].brandNm,
                          style: Constants.defaultTextStyle.copyWith(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Flexible(
                          child: Text(
                            goodsDataList[0].goodsNm,
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
                    showMoreItem(context, itemInfo: goodsDataList);
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
