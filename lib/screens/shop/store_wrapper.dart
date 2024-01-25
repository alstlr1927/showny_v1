import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/screens/shop/mini_shop/mini_shop_screen.dart';
import 'package:showny/screens/shop/providers/store_wrapper_provider.dart';
import 'package:showny/screens/shop/store/store_screen.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

import 'store/store_search_page_screen.dart';

class StoreWrapper extends StatefulWidget {
  const StoreWrapper({super.key});

  @override
  State<StoreWrapper> createState() => _StoreWrapperState();
}

class _StoreWrapperState extends State<StoreWrapper>
    with TickerProviderStateMixin {
  late StoreWrapperProvider provider;

  @override
  void initState() {
    super.initState();
    provider = StoreWrapperProvider(this);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<StoreWrapperProvider>.value(
      value: provider,
      builder: (context, _) {
        return Consumer<StoreWrapperProvider>(
          builder: (context, prov, child) {
            return Scaffold(
              body: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    _buildAppbar(prov),
                    Expanded(
                      child: IndexedStack(
                        index: prov.currentIdx,
                        children: [
                          StoreScreen(),
                          MiniShopScreen(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildAppbar(StoreWrapperProvider prov) {
    return SizedBox(
      width: double.infinity,
      height: 50.toWidth,
      child: Row(
        children: [
          SizedBox(width: 16.toWidth),
          Image.asset(
            'assets/icons/shop/showny_logo.png',
            width: 75.toWidth,
          ),
          SizedBox(width: 26.toWidth),
          SizedBox(
            width: 82.toWidth,
            child: _pageTitle(
              title: '브랜드스토어',
              isSelect: prov.currentIdx == 0,
              onPressed: () => prov.setCurrentIdx(0),
            ),
          ),
          SizedBox(width: 10.toWidth),
          SizedBox(
            width: 44.toWidth,
            child: _pageTitle(
              title: '미니샵',
              isSelect: prov.currentIdx == 1,
              onPressed: () => prov.setCurrentIdx(1),
            ),
          ),
          const Spacer(),
          CupertinoButton(
            onPressed: () {
              if (prov.currentIdx == 0) {
                // store search
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const StoreSearchScreen(),
                    ));
              } else if (prov.currentIdx == 1) {
                // minishop search
              }
            },
            minSize: 0,
            padding: EdgeInsets.zero,
            child: Image.asset(search, width: 24.toWidth),
          ),
          SizedBox(width: 16.toWidth),
        ],
      ),
    );
  }

  Widget _pageTitle({
    required String title,
    required bool isSelect,
    VoidCallback? onPressed,
  }) {
    TextStyle style = TextStyle();

    if (isSelect) {
      style =
          ShownyStyle.body2(color: ShownyStyle.black, weight: FontWeight.w700);
    } else {
      style = ShownyStyle.caption(color: ShownyStyle.black.withOpacity(.5));
    }

    return CupertinoButton(
      onPressed: () => onPressed?.call(),
      minSize: 0,
      padding: EdgeInsets.zero,
      child: Text(
        title,
        style: style,
      ),
    );
  }
}
