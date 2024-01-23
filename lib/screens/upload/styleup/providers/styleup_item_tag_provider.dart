import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/screens/upload/styleup/styleup_item_tag.dart';
import 'package:showny/screens/upload/styleup/widgets/select_item_category.dart';
import 'package:showny/utils/showny_util.dart';

import '../../../shop/store_search_page_screen.dart';

class StyleupItemTagProvider with ChangeNotifier {
  State<StyleupItemTag> state;

  int imgIdx = 0;
  List<List<StoreGoodModel?>?> goodsDataList = [];

  void imgIndexChange(int val) {
    imgIdx = val;
    notifyListeners();
  }

  void setStoreGoodModel(StoreGoodModel? goodsData, int index) {
    goodsDataList[imgIdx]![index] = goodsData;
    notifyListeners();
  }

  void onClickAddItemBox(int idx) {
    Navigator.push(
        state.context,
        ShownyPageRoute(
            builder: (context) => StoreSearchScreen(
                  onSelected: (goodsData) {
                    goodsData.left = 0.4;
                    goodsData.top = 0.4;
                    setStoreGoodModel(goodsData, idx);
                  },
                ),
            settings: const RouteSettings(name: PageName.STORE_SEARCH)));
  }

  void showItemTagSheet(TapUpDetails details) {
    double width = ScreenUtil().screenWidth - 32.toWidth;
    double height = width * 4 / 3;

    Navigator.push(
        state.context,
        SheetRoute(
          builder: (context) => SelectItemCategory(
            onSelect: (idx) {
              Navigator.pop(context);
              Navigator.push(
                  context,
                  ShownyPageRoute(
                      builder: (context) => StoreSearchScreen(
                            onSelected: (goodsData) {
                              goodsData.left = details.localPosition.dx / width;
                              goodsData.top = details.localPosition.dy / height;
                              setStoreGoodModel(goodsData, idx);
                            },
                          ),
                      settings:
                          const RouteSettings(name: PageName.STORE_SEARCH)));
            },
          ),
        ));
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
    notifyListeners();
  }
}
