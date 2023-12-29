import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/tabs/profile/provider/getstore_cartlist_provider.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/theme.dart';
import 'package:showny/widgets/shoping_emptyBasket_widget.dart';

class ProductListWidget extends StatefulWidget {
  const ProductListWidget({Key? key}) : super(key: key);

  @override
  State<ProductListWidget> createState() => _ProductListWidgetState();
}

class _ProductListWidgetState extends State<ProductListWidget> {
  @override
  void initState() {
    var memNo = context.read<UserProvider>().user.memNo;
    Provider.of<GetStoreCartListProvider>(context, listen: false)
        .getStoreCartListData(memNo, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Consumer<GetStoreCartListProvider>(
        builder: (context, getStoreCartListProvider, child) => Column(
          children: [
            SizedBox(
              width: size.width,
              child: getStoreCartListProvider.getIsStoreCartLoading()
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : getStoreCartListProvider.getProducts().isEmpty
                      ? Expanded(
                          child: Center(
                            child: ShoppingEmptyBasketWidget(
                                emptyMessage:
                                    tr('empty_errors.no_product_in_cart')),
                          ),
                        )  
                      : 
                      ListView.separated(
                          shrinkWrap: true,
                          itemCount:
                              getStoreCartListProvider.getProducts().length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                        onTap: () {
                                          getStoreCartListProvider
                                              .toggleCheckbox(index);
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8, right: 8, bottom: 8),
                                          child: Icon(
                                              getStoreCartListProvider
                                                      .getCheckboxState(index)
                                                  ? CupertinoIcons
                                                      .checkmark_circle_fill
                                                  : CupertinoIcons.circle,
                                              size: 24,
                                              color: getStoreCartListProvider
                                                      .getCheckboxState(index)
                                                  ? black
                                                  : divider),
                                        )),
                                    Container(
                                      color: imageBg,
                                      width: 80,
                                      height: 80,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Image.network(
                                          "${getStoreCartListProvider.getProducts()[index].goodsImgUrl}",
                                          fit: BoxFit.fitWidth,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  Image.asset(splash),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                      getStoreCartListProvider
                                                              .getProducts()[
                                                                  index]
                                                              .brandNm ??
                                                          "",
                                                      style: themeData()
                                                          .textTheme
                                                          .headlineSmall!
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              fontSize: 10,
                                                              color:
                                                                  greyLight)),
                                                  const SizedBox(height: 6),
                                                  Text(
                                                    getStoreCartListProvider
                                                            .getProducts()[
                                                                index]
                                                            .goodsNm ??
                                                        "",
                                                    style: themeData()
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: black),
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  const SizedBox(height: 6),
                                                  Text(
                                                    "다크 그레이-M",
                                                    style: themeData()
                                                        .textTheme
                                                        .labelSmall!
                                                        .copyWith(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            color: black),
                                                  ),
                                                ],
                                              ),
                                              IconButton(
                                                padding:
                                                    const EdgeInsets.all(8),
                                                icon: const Icon(
                                                  Icons.clear,
                                                  size: 20,
                                                ),
                                                onPressed: () {
                                                  getStoreCartListProvider
                                                      .remove(index);
                                                },
                                              )
                                            ],
                                          ),
                                          const SizedBox(height: 6),
                                          Row(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  getStoreCartListProvider
                                                      .decrement(
                                                          getStoreCartListProvider
                                                              .getProducts()[
                                                                  index]
                                                              .goodsNo!);
                                                },
                                                child: Container(
                                                  height: size.height * 0.03,
                                                  width: size.width * 0.06,
                                                  color: divider,
                                                  child: const Icon(
                                                    Icons.remove,
                                                    size: 14,
                                                  ),
                                                ),
                                              ),
                                              Container(
                                                height: size.height * 0.03,
                                                width: size.width * 0.06,
                                                decoration: const BoxDecoration(
                                                    color: white,
                                                    border: Border(
                                                        top: BorderSide(
                                                            color: divider,
                                                            width: 2),
                                                        bottom: BorderSide(
                                                            color: divider,
                                                            width: 2))),
                                                child: Center(
                                                  child: Text(
                                                      getStoreCartListProvider
                                                              .getProducts()[
                                                                  index]
                                                              .goodsCnt ??
                                                          ""),
                                                ),
                                              ),
                                              GestureDetector(
                                                onTap: () {
                                                  getStoreCartListProvider
                                                      .increment(
                                                          getStoreCartListProvider
                                                              .getProducts()[
                                                                  index]
                                                              .goodsNo!);
                                                },
                                                child: Container(
                                                  height: size.height * 0.03,
                                                  width: size.width * 0.06,
                                                  color: divider,
                                                  child: const Icon(
                                                    Icons.add,
                                                    size: 14,
                                                  ),
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                '${getStoreCartListProvider.getProducts()[index].goodsPrice ?? "0"} 원',
                                                style: themeData()
                                                    .textTheme
                                                    .labelMedium!
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w700),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: size.width * 0.08,
                                    ),
                                    Text(tr('my_profile.deliveryFee_text'),
                                        style: themeData()
                                            .textTheme
                                            .labelSmall!
                                            .copyWith(color: greyLight)),
                                    const Spacer(),
                                    Text(
                                      '${getStoreCartListProvider.getProducts()[index].deliveryPrice ?? '0'} 원',
                                      style: themeData()
                                          .textTheme
                                          .labelSmall!
                                          .copyWith(color: greyLight),
                                    )
                                  ],
                                ),
                              ],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 16,
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
