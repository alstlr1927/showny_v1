import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utils/colors.dart';
import '../utils/images.dart';
import '../utils/theme.dart';

class ShoppingEmptyBasketWidget extends StatefulWidget {
  String emptyMessage;

  ShoppingEmptyBasketWidget({Key? key,required this.emptyMessage}) : super(key: key);

  @override
  State<ShoppingEmptyBasketWidget> createState() => _ShoppingEmptyBasketWidgetState();
}

class _ShoppingEmptyBasketWidgetState extends State<ShoppingEmptyBasketWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: size.height*0.04),
        Image.asset(
          backetIcon ,
          width: 48,
          height: 48,
          color: greyLight,
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          widget.emptyMessage,
          style:
              themeData().textTheme.labelSmall!.copyWith(color: greyLight),
        ),
        SizedBox(height: size.height*0.08),
      ],
    );
  }
}
