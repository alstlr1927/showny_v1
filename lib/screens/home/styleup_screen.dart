import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showny/components/indicator/showny_indicator.dart';
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
    this.setStyelupData,
    this.refresh,
  });

  final bool isMain;
  final int initIndex;
  final List<StyleupModel> styleupList;
  final Function? updateShowMenu;
  final Function({required String styleupNo, required StyleupModel copy})?
      setStyelupData;
  final VoidCallback? refresh;

  @override
  State<StyleupScreen> createState() => _StyleupScreenState();
}

class _StyleupScreenState extends State<StyleupScreen> {
  bool showTags = false;

  List<StyleupModel> styleupList = [];

  late PageController pageController;

  double refreshPoint = -80.0;
  double indicatorTopPadding = -30.0;

  bool readyToRefresh = false;

  setReadyRefresh(bool flag) {
    readyToRefresh = flag;
    setState(() {});
  }

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
    if (widget.isMain) {
      pageController.addListener(() {
        if (pageController.offset < refreshPoint) {
          if (!readyToRefresh) {
            setReadyRefresh(true);
            HapticFeedback.mediumImpact();
          }
        }
        if (!readyToRefresh && pageController.offset < 0) {
          indicatorTopPadding = pageController.offset * -1;
          setState(() {});
        }
        if (pageController.offset == 0.0) {
          indicatorTopPadding = -30;

          if (readyToRefresh) {
            widget.refresh?.call();
          }
          setReadyRefresh(false);
        }
      });
    }
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
          Container(
            child: PageView.builder(
              controller: pageController,
              scrollDirection: Axis.vertical,
              physics: const CustomScrollPhysics(),
              itemCount: styleupList.length,
              itemBuilder: (context, index) {
                return StyleUpItem(
                  isMain: widget.isMain,
                  styleUp: styleupList[index],
                  index: index,
                  setStyelupData: widget.setStyelupData,
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
          if (widget.isMain) ...{
            Builder(builder: (c) {
              return AnimatedPositioned(
                duration: Duration(milliseconds: 10),
                // top: MediaQuery.of(context).padding.top,
                top: indicatorTopPadding,
                left: ScreenUtil().screenWidth / 2 - 15,
                child: ShownyIndicator(
                  color: Colors.white,
                  radius: 15,
                  animating: true,
                ),
              );
            }),
          }
        ],
      ),
    );
  }
}
