import 'package:flutter/material.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/models/minishop_product_model.dart';
import 'package:showny/screens/profile/widgets/tab_my_shop.dart';
import 'package:showny/screens/profile/widgets/my_shop_grid_item.dart';
import 'package:showny/screens/profile/widgets/profile_tab_button.dart';

class TabOtherShop extends StatefulWidget {
  final List<MinishopProductModel> allProductList;
  final List<MinishopProductModel> salingProductList;
  final List<MinishopProductModel> saleCompleteProductList;
  const TabOtherShop({
    super.key,
    required this.allProductList,
    required this.salingProductList,
    required this.saleCompleteProductList,
  });

  @override
  State<TabOtherShop> createState() => _TabOtherShopState();
}

class _TabOtherShopState extends State<TabOtherShop>
    with TickerProviderStateMixin {
  late TabController _tabController;

  int tabMode = 0;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this)
      ..addListener(() {
        setState(() {
          tabMode = _tabController.index;
        });
      });
    super.initState();
  }

  MyShopPageCategory category = MyShopPageCategory.all;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            ProfieTabButton<MyShopPageCategory>(
                onTap: () {
                  setState(() {
                    category = MyShopPageCategory.all;
                    _tabController.animateTo(0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn);
                  });
                },
                // count: 12,
                category: MyShopPageCategory.all,
                currentCategory: category),
            ProfieTabButton<MyShopPageCategory>(
                onTap: () {
                  setState(() {
                    category = MyShopPageCategory.onSale;
                    _tabController.animateTo(1,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn);
                  });
                },
                // count: 12,
                category: MyShopPageCategory.onSale,
                currentCategory: category),
            ProfieTabButton<MyShopPageCategory>(
                onTap: () {
                  setState(() {
                    category = MyShopPageCategory.soldOut;
                    _tabController.animateTo(2,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeIn);
                  });
                },
                // count: 12,
                category: MyShopPageCategory.soldOut,
                currentCategory: category),
          ],
        ),
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.allProductList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 1,
                  crossAxisCount: 3,
                  childAspectRatio: 9 / 16,
                ),
                itemBuilder: (context, index) {
                  return MyShopGridItem(
                    brandName: widget.allProductList[index].brand,
                    title: widget.allProductList[index].name,
                    price: widget.allProductList[index].price.formatPrice(),
                    imageUrl: widget.allProductList[index].productImageUrlList
                            .isNotEmpty
                        ? widget.allProductList[index].productImageUrlList[0]
                        : "",
                    onTap: () {
                      String productId = widget.allProductList[index].id ?? "";
                      if (productId == "") {
                        return;
                      }
                      // Navigator.push(
                      //     context,
                      //     PageRouteBuilderRightLeft(
                      //         child:
                      //             ProductDetailScreen(
                      //       productId: productId,
                      //     )));
                    },
                  );
                },
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.salingProductList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 1,
                  crossAxisCount: 3,
                  childAspectRatio: 9 / 16,
                ),
                itemBuilder: (context, index) {
                  return MyShopGridItem(
                    brandName: widget.salingProductList[index].brand,
                    title: widget.salingProductList[index].name,
                    price: widget.salingProductList[index].price.formatPrice(),
                    imageUrl: widget.salingProductList[index]
                            .productImageUrlList.isNotEmpty
                        ? widget.salingProductList[index].productImageUrlList[0]
                        : "",
                    onTap: () {
                      String productId =
                          widget.saleCompleteProductList[index].id;
                      if (productId == "") {
                        return;
                      }
                      // Navigator.push(
                      //     context,
                      //     PageRouteBuilderRightLeft(
                      //         child:
                      //             ProductDetailScreen(
                      //       productId: productId,
                      //     )));
                    },
                  );
                },
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: 1,
                  crossAxisCount: 3,
                  childAspectRatio: 9 / 16,
                ),
                itemBuilder: (context, index) {
                  return MyShopGridItem(
                    brandName: widget.saleCompleteProductList[index].brand,
                    title: widget.saleCompleteProductList[index].name,
                    price: widget.saleCompleteProductList[index].price
                        .formatPrice(),
                    imageUrl: widget.saleCompleteProductList[index]
                            .productImageUrlList.isNotEmpty
                        ? widget.saleCompleteProductList[index]
                            .productImageUrlList[0]
                        : "",
                    onTap: () {
                      String productId =
                          widget.saleCompleteProductList[index].id;
                      if (productId == "") {
                        return;
                      }
                      // Navigator.push(
                      //     context,
                      //     PageRouteBuilderRightLeft(
                      //         child:
                      //             ProductDetailScreen(
                      //       productId: productId,
                      //     )));
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
