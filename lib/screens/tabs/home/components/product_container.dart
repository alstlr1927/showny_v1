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
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.4),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: Image.network(goodsDataList[0].goodsImg,
                      width: 40.0,
                      height: 40.0,
                      fit: BoxFit.cover, errorBuilder: (context, error, stack) {
                    return Container(
                      color: Colors.white,
                    );
                  }),
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
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
                    Text(
                      goodsDataList[0].goodsNm,
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
                    showMoreItem(context, itemInfo: goodsDataList);
                  },
                  padding: EdgeInsets.zero,
                  minSize: 0,
                  child: const SizedBox(
                    width: 50,
                    height: 30,
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
}
