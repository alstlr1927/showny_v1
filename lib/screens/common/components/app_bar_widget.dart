import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/widgets/common_appbar_widget.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {

  final String title;

  final String? rightTitle;
  final Color? rightColor;
  final Function()? rightOnTap;

  const AppBarWidget({
    required this.title,
    super.key, this.rightTitle, this.rightOnTap, this.rightColor,
  });

  @override
  State<AppBarWidget> createState() => _AppBarWidget();
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarWidget extends State<AppBarWidget> {

  @override
  Widget build(BuildContext context) {
    return RoundedAppBar(
        icon: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset(
              arrowBackward,
              height: 18,
              width: 9,
            ),
          ),
        ),
        action: [
          widget.rightTitle != null ?
          CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            onPressed: widget.rightOnTap,
            child: SizedBox(
              child: Text(
                widget.rightTitle!,
                style: TextStyle(
                  color: widget.rightColor ?? Colors.black, fontSize: 14),
                ),
              ),
            )
            : const SizedBox()
        ],
        titleText: widget.title,
        center: true,
        bgColor: Colors.white,
        shadow: 0,
      );
  }
}

