import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';
import 'package:showny/screens/tabs/home/components/see_more_action_sheet.dart';
import 'package:showny/screens/tabs/home/screen/report_sheet_screen.dart';
import 'package:showny/screens/tabs/home/screen/styleup_item.dart';

class StyleUpItemProvider with ChangeNotifier {
  State<StyleUpItem> state;

  double virtualPadAreaDiameter = 130.0;
  double movePadDiameter = 70.0;

  bool isSelectMode = false;
  int selected = 0;
  double standardPosition = 0.0;
  Duration longPressDuration = const Duration(milliseconds: 100);

  // drag event 관련 좌표
  Offset startPosition = Offset.zero;
  Offset movePosition = Offset.zero;

  bool showTags = false;

  void test(bool value) {
    state.widget.styleUp.userInfo.isFollow = value;
    notifyListeners();
  }

  void setShowTags(bool value) {
    showTags = value;

    //  update showMenu
    notifyListeners();
  }

  void setSelected({required int value}) {
    if (selected == value) return;
    selected = value;
    HapticFeedback.lightImpact();
  }

  void setMovePosition(Offset value) {
    // 현재 좌표 값 value.dx, value.dy
    // 기준 좌표 값 startPosition.dx, startPosition.dy
    // 반지름 : diameter / 2
    double dx = value.dx - startPosition.dx;
    double dy = value.dy - startPosition.dy;

    double distance = sqrt(dx * dx + dy * dy);
    if (distance > virtualPadAreaDiameter / 2 - movePadDiameter / 2) {
      double angle = atan2(dy, dx);
      dx = cos(angle) * (virtualPadAreaDiameter / 2 - movePadDiameter / 2);
      dy = sin(angle) * (virtualPadAreaDiameter / 2 - movePadDiameter / 2);
      movePosition = Offset(startPosition.dx + dx, startPosition.dy + dy);
    } else {
      movePosition = value;
    }
  }

  void onLongPress() {
    isSelectMode = true;
    HapticFeedback.lightImpact();
    notifyListeners();
  }

  void onLongPressStart(LongPressStartDetails details) {
    standardPosition = details.localPosition.dy;
    startPosition = Offset(details.localPosition.dx, details.localPosition.dy);
    movePosition = Offset(details.localPosition.dx, details.localPosition.dy);

    notifyListeners();
  }

  void onLongPressCancel() {
    isSelectMode = false;
    notifyListeners();
  }

  void onLongPressMoveUpdate(LongPressMoveUpdateDetails details) {
    setMovePosition(Offset(details.localPosition.dx, details.localPosition.dy));

    if (details.localPosition.dy < standardPosition - 10) {
      setSelected(value: 1);
    } else if (details.localPosition.dy > standardPosition + 10) {
      setSelected(value: 2);
    }
    notifyListeners();
  }

  Future onLongPressEnd(LongPressEndDetails details) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(state.context, listen: false);
    if (selected == 1) {
      // ToastMsg.showToast(
      //   msg: 'UP 하셨습니다!',
      //   backgroundColor: Colors.black.withOpacity(.7),
      //   textColor: Colors.white,
      // );

      ApiHelper.shared.styleupUpDown(
        state.widget.styleUp.styleupNo,
        userProvider.user.memNo,
        1,
        (success) {
          state.widget.styleUp.upDownType = 1;
          state.widget.onSelect?.call();
          notifyListeners();
        },
        (error) {
          // 서버 오류 메시지
          debugPrint('error : ${error.toString()}');
        },
      );
    } else if (selected == 2) {
      ApiHelper.shared.styleupUpDown(
        state.widget.styleUp.styleupNo,
        userProvider.user.memNo,
        2,
        (success) {
          // updown type = 2
          state.widget.styleUp.upDownType = 2;
          // next page
          state.widget.onSelect?.call();
          notifyListeners();
        },
        (error) {
          // 서버 오류 메시지
          debugPrint('error : ${error.toString()}');
        },
      );
      // ToastMsg.showToast(
      //   msg: 'DOWN 하셨습니다!',
      //   backgroundColor: Colors.black.withOpacity(.7),
      //   textColor: Colors.white,
      // );
    }

