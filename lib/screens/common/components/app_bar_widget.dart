import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/theme.dart';
import 'package:showny/widgets/common_appbar_widget.dart';

class AppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  final String? rightTitle;
  final Color? rightColor;
  final String? rightImageUrl;
  final Function()? rightOnTap;

  const AppBarWidget({
    required this.title,
    super.key,
    this.rightTitle,
    this.rightOnTap,
    this.rightColor,
    this.rightImageUrl,
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
      icon: CupertinoButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: ShownyStyle.black,
          )),
      action: [
        (widget.rightTitle != null || widget.rightImageUrl != null)
            ? CupertinoButton(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                onPressed: widget.rightOnTap,
                child: SizedBox(
                  child: widget.rightImageUrl != null
                      ? Image.asset(
                          widget.rightImageUrl!,
                          width: 24,
                          height: 24,
                        )
                      : Text(
                          widget.rightTitle!,
                          style: themeData()
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: widget.rightColor ?? greyLight),
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
