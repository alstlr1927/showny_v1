import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:showny/main.dart';
import 'package:showny/models/store_good_model.dart';

import '../../../api/new_api/api_helper.dart';
import '../store/providers/store_provider.dart';
import '../store/providers/store_wishlist_provider.dart';

class StoreHelper {
  static setHeartClick(
      BuildContext context, String memNo, StoreGoodModel goodModel) {
    goodModel.isHeart = !goodModel.isHeart;
    eventBus.fire(goodModel);
    Provider.of<StoreProvider>(context, listen: false).updateNotifyData();
    Provider.of<StoreWishListProvider>(context, listen: false)
        .updateNotifyData();

    ApiHelper.shared.heartGoods(memNo, goodModel.goodsNo, (success) {
      Provider.of<StoreWishListProvider>(context, listen: false)
          .getGoodsHeart(memNo);
    }, (error) {});
  }
}
