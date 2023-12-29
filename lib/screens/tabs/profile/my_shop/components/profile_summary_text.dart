import 'package:flutter/material.dart';

class ProfileSummaryText extends StatelessWidget {
  const ProfileSummaryText({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  final textStyle = const TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontFamily: 'Spoqa Han Sans Neo',
    fontWeight: FontWeight.w300,
  );

  final textStyle2 = const TextStyle(
    color: Colors.black,
    fontSize: 10,
    fontFamily: 'Spoqa Han Sans Neo',
    fontWeight: FontWeight.w400,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: textStyle,
          ),
        ),
        Expanded(
          child: Text(
            title,
            style: textStyle2,
          ),
        ),
      ],
    );
  }
}