    selected = 0;
    standardPosition = 0.0;
    notifyListeners();
  }

  void onLongPressUp() {
    isSelectMode = false;
    notifyListeners();
  }

  void onClickTag() {
    setShowTags(true);
  }

  void onClickComment({required String styleupNo, required String memNo}) {
    // showModalBottomSheet(
    //   context: state.context,
    //   isScrollControlled: true,
    //   backgroundColor: Colors.transparent,
    //   useRootNavigator: true,
    //   isDismissible: true,
    //   enableDrag: false,
    //   builder: (context) {
    //     return CommentSheetScreen(
    //         memNo: memNo,
    //         styleupNo: styleupNo,
    //         onAddComment: () => setState(() {}));
    //   },
    // );
  }

  void onClickBookMark(bool flag) {
    state.widget.styleUp.isBookmark = flag;
    notifyListeners();
  }

  void onClickShare() {
    Share.share('https://www.instagram.com/outfitbattles_korea/');
  }

  void onClickMore(
      {required String styleupNo,
      required String contentMemNo,
      required String memNo,
      required int index}) {
    final bool isMine = (contentMemNo == memNo);

    showModalBottomSheet(
      context: state.context,
      useRootNavigator: true,
      enableDrag: false,
      backgroundColor: Colors.transparent,
      builder: (context2) {
        return SizedBox(
          height: 210.0,
          child: SeeMoreActionSheet(
            styleupNo: styleupNo,
            memNo: memNo,
            report: isMine ? false : true,
            primaryLabel: isMine ? '삭제하기' : '신고하기',
            primaryAction: () {
              isMine
                  ?
                  //삭제
                  showDialog(
                      context: state.context,
                      builder: (context3) {
                        return ShownyDialog(
                          message: '게시글을 삭제하시겠습니까?',
                          primaryLabel: '취소',
                          secondaryLabel: '확인',
                          secondaryAction: () {
                            ApiHelper.shared.deleteStyleup(memNo, styleupNo,
                                (success) {
                              showDialog(
                                  context: state.context,
                                  builder: (context2) {
                                    return ShownyDialog(
                                      message: '삭제가 완료되었습니다.',
                                      primaryLabel: '확인',
                                      primaryAction: () {
                                        Navigator.pop(state.context);
                                        // styleupList.removeAt(index);
                                        // debugPrint(
                                        //     styleupList.length.toString());
                                        // debugPrint(
                                        //     styleupList.length.toString());
                                        // Provider.of<GetMyProfileProvider>(
                                        //         context,
                                        //         listen: false)
                                        //     .removeMyStyleupList();
                                        // Provider.of<GetMyProfileProvider>(
                                        //         context,
                                        //         listen: false)
                                        //     .getMyStyleupList(context);
                                        // Provider.of<GetMyProfileProvider>(
                                        //         context,
                                        //         listen: false)
                                        //     .removeMyBookmarkList();
                                        // Provider.of<GetMyProfileProvider>(
                                        //         context,
                                        //         listen: false)
                                        //     .getMyBookmarkList(context);
                                        // // swiperController.move(index, animation: true);
                                        // if (styleupList.isEmpty &&
                                        //     widget.isMain == false) {
                                        //   Navigator.pop(tempContext);
                                        // }
                                      },
                                    );
                                  });
                            }, (error) {
                              debugPrint(error);
                            });
                          },
                        );
                      })
                  :
                  //신고
                  showModalBottomSheet(
                      context: state.context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(12.0),
                          topRight: Radius.circular(12.0),
                        ),
                      ),
                      builder: (BuildContext context) {
                        return SizedBox(
                          height: 510.0,
                          child: ReportSheetScreen(
                            onCompleted: (int type) {
                              ApiHelper.shared.insertStyleupReport(
                                  styleupNo, memNo, type + 1, (success) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ShownyDialog(
                                        message: '신고가 완료되었습니다.',
                                        primaryLabel: '확인',
                                        primaryAction: () {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                      );
                                    });
                              }, (error) {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return ShownyDialog(
                                        message: error,
                                        primaryLabel: '확인',
                                      );
                                    });
                              });
                            },
                          ),
                        );
                      },
                    );
            },
          ),
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

  StyleUpItemProvider(this.state);
}
