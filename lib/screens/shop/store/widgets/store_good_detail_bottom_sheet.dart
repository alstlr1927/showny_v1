import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/extension/ext_int.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/tabs/profile/provider/getstore_cartlist_provider.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/theme.dart';
import 'package:showny/widgets/common_button_widget.dart';
import 'package:showny/widgets/custom_dropdown_widget.dart';

import '../../../../api/new_api/api_helper.dart';

class StoreGoodDetailBottomSheet extends StatefulWidget {
  final StoreGoodModel goodsData;

  const StoreGoodDetailBottomSheet({super.key, required this.goodsData});

  @override
  State<StoreGoodDetailBottomSheet> createState() =>
      _StoreGoodDetailBottomSheet();
}

class _StoreGoodDetailBottomSheet extends State<StoreGoodDetailBottomSheet> {
  late List<String?> selectOptionList;
  int quantity = 1;

  @override
  void initState() {
    super.initState();

    selectOptionList = List.filled(widget.goodsData.optionList.length, null);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (int index = 0;
                index < widget.goodsData.optionList.length;
                index++)
              Column(
                children: [
                  SizedBox(
                    height: 48,
                    child: CustomDropDown(
                      dropDownItems: widget.goodsData.optionList[index].value,
                      padding: const EdgeInsets.only(right: 16),
                      hintText: '옵션 선택',
                      selectedItem: selectOptionList[index],
                      onChanged: (String? newValue) {
                        setState(() {
                          selectOptionList[index] = newValue;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  )
                ],
              ),
            SizedBox(
              height: 48,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      "상품 $quantity개",
                      style: themeData().textTheme.titleMedium,
                    ),
                  ),
                  SizedBox(
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              quantity -= 1;
                              if (quantity == 0) {
                                quantity = 1;
                              }
                            });
                          },
                          child: Container(
                            height: 24,
                            width: 24,
                            color: divider,
                            child: const Icon(
                              Icons.remove,
                              size: 14,
                            ),
                          ),
                        ),
                        Container(
                            height: 24,
                            width: 24,
                            decoration: const BoxDecoration(
                                color: white,
                                border: Border(
                                    top: BorderSide(color: divider, width: 2),
                                    bottom:
                                        BorderSide(color: divider, width: 2))),
                            child: Center(
                                child: Text(
                              "$quantity",
                              style: themeData().textTheme.bodyMedium,
                            ))),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              quantity += 1;
                            });
                          },
                          child: Container(
                            height: 24,
                            width: 24,
                            color: divider,
                            child: const Icon(
                              Icons.add,
                              size: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Text(
                      "${((widget.goodsData.goodsPrice) * (quantity)).formatPrice()} 원",
                      style: themeData().textTheme.titleMedium,
                      textAlign: TextAlign.right,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: CommonButtonWidget(
                    text: "장바구니",
                    radius: 10,
                    height: 48,
                    horizontalPadding: 0,
                    width: size.width,
                    textcolor: black,
                    borderColor: black,
                    onTap: () {
                      for (var item in selectOptionList) {
                        if (item == null) {
                          Fluttertoast.showToast(
                            msg: "옵션을 선택해주세요.",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black,
                            textColor: Colors.white,
                            fontSize: 14.0,
                          );
                          return;
                        }
                      }

                      UserProvider userProvider =
                          Provider.of<UserProvider>(context, listen: false);
                      debugPrint(selectOptionList.toString());
                      ApiHelper.shared.insertStoreGoodsCart(
                        userProvider.user.memNo,
                        widget.goodsData.goodsNo,
                        jsonEncode(selectOptionList),
                        quantity.toString(),
                        (success) {
                          Provider.of<GetStoreCartListProvider>(context,
                                  listen: false)
                              .getStoreCartListData(userProvider.user.memNo, 0);
                        },
                        (error) {
                          debugPrint(error);
                        },
                      );

                      Navigator.pop(context);
                      Fluttertoast.showToast(
                        msg: "장바구니에 추가되었습니다.",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.black,
                        textColor: Colors.white,
                        fontSize: 14.0,
                      );
                    },
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CommonButtonWidget(
                    text: "구매하기",
                    radius: 10,
                    height: 48,
                    horizontalPadding: 0,
                    width: size.width,
                    textcolor: white,
                    color: black,
                    onTap: () {
                      debugPrint("구매하기");

                      for (var selectOption in selectOptionList) {
                        if (selectOption == null) {
                          for (var item in selectOptionList) {
                            if (item == null) {
                              Fluttertoast.showToast(
                                msg: "옵션을 선택해주세요.",
                                toastLength: Toast.LENGTH_LONG,
                                gravity: ToastGravity.BOTTOM,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black,
                                textColor: Colors.white,
                                fontSize: 14.0,
                              );
                              return;
                            }
                          }
                          return;
                        }
                      }

                      // Navigator.push(
                      //     context,
                      //     ShownyPageRoute(
                      //       builder: (context) => OrderFormScreen(
                      //         storeGoodModel: [widget.goodsData],
                      //         option: [selectOptionList],
                      //         amount: [quantity],
                      //       ),
                      //     ));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
