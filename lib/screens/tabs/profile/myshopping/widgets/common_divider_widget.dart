import 'package:flutter/material.dart';

import '../../../../../utils/colors.dart';

class DividerWidget extends StatelessWidget {
  const DividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return const Column(
      children: [
        SizedBox(
          height: 12,
        ),
        Divider(
          color: greyExtraLight,
          thickness: 1,
        ),
        SizedBox(
          height: 12,
        ),
      ],
    );
  }
}
