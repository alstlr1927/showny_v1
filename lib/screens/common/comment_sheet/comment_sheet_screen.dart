import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keyboard_attachable/keyboard_attachable.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/drag_to_dispose/drag_to_dispose.dart';
import 'package:showny/components/keep_alive_widget/keep_alive_widget.dart';
import 'package:showny/components/logger/showny_logger.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/components/title_text_field/comment_text_field.dart';
import 'package:showny/components/user_profile/profile_container.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/common/comment_sheet/providers/comment_sheet_provider.dart';
import 'package:showny/screens/common/comment_sheet/widgets/comment_page.dart';
import 'package:showny/screens/common/comment_sheet/widgets/recomment_page.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';
import 'package:video_player/video_player.dart';

import '../../../components/bottom_sheet/theme/bottom_sheet_theme.dart';
import '../../../components/divider/default_divider.dart';

class CommentSheetScreen extends StatefulWidget {
  final VideoPlayerController? vController;
  final String memNo;
  final String styleupNo;
  const CommentSheetScreen({
    super.key,
    required this.memNo,
    required this.styleupNo,
    this.vController,
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
            return GestureDetector(
              onTap: prov.unfocusAll,
              child: DragToDispose(
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
                  return Scaffold(
                    resizeToAvoidBottomInset: true,
                    extendBody: true,
                    body: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        FooterLayout(
                          child: Column(
                            children: [
                              Flexible(
                                // child: CommentPage(commentList: prov.commentList),
                                child: PageView(
                                  controller: prov.pageController,
                                  physics: const NeverScrollableScrollPhysics(),
                                  onPageChanged: prov.setPageIdx,
                                  children: [
                                    KeepAliveWidget(
                                        child: CommentPage(
                                            commentList: prov.commentList)),
                                    KeepAliveWidget(
                                      child: RecommentPage(
                                        parent: prov.parentComment,
                                        recommentList: prov.childCommentList,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Column(
                        //   children: [
                        //     ShownyButton(
                        //       onPressed: () {},
                        //       option: ShownyButtonOption.fill(
                        //         text: 'dd',
                        //         theme: ShownyButtonFillTheme.violet,
                        //         style: ShownyButtonFillStyle.fullRegular,
                        //       ),
                        //     ),
                        //     ShownyButton(
                        //       onPressed: () {},
                        //       option: ShownyButtonOption.fill(
                        //         text: 'dd',
                        //         theme: ShownyButtonFillTheme.violet,
                        //         style: ShownyButtonFillStyle.fullRegular,
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        _buildCommentInput(controller),
                      ],
                    ),
                  );
                },
              ),
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
                          child: Text(prov.currentPage == 0 ? '댓글' : '답글',
                              style: ShownyStyle.body1(
                                  color: ShownyStyle.black,
                                  weight: FontWeight.w600))),
                    ),
                    if (prov.currentPage == 1)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CupertinoButton(
                          onPressed: prov.changeToComment,
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.black,
                          ),
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

  Widget _buildCommentInput(ScrollController controller) {
    return Consumer<CommentSheetProvider>(builder: (context, prov, child) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // if (prov.currentPage == 0) ...{
              //   if (prov.isRecommentMode && prov.parentComment != null) ...{
              //     Container(
              //       width: double.infinity,
              //       height: 50,
              //       padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
              //       color: ShownyStyle.gray040,
              //       child: Row(
              //         children: [
              //           Text(
              //             '${prov.parentComment!.userInfo.memNm}님에게 남긴 답글',
              //             style: ShownyStyle.caption(
              //               color: ShownyStyle.gray060,
              //             ),
              //           ),
              //           const Spacer(),
              //           CupertinoButton(
              //             onPressed: () {
              //               prov.setParentComment(null);
              //               prov.unfocusAll();
              //             },
              //             minSize: 0,
              //             padding: EdgeInsets.zero,
              //             child: Icon(
              //               Icons.close,
              //               size: 18,
              //               color: ShownyStyle.gray080,
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   },
              // },
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Consumer<UserProvider>(builder: (context, userProv, child) {
                      return ProfileContainer.size40(
                        url: userProv.user.profileImage,
                      );
                    }),
                    SizedBox(width: 8.toWidth),
                    Expanded(
                      child: CommentTextField(
                        hintText: '댓글을 입력해 주세요.',
                        maxLines: 1,
                        controller: prov.commentController,
                        suffixIcon: ShownyButton(
                          onPressed: prov.handleSendComment,
                          option: ShownyButtonOption.text(
                            text: '작성',
                            theme: ShownyButtonTextTheme.gray,
                            style: ShownyButtonTextStyle.small,
                          ),
                        ),
                        emojiEnable: true,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: ShownyStyle.defaultBottomPadding())
            ],
          ),
        ),
      );
    });
  }
}
