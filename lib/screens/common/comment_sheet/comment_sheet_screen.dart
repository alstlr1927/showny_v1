import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/drag_to_dispose/drag_to_dispose.dart';
import 'package:showny/screens/common/comment_sheet/providers/comment_sheet_provider.dart';
import 'package:showny/screens/common/comment_sheet/widgets/comment_page.dart';
import 'package:showny/screens/common/comment_sheet/widgets/recomment_page.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

import '../../../components/bottom_sheet/theme/bottom_sheet_theme.dart';
import '../../../components/divider/default_divider.dart';

class CommentSheetScreen extends StatefulWidget {
  final String memNo;
  final String styleupNo;
  const CommentSheetScreen({
    super.key,
    required this.memNo,
    required this.styleupNo,
  });

  @override
  State<CommentSheetScreen> createState() => _CommentSheetScreenState();
}

class _CommentSheetScreenState extends State<CommentSheetScreen> {
  late CommentSheetProvider provider;

  @override
  void initState() {
    super.initState();
    provider = CommentSheetProvider(this);
  }

  @override
  void dispose() {
    provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maxHeight =
        ScreenUtil().screenHeight - ScreenUtil().statusBarHeight - 100;
    return ChangeNotifierProvider<CommentSheetProvider>.value(
      value: provider,
      builder: (context, _) {
        return Consumer<CommentSheetProvider>(
          builder: (context, prov, child) {
            return DragToDispose(
              onPageClosed: () {
                if (mounted) {
                  Navigator.pop(context);
                }
              },
              maxHeight: maxHeight,
              disposeController: prov.disposeController,
              dragEnable: true,
              backdropTapClosesPanel: true,
              header: pageHeader(title: '댓글'),
              panelBuilder: (controller, ac) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    FooterLayout(
                      child: Column(
                        children: [
                          Flexible(
                              child: PageView(
                            controller: prov.pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            children: [
                              CommentPage(commentList: prov.commentList),
                              Material(
                                color: Colors.green,
                                child: LazyLoadScrollView(
                                  onEndOfPage: () {},
                                  child: CustomScrollView(
                                    controller: controller,
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ],
                );
              },
              // header: Material(
              //   borderRadius: const BorderRadius.only(
              //       topLeft: Radius.circular(12),
              //       topRight: Radius.circular(12)),
              //   child: Container(
              //     height: 520,
              //     decoration: const BoxDecoration(
              //       color: ShownyStyle.white,
              //       borderRadius: BorderRadius.only(
              //           topLeft: Radius.circular(12),
              //           topRight: Radius.circular(12)),
              //     ),
              //     child: Column(
              //       children: [
              //         const SizedBox(
              //           height: 20,
              //         ),
              //         Expanded(
              //           child: PageView(
              //             physics: const NeverScrollableScrollPhysics(),
              //             children: const [
              //               CommentPage(),
              //               RecommentPage(),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
            );
          },
        );
      },
    );
  }

  Widget pageHeader({String title = ''}) {
    return Consumer<CommentSheetProvider>(builder: (context, prov, child) {
      return ClipRRect(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
        child: Material(
          child: Container(
            decoration: const BoxDecoration(
              color: BottomSheetThemeColor.sheet_base_white,
            ),
            child: Column(
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 56.toWidth,
                      child: Center(
                          child: Text(title,
                              style: ShownyStyle.body1(
                                  color: ShownyStyle.black,
                                  weight: FontWeight.w600))),
                    ),
                    Positioned(
                      top: 5.toWidth,
                      left: 0,
                      right: 0,
                      child: Center(
                        child: Container(
                          height: 5.toWidth,
                          width: 37.toWidth,
                          decoration: const BoxDecoration(
                            color: BottomSheetThemeColor.sheet_handle_base_gray,
                            borderRadius: BorderRadius.all(Radius.circular(5)),
                          ),
                        ),
                      ),
                    ),
                    if (prov.pageController.hasClients &&
                        prov.pageController.page != 0.0)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CupertinoButton(
                          onPressed: prov.changeToComment,
                          child: const Icon(Icons.arrow_back_ios),
                        ),
                      ),
                  ],
                ),
                const DefaultDivider(height: 0),
              ],
            ),
          ),
        ),
      );
    });
  }
}
