import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/constants.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class ShownyDialog extends StatelessWidget {
  const ShownyDialog({
    super.key,
    required this.message,
    this.subMessage,
    required this.primaryLabel,
    this.secondaryLabel,
    this.primaryRoute,
    this.secondaryRoute,
    this.primaryAction,
    this.secondaryAction,
  });

  final String message;
  final String? subMessage;
  final String primaryLabel;
  final String? secondaryLabel;
  final String? primaryRoute;
  final String? secondaryRoute;
  final Function()? primaryAction;
  final Function()? secondaryAction;

  void navigateTo(BuildContext context, String? routeName) {
    if (routeName != null) {
      Navigator.pushNamedAndRemoveUntil(context, routeName, (route) => false);
    }
  }

  Widget actionButton(
    BuildContext context, {
    required String label,
    required Function() onPressed,
    String? routeName,
  }) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: SizedBox(
        height: 48.toWidth,
        child: Center(
          child:
              Text(label, style: ShownyStyle.body2(color: ShownyStyle.black)),
        ),
      ),
      onPressed: () {
        onPressed();
        Navigator.pop(context);
        navigateTo(context, routeName);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shadowColor: Colors.transparent,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        width: 310.toWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: 32.toWidth, horizontal: 16.toWidth),
              child: Column(
                children: [
                  Text(
                    message,
                    style: ShownyStyle.body2(color: ShownyStyle.black),
                    textAlign: TextAlign.center,
                  ),
                  if (subMessage != null) const SizedBox(height: 8.0),
                  if (subMessage != null)
                    Text(
                      subMessage!,
                      style: ShownyStyle.caption(color: ShownyStyle.black),
                      textAlign: TextAlign.center,
                    ),
                ],
              ),
            ),
            Container(
              color: const Color(0xFF999999),
              width: 310.toWidth,
              height: 1.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: actionButton(context,
                      label: primaryLabel,
                      routeName: primaryRoute, onPressed: () {
                    if (primaryAction != null) {
                      primaryAction!();
                    }

                    debugPrint('DEBUG: tab $primaryLabel button');
                  }),
                ),
                if (secondaryLabel != null)
                  Container(
                    width: 1.0,
                    height: 48.toWidth,
                    color: const Color(0xFF999999),
                  ),
                if (secondaryLabel != null)
                  Expanded(
                    child: actionButton(context,
                        routeName: secondaryRoute,
                        label: secondaryLabel!, onPressed: () {
                      if (secondaryAction != null) {
                        secondaryAction!();
                      }

                      debugPrint('DEBUG: tab $secondaryLabel button');
                    }),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
