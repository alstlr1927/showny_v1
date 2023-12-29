import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/constants.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';
import 'package:showny/screens/tabs/home/screen/report_sheet_screen.dart';

class SeeMoreActionSheet extends StatefulWidget {
  const SeeMoreActionSheet({
    super.key,
    this.styleupNo,
    this.memNo,
    this.report = false,
    required this.primaryLabel,
    this.primaryAction,
    this.secondaryLabel,
    this.secondaryAction,
  });

  final String? styleupNo;
  final String? memNo;
  final bool report;
  final String primaryLabel;
  final Widget? secondaryLabel;
  final Function()? primaryAction;
  final Function()? secondaryAction;

  @override
  State<SeeMoreActionSheet> createState() => _SeeMoreActionSheetState();
}

class _SeeMoreActionSheetState extends State<SeeMoreActionSheet> {
  @override
  Widget build(BuildContext context) {
    final buttonStyle = Constants.defaultTextStyle.copyWith(fontSize: 12.0);

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: MediaQuery.of(context).size.width - 32.0,
            height: 48,
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: Column(
              children: [
                if (widget.secondaryLabel != null)
                  ActionSheetButton(
                      label: widget.secondaryLabel!,
                      action: widget.secondaryAction),
                if (widget.secondaryLabel != null)
                  Container(
                    width: MediaQuery.of(context).size.width - 32.0,
                    height: 1.0,
                    color: const Color(0xFF999999),
                  ),
                ActionSheetButton(
                  label: Text(
                    widget.primaryLabel,
                    style: buttonStyle,
                  ),
                  action: () {
                    if (widget.primaryAction != null) {
                      widget.primaryAction!();
                    } else {
                      if (widget.report) {
                        showModalBottomSheet(
                          context: context,
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
                                      widget.styleupNo!,
                                      widget.memNo!,
                                      type + 1, (success) {
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
                      }
                    }

                    // Navigator.pop(context);
                  },
                )
              ],
            ),
          ),
          const SizedBox(height: 16.0),
          CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              width: double.infinity,
              height: 48.0,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Center(
                child: Text(
                  '취소',
                  style: buttonStyle,
                ),
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          const SizedBox(height: 6.0),
        ],
      ),
    );
  }
}

class ActionSheetButton extends StatelessWidget {
  const ActionSheetButton({
    super.key,
    required this.label,
    required this.action,
  });

  final Widget label;
  final Function()? action;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      onPressed: action,
      pressedOpacity: (action != null) ? 0.4 : 1.0,
      child: Container(
        width: double.infinity,
        color: Colors.white,
        child: Center(child: label),
      ),
    );
  }
}
