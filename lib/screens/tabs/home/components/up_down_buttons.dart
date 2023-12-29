import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/intro/screen/login_popup_screen.dart';
import 'package:showny/screens/tabs/profile/profile_not_logged_in_screen.dart';

class UpDownButtons extends StatefulWidget {
  const UpDownButtons({
    super.key, 
    required this.styleup,
    required this.onCompleted,
  });

  final StyleupModel styleup;
  final Function(int) onCompleted;

  @override
  State<UpDownButtons> createState() => _UpDownButtonsState();
}

class _UpDownButtonsState extends State<UpDownButtons> {
  int upDownType = 0;

  @override void initState() {
    super.initState();
    upDownType = widget.styleup.upDownType;
  }

  @override
  Widget build(BuildContext context) {
    upDownType = widget.styleup.upDownType;
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Flexible(
            child: CupertinoButton(
              onPressed: () {
                UserProvider userProvider =
                Provider.of<UserProvider>(context, listen: false);
                final user = userProvider.user;

                debugPrint(user.memNo);
                if (user.memNo == "") {
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
                      return const LoginPopupScreen();
                  });
                } else {
                  ApiHelper.shared.styleupUpDown(
                    widget.styleup.styleupNo,
                    userProvider.user.memNo,
                    2,
                    (success) {},
                    (error) {}
                  );
                  setState(() => upDownType = 2);
                  widget.onCompleted(2);
                }
              },
              padding: EdgeInsets.zero,
              minSize: 0,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'DOWN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    shadows: [
                      if (upDownType == 0) ...[
                        const Shadow(
                          blurRadius: 4.0,
                          color: Colors.black87,
                        ),
                      ],
                      if (upDownType == 2) ...[
                        const Shadow(
                          // bottomLeft
                            offset: Offset(-1, -1),
                            color: Colors.black),
                        const Shadow(
                          // bottomRight
                            offset: Offset(1, -1),
                            color: Colors.black),
                        const Shadow(
                          // topRight
                            offset: Offset(1, 1),
                            color: Colors.black),
                        const Shadow(
                          // topLeft
                            offset: Offset(-1, 1),
                            color: Colors.black),
                      ],
                    ],
                    color: upDownType == 1 ? Colors.grey : Colors.white,
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'SF Compact',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 24,
            width: 1,
            decoration: const BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 2,
                  color: Colors.black87,
                )
              ],
            ),
          ),
          Flexible(
            child: CupertinoButton(
              onPressed: () {
                UserProvider userProvider =
                Provider.of<UserProvider>(context, listen: false);
                final user = userProvider.user;

                debugPrint(user.memNo);
                if (user.memNo == "") {
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
                      return const LoginPopupScreen();
                  });
                } else {
                    ApiHelper.shared.styleupUpDown(
                    widget.styleup.styleupNo,
                    userProvider.user.memNo,
                    1,
                    (success) {},
                    (error) {}
                  );

                  setState(() => upDownType = 1);
                  widget.onCompleted(1);
                }
              },
              padding: EdgeInsets.zero,
              minSize: 0,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: Text(
                  'UP',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    shadows: [
                      if (upDownType == 0) ...[
                        const Shadow(
                          blurRadius: 4.0,
                          color: Colors.black87,
                        ),
                      ],
                      if (upDownType == 1) ...[
                        const Shadow(
                          // bottomLeft
                            offset: Offset(-1, -1),
                            color: Colors.black),
                        const Shadow(
                          // bottomRight
                            offset: Offset(1, -1),
                            color: Colors.black),
                        const Shadow(
                          // topRight
                            offset: Offset(1, 1),
                            color: Colors.black),
                        const Shadow(
                          // topLeft
                            offset: Offset(-1, 1),
                            color: Colors.black),
                      ],
                    ],
                    color: upDownType == 2 ? Colors.grey : Colors.white,
                    fontSize: 24,
                    fontStyle: FontStyle.italic,
                    fontFamily: 'SF Compact',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
