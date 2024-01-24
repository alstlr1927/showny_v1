import 'dart:core';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/widgets/custom_dropdown_widget.dart';

import '../providers/mini_shop_products_provider.dart';

class CheckBoxWidget extends StatefulWidget {
  final bool isWearCheck;
  final bool isTansaction;
  final int sort;
  final Function(bool) checkWear;
  final Function(bool) checkTransaction;
  final Function(int) changeSort;

  const CheckBoxWidget({
    Key? key,
    required this.isWearCheck,
    required this.isTansaction,
    required this.checkWear,
    required this.checkTransaction,
    required this.sort,
    required this.changeSort,
  }) : super(key: key);

  @override
  State<CheckBoxWidget> createState() => _CheckBoxWidgetState();
}

class _CheckBoxWidgetState extends State<CheckBoxWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: size.width,
        child: Consumer<MiniShopProductsProvider>(
          builder: (context, provider, child) => Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                  widget.checkWear(!widget.isWearCheck);
                },
                child: Row(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.isWearCheck ? black : Colors.transparent,
                        border: Border.all(
                          color: widget.isWearCheck ? black : checkBoxColor,
                          width: 1,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          widget.isWearCheck ? Icons.check : null,
                          size: 15.0,
                          color: widget.isWearCheck ? white : Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      tr('mini_shop.checkbox.view_wearing_shot'),
                      style: ShownyStyle.caption(),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  widget.checkTransaction(!widget.isTansaction);
                },
                child: Row(
                  children: [
                    Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.isTansaction ? black : Colors.transparent,
                        border: Border.all(
                          color: widget.isTansaction ? black : checkBoxColor,
                          width: 1.0,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          widget.isTansaction ? Icons.check : null,
                          size: 15.0,
                          color: widget.isTansaction ? white : Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      tr('mini_shop.checkbox.transaction_completion_status'),
                      style: ShownyStyle.caption(),
                    ),
                  ],
                ),
              ),
              // const Spacer(),
              Expanded(
                child: CustomDropDown2(
                  dropDownItems: provider.sortOptions,
                  selectedItem: provider.sortOptions[widget.sort],
                  onChanged: (String? newValue) {
                    int index = provider.sortOptions.indexOf(newValue!);
                    widget.changeSort(index);
                  },
                ),
              ),
              // Container(
              //   height: 20,
              //   decoration: const BoxDecoration(
              //     border: Border.fromBorderSide(BorderSide.none),
              //   ),
              //   child: DropdownButton<String>(
              //     underline: const SizedBox.shrink(),
              //     value: provider.sortOptions[provider.getSelectedSorting()],
              //     alignment: Alignment.centerRight,
              //     style:
              //         themeData().textTheme.bodySmall?.apply(color: textColor),
              //     icon: Padding(
              //       padding: const EdgeInsets.only(left: 5),
              //       child: Image.asset(
              //         arrowDownIcon,
              //         width: 20,
              //         height: 20,
              //       ),
              //     ),
              //     onChanged: (String? newValue) {
              //       int index = provider.sortOptions.indexOf(newValue!);
              //       provider.setSelectedSorting(index);
              //
              //       UserProvider userProvider =
              //           Provider.of<UserProvider>(context, listen: false);
              //       final user = userProvider.user;
              //       provider.getMiniShopProductList(
              //           memNo: user.memNo, keyWord: "");
              //     },
              //     items: provider.sortOptions.map((String item) {
              //       return DropdownMenuItem<String>(
              //         value: item,
              //         child: Text(
              //           item,
              //           style: themeData().textTheme.bodySmall!.copyWith(
              //               fontWeight: FontWeight.w400,
              //               color: provider.sortOptions[
              //               provider.getSelectedSorting()] ==
              //                   item
              //                   ? black
              //                   : textColor),
              //         ),
              //       );
              //     }).toList(),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
