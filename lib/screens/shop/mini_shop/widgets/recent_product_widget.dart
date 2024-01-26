import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/models/filter_minishop_model.dart';
import 'package:showny/utils/theme.dart';

import '../product_page.dart';
import '../providers/mini_shop_products_provider.dart';

class RecentProductWidget extends StatefulWidget {
  final FilterMinishopModel filterMinishopModel;
  const RecentProductWidget({
    Key? key,
    required this.filterMinishopModel,
  }) : super(key: key);

  @override
  State<RecentProductWidget> createState() => _RecentProductWidgetState();
}

class _RecentProductWidgetState extends State<RecentProductWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Consumer<MiniShopProductsProvider>(builder: (context, provider, child) {
      return Padding(
        padding: const EdgeInsets.only(left: 16),
        child: provider.getRecentViewProductList().isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr('mini_shop.recently_viewed_products'),
                    style: themeData().textTheme.labelSmall,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  SizedBox(
                    width: size.width,
                    height: 129,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: provider.getRecentViewProductList().length,
                      itemBuilder: (context, index) {
                        var product = provider.getRecentViewProductList()[index];

                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  ShownyPageRoute(
                                    builder: (context) => ProductDetailScreen(
                                      productId: product.id,
                                    ),
                                  ));
                            },
                            child: SizedBox(
                              width: size.width * 0.22,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 80,
                                    width: size.width * 0.5,
                                    child: ClipRect(
                                      child: FittedBox(
                                        fit: BoxFit.cover,
                                        child: Image.network(
                                          widget.filterMinishopModel.isWear == false ? product.productImageUrlList[0] : product.wearImageUrlList[0],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(product.name, style: themeData().textTheme.labelSmall?.copyWith(fontSize: 10), maxLines: 2, overflow: TextOverflow.ellipsis),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text("${product.price.formatPrice()} 원", style: themeData().textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w700)),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  )
                ],
              )
            : const SizedBox(),
      );
    });
  }
}
