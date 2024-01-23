import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/utils/showny_style.dart';

import '../../../utils/colors.dart';
import '../../../utils/images.dart';

class ShoppingEmptyBasketWidget extends StatefulWidget {
  String emptyMessage;

  ShoppingEmptyBasketWidget({Key? key, required this.emptyMessage})
      : super(key: key);

  @override
  State<ShoppingEmptyBasketWidget> createState() =>
      _ShoppingEmptyBasketWidgetState();
}

class _ShoppingEmptyBasketWidgetState extends State<ShoppingEmptyBasketWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        Image.asset(
          backetIcon,
          width: 64,
          height: 64,
          color: greyLight,
        ),
        const SizedBox(
          height: 12,
        ),
        SizedBox(
          height: 48,
          child: Text(
            widget.emptyMessage,
            style: ShownyStyle.caption(),
          ),
        ),
        const SizedBox(height: 80),
      ],
    );
  }
}
