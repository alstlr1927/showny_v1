import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/tabs/profile/provider/get_my_profile_provider.dart';
import 'package:showny/utils/showny_util.dart';

class ToolBox extends StatefulWidget {
  const ToolBox({
    super.key,
    required this.upDownType,
    required this.isVideo,
    required this.styleupNo,
    required this.memNo,
    required this.tapTag,
    required this.tapComment,
    required this.isBookmark,
    required this.tapBookmark,
    required this.tapShare,
    required this.tapSeeMore,
    required this.tapUpDown,
  });

  final int upDownType;
  final bool isVideo;
  final String styleupNo;
  final String memNo;
  final bool isBookmark;
  final Function()? tapTag;
  final Function() tapComment;
  final Function(bool) tapBookmark;
  final Function() tapShare;
  final Function() tapSeeMore;
  final Function(int) tapUpDown;

  @override
  State<ToolBox> createState() => _ToolBoxState();
}

class _ToolBoxState extends State<ToolBox> {
  late bool bookmark = widget.isBookmark;
  double interval = 20.toWidth;

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
          if (widget.upDownType != 0) ...{
            CupertinoButton(
              minSize: 0.0,
              padding: EdgeInsets.zero,
              onPressed: () {
                if (widget.upDownType == 1) {
                  widget.tapUpDown(2);
                } else {
                  widget.tapUpDown(1);
                }
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: widget.upDownType == 1
                    ? Image.asset(
                        'assets/icons/home/styleup_up.png',
                        width: 28.0,
                        height: 28.0,
                      )
                    : Image.asset(
                        'assets/icons/home/styleup_down.png',
                        width: 28.0,
                        height: 28.0,
                      ),
              ),
            ),
          },
          SizedBox(height: interval),
          if (widget.tapTag != null && widget.isVideo == false) ...{
            CupertinoButton(
              minSize: 0.0,
              padding: EdgeInsets.zero,
              onPressed: widget.tapTag,
              child: Image.asset(
                'assets/icons/home/toolbox_tag.png',
                width: 26.toWidth,
                height: 26.toWidth,
              ),
            ),
            SizedBox(height: interval),
          },
          CupertinoButton(
            minSize: 0.0,
            padding: EdgeInsets.zero,
            onPressed: widget.tapComment,
            child: Image.asset(
              'assets/icons/home/toolbox_comment.png',
              width: 26.toWidth,
              height: 26.toWidth,
            ),
          ),
          SizedBox(height: interval),
          CupertinoButton(
            minSize: 0.0,
            padding: EdgeInsets.zero,
            child: Image.asset(
              'assets/icons/home/toolbox_bookmark_${bookmark ? 'on' : 'off'}.png',
              // 'assets/icons/bookmark${bookmark ? '_filled' : ''}.png',
              width: 26.toWidth,
              height: 26.toWidth,
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
              'assets/icons/home/toolbox_share.png',
              width: 26.toWidth,
              height: 26.toWidth,
            ),
          ),
          SizedBox(height: interval),
          CupertinoButton(
            minSize: 0.0,
            padding: EdgeInsets.zero,
            onPressed: widget.tapSeeMore,
            child: Image.asset(
              'assets/icons/home/toolbox_more.png',
              width: 26.toWidth,
              height: 26.toWidth,
            ),
          ),
          const SizedBox(height: 150.0)
        ],
      ),
    );
  }
}
