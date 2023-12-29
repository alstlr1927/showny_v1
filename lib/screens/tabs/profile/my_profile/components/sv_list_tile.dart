import 'package:flutter/cupertino.dart';

class SVListTile extends StatelessWidget {
  const SVListTile({
    super.key,
    required this.title,
    required this.children,
    this.onTap,
    this.titleTextStyle = const TextStyle(
      color: Color(0xFF777777),
      fontSize: 12,
      fontFamily: 'Spoqa Han Sans Neo',
      fontWeight: FontWeight.w400,
    ),
  });
  final String title;
  final List<Widget> children;
  final Function()? onTap;
  final TextStyle? titleTextStyle;

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      padding: EdgeInsets.zero,
      leadingSize: 0,
      leadingToTitle: 0,
      title: Text(title, style: titleTextStyle),
      onTap: onTap,
      trailing: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 12,
        children: children,
      ),
    );
  }
}
