import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/constants.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:provider/provider.dart';

class FollowingButton extends StatefulWidget {
  const FollowingButton({
    super.key,
    required this.isFollow,
    required this.memNo,
    required this.onCompleted,
  });

  final bool isFollow;
  final String memNo;
  final Function(bool) onCompleted;

  @override
  State<FollowingButton> createState() => _FollowingButtonState();
}

class _FollowingButtonState extends State<FollowingButton> {
  late bool isFollow = widget.isFollow;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    return isFollow == false
        ? CupertinoButton(
            minSize: 0.0,
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 3.0),
            color: Colors.black.withOpacity(0.4),
            borderRadius: BorderRadius.circular(2.0),
            child: Text(
              isFollow == true ? '팔로잉' : '팔로우',
              style: Constants.defaultTextStyle.copyWith(
                color: Colors.white,
                fontSize: 11,
              ),
            ),
            onPressed: () {
              ApiHelper.shared.followUser(
                  user.memNo, widget.memNo, (success) {}, (error) {});
              setState(() => isFollow = true);
              widget.onCompleted(isFollow);
            },
          )
        : const SizedBox();
  }
}
