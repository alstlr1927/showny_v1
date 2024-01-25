import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/shop/store/widgets/tab_store_home.dart';
import 'package:showny/screens/shop/store/widgets/tab_store_ranking.dart';
import 'package:showny/screens/shop/store/widgets/tab_store_wishlist.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

import 'providers/store_provider.dart';
import 'providers/store_wishlist_provider.dart';
import 'store_goods_list_screen.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  void initState() {
    Future.delayed(Duration.zero, () {
      refreshItemsMainPage();
    });
    super.initState();
    // eventBus.on<EventTabRefresh>().listen((event) {
    //   ShownyLog().e('eventbus : $event');
    //   if (event.index == 2) {
    //     setState(() {
    //       refreshItemsMainPage();
    //     });
    //   }
    // });
  }

  refreshItemsMainPage() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    Provider.of<StoreProvider>(context, listen: false)
        .getStoreMainPageDataApi(user.memNo);
    Provider.of<StoreProvider>(context, listen: false)
        .getBattleInProductList(user.memNo);
    Provider.of<StoreWishListProvider>(context, listen: false)
        .getGoodsHeart(user.memNo);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.toWidth),
        _buildStoreTab(),
        SizedBox(height: 10.toWidth),
        Expanded(
          child: Consumer<StoreProvider>(
            builder: (context, prov, child) {
              if (prov.indexTab == 0) {
                return TabStoreHome();
              } else if (prov.indexTab == 1) {
                return Container(
                  color: Color(0xffff705e).withOpacity(.3),
                  child: Center(
                    child: Text(
                      '카테고리',
                      style: ShownyStyle.h2(weight: FontWeight.w600),
                    ),
                  ),
                );
              } else if (prov.indexTab == 2) {
                return TabStoreRanking();
              } else {
                return TabStoreWishList();
              }
              // return IndexedStack(
              //   index: prov.indexTab,
              //   children: [
              //     TabStoreHome(),
              //     Container(
              //       color: Colors.green,
              //     ),
              //     Container(
              //       color: Colors.red,
              //     ),
              //     Container(
              //       color: Colors.blue,
              //     ),
              //   ],
              // );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildStoreTab() {
    return Consumer<StoreProvider>(builder: (context, prov, child) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.toWidth),
        child: Row(
          children: [
            BaseButton(
                onPressed: () {
                  prov.updateIndex(0);
                },
                child: _storeTabText(
                    title: tr("store.tabs.home"),
                    isSelect: prov.indexTab == 0)),
            BaseButton(
                onPressed: () {
                  prov.updateIndex(1);
                },
                child:
                    _storeTabText(title: '카테고리', isSelect: prov.indexTab == 1)),
            BaseButton(
                onPressed: () {
                  prov.updateIndex(2);
                },
                child: _storeTabText(
                    title: tr('store.tabs.ranking'),
                    isSelect: prov.indexTab == 2)),
            BaseButton(
                onPressed: () {
                  prov.updateIndex(3);
                },
                child: _storeTabText(
                    title: tr('store.tabs.steamed'),
                    isSelect: prov.indexTab == 3)),
          ],
        ),
      );
    });
  }

  Widget _storeTabText({
    required String title,
    required bool isSelect,
  }) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 10.toWidth),
      child: Text(
        title,
        style: isSelect
            ? ShownyStyle.body2(
                color: ShownyStyle.mainPurple, weight: FontWeight.w700)
            : ShownyStyle.body2(
                color: ShownyStyle.gray070, weight: FontWeight.w500),
      ),
    );
  }
}
