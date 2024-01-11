import 'package:flutter/material.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/routes.dart';
import 'package:showny/screens/shop/store/store_search_page_screen.dart';
import 'package:showny/screens/upload/styleup/styleup_item_tag.dart';
import 'package:showny/screens/upload/styleup/widgets/select_item_category.dart';

class StyleupItemTagProvider with ChangeNotifier {
  State<StyleupItemTag> state;

  int imgIdx = 0;
  List<List<StoreGoodModel?>?> goodsDataList = [];
  List<List<StoreGoodModel?>?> originGoodsDataList = [];

  void imgIndexChange(int val) {
    imgIdx = val;
    notifyListeners();
  }

  void setStoreGoodModel(StoreGoodModel? goodsData, int index) {
    goodsDataList[imgIdx]![index] = goodsData;
    notifyListeners();
  }

  void showItemTagSheet() {
    Navigator.push(
        state.context,
        SheetRoute(
          builder: (context) => SelectItemCategory(
            onSelect: (idx) {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => StoreSearchScreen(
                      onSelected: (goodsData) {
                        goodsData.left = 0.4;
                        goodsData.top = 0.4;
                        setStoreGoodModel(goodsData, idx);
                      },
                    ),
                  ));
            },
          ),
        ));

    // showModalBottomSheet(
    //   context: state.context,
    //   builder: (context) => Container(
    //     width: ScreenUtil().screenWidth,
    //     height: 430,
    //     decoration: BoxDecoration(
    //       color: Colors.white,
    //       borderRadius: BorderRadius.circular(12),
    //     ),
    //     child: Column(
    //       children: [
    //         SizedBox(height: 24.toWidth),
    //         Text(
    //           '카테고리',
    //           style: ShownyStyle.body2(
    //               color: ShownyStyle.black, weight: FontWeight.w700),
    //         ),
    //         SizedBox(height: 24.toWidth),
    //         ...ItemCategory.values
    //             .asMap()
    //             .entries
    //             .map(
    //               (category) => Container(
    //                 color: Colors.white,
    //                 width: 200,
    //                 alignment: Alignment.center,
    //                 padding: EdgeInsets.symmetric(vertical: 6.toWidth),
    //                 child: Text(category.value.convertToString),
    //               ),
    //             )
    //             .superJoin(Container(height: 10.toWidth)),
    //       ],
    //     ),
    //   ),
    // );
  }

  @override
  void notifyListeners() {
    if (state.mounted) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  StyleupItemTagProvider(this.state) {
    goodsDataList = [...state.widget.goodsDataList];
    originGoodsDataList = [...state.widget.goodsDataList];
    print('item tag  : ${goodsDataList.first.hashCode}');
    notifyListeners();
  }
}
