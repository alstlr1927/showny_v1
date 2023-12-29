import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/tabs/profile/provider/get_my_profile_provider.dart';

class ToolBox extends StatefulWidget {
  const ToolBox({
    super.key,
    required this.isVideo,
    required this.styleupNo,
    required this.memNo,
    required this.tapTag,
    required this.tapComment,
    required this.isBookmark,
    required this.tapBookmark,
    required this.tapShare,
    required this.tapSeeMore,
  });

  final bool isVideo;
  final String styleupNo;
  final String memNo;
  final bool isBookmark;
  final Function()? tapTag;
  final Function() tapComment;
  final Function(bool) tapBookmark;
  final Function() tapShare;
  final Function() tapSeeMore;

  @override
  State<ToolBox> createState() => _ToolBoxState();
}

class _ToolBoxState extends State<ToolBox> {
  late bool bookmark = widget.isBookmark;
  double interval = 30;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (widget.tapTag != null && widget.isVideo == false)
            CupertinoButton(
              minSize: 0.0,
              padding: EdgeInsets.zero,
              onPressed: widget.tapTag,
              child: Image.asset(
                'assets/icons/tag_white.png',
                width: 28.0,
                height: 28.0,
              ),
            ),
          SizedBox(height: interval),
          CupertinoButton(
            minSize: 0.0,
            padding: EdgeInsets.zero,
            onPressed: widget.tapComment,
            child: Image.asset(
              'assets/icons/comment.png',
              width: 28.0,
              height: 28.0,
            ),
          ),
          SizedBox(height: interval),
          CupertinoButton(
            minSize: 0.0,
            padding: EdgeInsets.zero,
            child: Image.asset(
              'assets/icons/bookmark${bookmark ? '_filled' : ''}.png',
              width: 28.0,
              height: 28.0,
            ),
            onPressed: () {
              setState(() => bookmark = !bookmark);
              widget.tapBookmark(bookmark);
              ApiHelper.shared.styleupBookmark(widget.styleupNo, user.memNo,
                  (success) {
                Provider.of<GetMyProfileProvider>(context, listen: false)
                    .removeMyBookmarkList();
                Provider.of<GetMyProfileProvider>(context, listen: false)
                    .getMyBookmarkList(context);
              }, (error) {});
            },
          ),
          SizedBox(height: interval),
          CupertinoButton(
            minSize: 0.0,
            padding: EdgeInsets.zero,
            onPressed: widget.tapShare,
            child: Image.asset(
              'assets/icons/share_shadow.png',
              width: 28.0,
              height: 28.0,
            ),
          ),
          SizedBox(height: interval),
          CupertinoButton(
            minSize: 0.0,
            padding: EdgeInsets.zero,
            onPressed: widget.tapSeeMore,
            child: Image.asset(
              'assets/icons/dots_vertical_shadow.png',
              width: 28.0,
              height: 28.0,
            ),
          ),
          const SizedBox(height: 150.0)
        ],
      ),
    );
  }
}
