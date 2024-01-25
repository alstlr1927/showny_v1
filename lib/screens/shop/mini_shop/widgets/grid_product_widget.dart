// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:showny/components/page_route.dart';
// import 'package:showny/extension/ext_int.dart';
// import 'package:showny/models/filter_minishop_model.dart';
// import 'package:showny/screens/tabs/profile/my_shop/components/my_shop_grid_item.dart';
// import 'package:showny/widgets/shoping_emptyBasket_widget.dart';

// import '../product_page.dart';
// import '../providers/mini_shop_products_provider.dart';

// class GridProductWidget extends StatefulWidget {
//   final FilterMinishopModel filterMinishopModel;
//   const GridProductWidget({
//     Key? key,
//     required this.filterMinishopModel,
//   }) : super(key: key);

//   @override
//   State<GridProductWidget> createState() => _GridProductWidgetState();
// }

// class _GridProductWidgetState extends State<GridProductWidget> {
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return SizedBox(
//       width: size.width,
//       child: Consumer<MiniShopProductsProvider>(
//         builder: (context, provider, child) {
//           var productList = provider.getProducts();

//           return provider.getIsProductsLoading()
//               ? const Center(
//                   child: CircularProgressIndicator(),
//                 )
//               : provider.getProducts().isEmpty
//                   ? Center(
//                       child: ShoppingEmptyBasketWidget(
//                           emptyMessage: tr('my_profile.empty_msg')),
//                     )
//                   : GridView.builder(
//                       physics: const BouncingScrollPhysics(),
//                       shrinkWrap: true,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                         crossAxisCount: 3,
//                         crossAxisSpacing: 2,
//                         childAspectRatio: 0.5,
//                       ),
//                       itemCount: provider.getProducts().length,
//                       itemBuilder: (BuildContext context, int index) {
//                         var product = productList[index];
//                         var image = "";
//                         if (widget.filterMinishopModel.isWear) {
//                           image = product.wearImageUrlList.isNotEmpty
//                               ? product.wearImageUrlList[0]
//                               : "";
//                         } else {
//                           image = product.productImageUrlList.isNotEmpty
//                               ? product.productImageUrlList[0]
//                               : "";
//                         }

//                         return MyShopGridItem(
//                           brandName: product.brand,
//                           title: product.name,
//                           price: '${product.price.formatPrice()} 원',
//                           imageUrl: image,
//                           onTap: () {
//                             String productId = product.id;
//                             if (productId == "") {
//                               return;
//                             }
//                             Navigator.push(
//                                 context,
//                                 ShownyPageRoute(
//                                   builder: (context) => ProductDetailScreen(
//                                     productId: productId,
//                                   ),
//                                 ));
//                           },
//                         );
//                         // return GestureDetector(
//                         //   onTap: () {
//                         //     String productId =
//                         //         provider.getProducts()[index].id ?? "";
//                         //     if (productId == "") {
//                         //       return;
//                         //     }
//                         //     Navigator.push(
//                         //       context,
//                         //       PageRouteBuilderRightLeft(
//                         //           child: ProductDetailScreen(productId: productId)));
//                         //   },
//                         //   child: SizedBox(
//                         //     width: size.width * 0.3,
//                         //     child: Column(
//                         //       crossAxisAlignment: CrossAxisAlignment.start,
//                         //       mainAxisAlignment: MainAxisAlignment.start,
//                         //       children: [
//                         //         SizedBox(
//                         //           height: size.height * 0.130,
//                         //           width: size.width * 0.9,
//                         //           child: ClipRect(
//                         //             child: FittedBox(
//                         //               fit: BoxFit.cover,
//                         //               child: Image.network(
//                         //                 provider.getViewWearingShot() ==
//                         //                         MiniShopProductsViewWearingShot
//                         //                             .view
//                         //                     ? provider
//                         //                         .getProducts()[index]
//                         //                         .wearImageUrlList![0]
//                         //                     : provider
//                         //                         .getProducts()[index]
//                         //                         .productImageUrlList![0],
//                         //                 errorBuilder:
//                         //                     (context, error, stackTrace) =>
//                         //                         Image.asset(splash),
//                         //               ),
//                         //             ),
//                         //           ),
//                         //         ),
//                         //         SizedBox(
//                         //           height: size.height * 0.012,
//                         //         ),
//                         //         Padding(
//                         //           padding: const EdgeInsets.only(left: 8.0),
//                         //           child: Column(
//                         //             crossAxisAlignment:
//                         //                 CrossAxisAlignment.start,
//                         //             children: [
//                         //               Text(
//                         //                   provider.getProducts()[index].name ??
//                         //                       "",
//                         //                   style:
//                         //                       themeData().textTheme.labelSmall,
//                         //                   maxLines: 2,
//                         //                   overflow: TextOverflow.ellipsis),
//                         //               Text(
//                         //                   provider
//                         //                           .getProducts()[index]
//                         //                           .description ??
//                         //                       "",
//                         //                   style:
//                         //                       themeData().textTheme.labelSmall,
//                         //                   // maxLines: 2,
//                         //                   overflow: TextOverflow.ellipsis),
//                         //               SizedBox(
//                         //                 height: size.height * 0.012,
//                         //               ),
//                         //               Text(
//                         //                   "${formatter.format(provider.getProducts()[index].price)} 원",
//                         //                   style: themeData()
//                         //                       .textTheme
//                         //                       .labelSmall
//                         //                       ?.copyWith(
//                         //                           fontWeight: FontWeight.w700)),
//                         //             ],
//                         //           ),
//                         //         ),
//                         //       ],
//                         //     ),
//                         //   ),
//                         // );
//                       },
//                     );
//         },
//       ),
//     );
//   }
// }
