import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/screens/common/scroll_physics/custom_scroll_physics.dart';
import 'package:showny/screens/home/widgets/styleup_item.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class StyleupScreen extends StatefulWidget {
  const StyleupScreen({
    super.key,
    required this.initIndex,
    required this.styleupList,
    this.updateShowMenu,
    required this.isMain,
    this.afterFollowAction,
    this.afterUpDownAction,
  });

  final bool isMain;
  final int initIndex;
  final List<StyleupModel> styleupList;
  final Function? updateShowMenu;
  final Function({required String styleUpNo, required bool value})?
      afterFollowAction;
  final Function({required String styleUpNo, required int value})?
      afterUpDownAction;

  @override
  State<StyleupScreen> createState() => _StyleupScreenState();
}

class _StyleupScreenState extends State<StyleupScreen> {
  bool showTags = false;

  List<StyleupModel> styleupList = [];

  late PageController pageController;

  void updateShowTag(bool isShow) {
    setState(() {
      showTags = isShow;
    });
    if (widget.updateShowMenu != null) {
      widget.updateShowMenu!(isShow);
    }
  }

  @override
  void initState() {
    super.initState();

    setState(() {
      pageController = PageController(initialPage: widget.initIndex);
      styleupList = widget.styleupList;
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  void didUpdateWidget(covariant StyleupScreen oldWidget) {
    styleupList = widget.styleupList;
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ShownyStyle.black,
      child: Stack(
        children: [
          PageView.builder(
            allowImplicitScrolling: true,
            controller: pageController,
            scrollDirection: Axis.vertical,
            physics: const CustomScrollPhysics(),
            itemCount: styleupList.length,
            itemBuilder: (context, index) {
              return StyleUpItem(
                isMain: widget.isMain,
                styleUp: styleupList[index],
                index: index,
                afterFollowAction: widget.afterFollowAction,
                afterUpDownAction: widget.afterUpDownAction,
                onSelect: () {
                  pageController.animateToPage(
                    index + 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
              );
            },
          ),
          if (!widget.isMain)
            SafeArea(
              child: SizedBox(
                height: 48.toWidth,
                child: Row(
                  children: [
                    CupertinoButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
