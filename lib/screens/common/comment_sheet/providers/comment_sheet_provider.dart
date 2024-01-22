import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:showny/components/logger/showny_logger.dart';
import 'package:showny/components/title_text_field/field_controller.dart';
import 'package:showny/screens/common/comment_sheet/comment_sheet_screen.dart';
import 'package:showny/screens/home/widgets/report_sheet_screen.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';

import '../../../../api/new_api/api_helper.dart';
import '../../../../models/styleup_comment_model.dart';
import '../../../../providers/user_model_provider.dart';

class CommentSheetProvider with ChangeNotifier {
  State<CommentSheetScreen> state;

  PageController pageController = PageController();
  SwiperController swiperController = SwiperController();

  late List<StyleupCommentModel> commentList = [];
  late List<StyleupCommentModel> childCommentList = [];

  FieldController commentController = FieldController();

  // 0 : 댓글 , 1 : 답글
  int currentPage = 0;

  // 답글 모드
  StyleupCommentModel? parentComment;

  bool isRecommentLoading = true;
  bool isCommentLoading = true;

  late UserProvider userProvider;

  void setCommentData({
    required bool flag,
    required String commentNo,
  }) {
    int idx = _findIndexWhereComment(commentNo);

    if (idx == -1) return;
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
    int idx = _findIndexWhereRecomment(commentNo);

    if (idx == -1) return;
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
        ShownyLog().i('postStyleupCommentHeart success');
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

  double prevScrollPosition = 0.0;
  void setPosition(double val) {
    prevScrollPosition = val;
    notifyListeners();
  }

  void setPageIdx(int val) {
    currentPage = val;
    notifyListeners();
  }

  Future _getStyleupCommentList({bool viewLoading = true}) async {
    final user = userProvider.user;
    if (viewLoading) {
      setIsCommentLoading(true);
    }

    ApiHelper.shared.getStyleupCommentList(
        state.widget.styleupNo, user.memNo, 0, (comments) {
      commentList = [...comments];

      setIsCommentLoading(false);

      ShownyLog().i(
          'DEBUG: fetch comment succeed, styleupNo: ${state.widget.styleupNo}, data: $commentList');
    }, (error) {
      commentList = [];
      setIsCommentLoading(false);
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

    pageController.jumpToPage(1);
    getChildCommentList();
  }

  Future changeToComment() async {
    unfocusAll();
    pageController.jumpToPage(0);
    int idx = _findIndexWhereComment(parentComment?.styleupCommentNo ?? '-1');
    commentList[idx].childCommentList = [...childCommentList];

    setParentComment(null);
    childCommentList.clear();
    notifyListeners();
  }

  Future handleSendComment() async {
    if (commentController.getStatus.text.trim().isEmpty) return;

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
        ShownyLog().i("insertStyleupComment - 성공");
        if (currentPage == 0) {
          _getStyleupCommentList(viewLoading: false);
        } else {
          getChildCommentList();
        }
      },
      (error) {
        ShownyLog().e('error occured while delete styleup comment >> $error');
      },
    );
  }

  void showDeleteDialog(StyleupCommentModel comment) {
    showDialog(
      context: state.context,
      builder: (context) {
        return ShownyDialog(
          message: '게시글을 삭제하시겠습니까?',
          primaryLabel: '취소',
          secondaryLabel: '확인',
          secondaryAction: () {
            final user = userProvider.user;
            if (comment.userInfo.memNo != user.memNo) return;
            _postCommentDelete(comment);
          },
        );
      },
    );
  }

  void showReportBottomSheet(StyleupCommentModel comment) {
    showModalBottomSheet(
      context: state.context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      builder: (context) => SizedBox(
        height: 510,
        child: ReportSheetScreen(
          onCompleted: (type) {
            _postCommentReport(comment: comment, type: type);
          },
        ),
      ),
    );
  }

  void _postCommentDelete(StyleupCommentModel comment) {
    ApiHelper.shared.deleteStyleupComment(
      comment.userInfo.memNo,
      comment.styleupCommentNo,
      (success) {
        if (currentPage == 0) {
          // comment
          int idx = _findIndexWhereComment(comment.styleupCommentNo);
          if (idx == -1) return;
          commentList.removeAt(idx);
        } else {
          // recomment
          int idx = _findIndexWhereRecomment(comment.styleupCommentNo);
          if (idx == -1) return;
          childCommentList.removeAt(idx);
        }
        notifyListeners();
        showDialog(
            context: state.context,
            builder: (context3) {
              return ShownyDialog(
                message: '삭제가 완료되었습니다.',
                primaryLabel: '확인',
              );
            });
      },
      (error) {
        ShownyLog().e('error occured while delete styleup comment >> $error');
      },
    );
  }

  void _postCommentReport(
      {required StyleupCommentModel comment, required int type}) {
    final user = userProvider.user;
    ApiHelper.shared.insertStyleupCommentReport(
      int.parse(comment.styleupCommentNo),
      int.parse(user.memNo),
      type,
      (success) {
        ShownyLog().i('DEBUG: insert styleup comment report succeed');
        showDialog(
            context: state.context,
            builder: (context) {
              return ShownyDialog(
                message: '신고가 완료되었습니다.',
                primaryLabel: '확인',
                primaryAction: () {
                  Navigator.pop(context);
                },
              );
            });
      },
      (error) {
        ShownyLog().e('DEBUG: insert styleup comment report fail $error');
      },
    );
  }

  int _findIndexWhereComment(String commentNo) {
    int idx = commentList
        .indexWhere((element) => element.styleupCommentNo == commentNo);
    return idx;
  }

  int _findIndexWhereRecomment(String commentNo) {
    int idx = childCommentList
        .indexWhere((element) => element.styleupCommentNo == commentNo);
    return idx;
  }

  @override
  void notifyListeners() {
    if (state.mounted) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    pageController.dispose();
    commentController.dispose();
    super.dispose();
  }

  CommentSheetProvider(this.state) {
    userProvider = Provider.of<UserProvider>(state.context, listen: false);
    _getStyleupCommentList();
  }
}
