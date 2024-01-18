import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:showny/components/drag_to_dispose/drag_to_dispose.dart';
import 'package:showny/components/logger/showny_logger.dart';
import 'package:showny/components/title_text_field/field_controller.dart';
import 'package:showny/screens/common/comment_sheet/comment_sheet_screen.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';

import '../../../../api/new_api/api_helper.dart';
import '../../../../models/styleup_comment_model.dart';
import '../../../../providers/user_model_provider.dart';

class CommentSheetProvider with ChangeNotifier {
  State<CommentSheetScreen> state;

  PageController pageController = PageController();
  DragToDisposeController disposeController = DragToDisposeController();

  late List<StyleupCommentModel> commentList = [];
  late List<StyleupCommentModel> childCommentList = [];

  FieldController commentController = FieldController();

  // 0 : 댓글 , 1 : 답글
  int currentPage = 0;

  // 답글 모드
  StyleupCommentModel? parentComment;

  bool isRecommentLoading = true;
  bool isCommentLoading = true;

  ScrollController commentScrollController = ScrollController();
  ScrollController recommScrollController = ScrollController();

  void setCommentData({
    required bool flag,
    required String commentNo,
  }) {
    int idx = commentList
        .indexWhere((element) => element.styleupCommentNo == commentNo);
    print('idx : $idx');
    if (idx == -1) return;
    UserProvider userProvider =
        Provider.of<UserProvider>(state.context, listen: false);
    final user = userProvider.user;
    postStyleupCommentHeart(commentNo: commentNo, memNo: user.memNo);
    commentList[idx].isHeart = flag;
    if (flag) {
      commentList[idx].heartCount += 1;
    } else {
      commentList[idx].heartCount -= 1;
    }
    notifyListeners();
  }

  void setRecommentData({
    required bool flag,
    required String commentNo,
  }) {
    int idx = childCommentList
        .indexWhere((element) => element.styleupCommentNo == commentNo);
    print('idx : $idx');
    if (idx == -1) return;
    UserProvider userProvider =
        Provider.of<UserProvider>(state.context, listen: false);
    final user = userProvider.user;
    postStyleupCommentHeart(commentNo: commentNo, memNo: user.memNo);
    childCommentList[idx].isHeart = flag;
    if (flag) {
      childCommentList[idx].heartCount += 1;
    } else {
      childCommentList[idx].heartCount -= 1;
    }
    notifyListeners();
  }

  Future postStyleupCommentHeart(
      {required String commentNo, required String memNo}) async {
    ApiHelper.shared.styleupCommentHeart(
      commentNo,
      memNo,
      (success) {
        ShownyLog().d('postStyleupCommentHeart success');
      },
      (error) {
        ShownyLog().e('postStyleupCommentHeart error : $error');
      },
    );
  }

  void setIsRecommentLoading(bool flag) {
    isRecommentLoading = flag;
    notifyListeners();
  }

  void setIsCommentLoading(bool flag) {
    isCommentLoading = flag;
    notifyListeners();
  }

  void unfocusAll() {
    commentController.unfocus();
  }

  void setParentComment(StyleupCommentModel? parent) {
    parentComment = parent;
    notifyListeners();
  }

  void setPageIdx(int val) {
    currentPage = val;
    notifyListeners();
  }

  Future _getStyleupCommentList({bool refresh = false}) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(state.context, listen: false);
    final user = userProvider.user;
    if (!refresh) {
      setIsCommentLoading(true);
    }

    ApiHelper.shared.getStyleupCommentList(
        state.widget.styleupNo, user.memNo, 0, (comments) {
      commentList = [...comments];
      if (!refresh) {
        setIsCommentLoading(false);
      } else {
        // WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        //   commentScrollController.animateTo(
        //     commentScrollController.position.maxScrollExtent,
        //     duration: const Duration(milliseconds: 200),
        //     curve: Curves.easeInOut,
        //   );
        // });
        notifyListeners();
      }

      ShownyLog().d('comment length : ${commentList.length}');

      ShownyLog().e(
          'DEBUG: fetch comment succeed, styleupNo: ${state.widget.styleupNo}, data: $commentList');
    }, (error) {
      commentList = [];
      if (!refresh) {
        setIsCommentLoading(false);
      } else {
        notifyListeners();
      }
      ShownyLog().e(
          'DEBUG: fetch comment failed, styleupNo: ${state.widget.styleupNo}, error: $error');
    });
  }

  Future getChildCommentList() async {
    setIsRecommentLoading(true);
    ApiHelper.shared.getStyleupChildCommentList(
      state.widget.styleupNo,
      state.widget.memNo,
      parentComment!.styleupCommentNo,
      0,
      (getCommentList) {
        childCommentList = [...getCommentList];
        setIsRecommentLoading(false);
      },
      (error) {
        setIsRecommentLoading(false);
      },
    );
  }

  Future changeToRecomment(StyleupCommentModel comment) async {
    unfocusAll();
    setParentComment(comment);
    pageController
        .nextPage(
            duration: const Duration(milliseconds: 350), curve: Curves.easeIn)
        .then((value) {
      getChildCommentList();
    });
  }

  Future changeToComment() async {
    unfocusAll();
    pageController
        .animateToPage(0,
            duration: const Duration(milliseconds: 350), curve: Curves.easeIn)
        .then((value) {
      setParentComment(null);
      childCommentList.clear();
      notifyListeners();
    });
  }

  Future handleSendComment() async {
    if (commentController.getStatus.text.trim().isEmpty) return;
    UserProvider userProvider =
        Provider.of<UserProvider>(state.context, listen: false);
    final user = userProvider.user;

    String parentCommentId = '0';
    if (currentPage == 1 && parentComment != null) {
      parentCommentId = parentComment?.styleupCommentNo ?? '0';
    }

    ApiHelper.shared.insertStyleupComment(
      state.widget.styleupNo,
      user.memNo,
      parentCommentId,
      commentController.getStatus.text,
      (success) {
        commentController.clear();
        ShownyLog().d("insertStyleupComment - 성공");
        if (currentPage == 0) {
          _getStyleupCommentList(refresh: true);
        } else {
          getChildCommentList();
        }
      },
      (error) {
        ShownyLog().e('error occured while delete styleup comment >> $error');
      },
    );
  }

  void showDeleteDialog() {
    showDialog(
      context: state.context,
      builder: (context) {
        return ShownyDialog(
          message: '게시글을 삭제하시겠습니까?',
          primaryLabel: '취소',
          secondaryLabel: '확인',
          primaryAction: () {
            //
          },
        );
      },
    );
  }

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
