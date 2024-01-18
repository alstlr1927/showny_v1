import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/drag_to_dispose/drag_to_dispose.dart';
import 'package:showny/components/logger/showny_logger.dart';
import 'package:showny/screens/common/comment_sheet/comment_sheet_screen.dart';

import '../../../../api/new_api/api_helper.dart';
import '../../../../models/styleup_comment_model.dart';
import '../../../../providers/user_model_provider.dart';

class CommentSheetProvider with ChangeNotifier {
  State<CommentSheetScreen> state;

  PageController pageController = PageController();
  DragToDisposeController disposeController = DragToDisposeController();

  late List<StyleupCommentModel> commentList = [];
  late List<StyleupCommentModel> childCommentList = [];

  int currentPage = 0;

  void setPageIdx(int val) {
    currentPage = val;
    notifyListeners();
  }

  Future _getStyleupCommentList() async {
    UserProvider userProvider =
        Provider.of<UserProvider>(state.context, listen: false);
    final user = userProvider.user;

    ApiHelper.shared.getStyleupCommentList(
        state.widget.styleupNo, user.memNo, 0, (comments) {
      commentList = [...comments];
      notifyListeners();

      ShownyLog().d('comment length : ${commentList.length}');

      ShownyLog().d(
          'DEBUG: fetch comment succeed, styleupNo: ${state.widget.styleupNo}, data: $commentList');
    }, (error) {
      commentList = [];
      ShownyLog().d(
          'DEBUG: fetch comment failed, styleupNo: ${state.widget.styleupNo}, error: $error');
    });
  }

  Future getChildCommentList({
    required String commentNo,
  }) async {
    ApiHelper.shared.getStyleupChildCommentList(
      state.widget.styleupNo,
      state.widget.memNo,
      commentNo,
      0,
      (getCommentList) {
        childCommentList = [...getCommentList];
        notifyListeners();
        // setState(() {
        //   childCommentList.clear();
        //   childCommentList.addAll(getCommentList);
        //   success(null);
        // });
      },
      (error) {},
    );
  }

  Future changeToRecomment(String commentNo) async {
    pageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    getChildCommentList(commentNo: commentNo);

    // await pageController.nextPage(
    //     duration: const Duration(milliseconds: 200), curve: Curves.easeIn);
    // childCommentList = [];
  }

  Future changeToComment() async {
    childCommentList.clear();
    pageController.animateToPage(0,
        duration: const Duration(milliseconds: 200), curve: Curves.easeIn);

    notifyListeners();
  }

  // Future _getChildCommentList() {
  //   ApiHelper.shared.getStyleupChildCommentList(
  //       state.widget.styleupNo,
  //       state.widget.memNo,
  //       currentComment?.styleupCommentNo ?? 0,
  //       0, (getCommentList) {
  //     setState(() {
  //       childCommentList.clear();
  //       childCommentList.addAll(getCommentList);
  //       success(null);
  //     });
  //   }, (error) {});
  // }

  @override
  void notifyListeners() {
    if (state.mounted) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  CommentSheetProvider(this.state) {
    _getStyleupCommentList();
  }
}
