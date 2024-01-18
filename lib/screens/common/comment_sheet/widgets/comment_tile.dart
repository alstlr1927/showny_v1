import 'package:flutter/cupertino.dart';
import 'package:showny/components/user_profile/profile_container.dart';
import 'package:showny/models/user_model.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

import '../../../../models/styleup_comment_model.dart';

class CommentTile extends StatefulWidget {
  final StyleupCommentModel comment;
  final bool isRecomment;
  final Function(String commentNo) onClickRecomment;

  const CommentTile.comment({
    Key? key,
    required this.comment,
    required this.onClickRecomment,
  })  : isRecomment = false,
        super(key: key);

  const CommentTile.recomment({
    Key? key,
    required this.comment,
    required this.onClickRecomment,
  })  : isRecomment = true,
        super(key: key);

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  @override
  Widget build(BuildContext context) {
    StyleupCommentModel comment = widget.comment;
    UserModel user = widget.comment.userInfo;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.toWidth),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProfileContainer.size24(
                  url: user.profileImage,
                ),
                SizedBox(width: 10.toWidth),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            user.memNm,
                            style: ShownyStyle.caption(
                                color: ShownyStyle.gray080,
                                weight: FontWeight.w700),
                          ),
                          SizedBox(width: 6.toWidth),
                          Text(
                            '01.12',
                            style: ShownyStyle.overline(
                              color: ShownyStyle.gray060,
                              weight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.toWidth),
                      Text(
                        comment.detail,
                        style: ShownyStyle.caption(color: ShownyStyle.black),
                      ),
                      SizedBox(height: 4.toWidth),
                      Row(
                        children: [
                          Text(
                            '좋아요 ${comment.heartCount}개',
                            style: ShownyStyle.caption(
                              color: ShownyStyle.gray060,
                            ),
                          ),
                          SizedBox(width: 8.toWidth),
                          if (!widget.isRecomment)
                            CupertinoButton(
                              onPressed: () {
                                widget
                                    .onClickRecomment(comment.styleupCommentNo);
                              },
                              minSize: 0,
                              padding: EdgeInsets.zero,
                              child: Text(
                                '답글 달기',
                                style: ShownyStyle.caption(
                                  color: ShownyStyle.gray060,
                                ),
                              ),
                            ),
                        ],
                      ),
                      if (comment.childCommentList.isNotEmpty) ...{
                        SizedBox(height: 10.toWidth),
                        CupertinoButton(
                          onPressed: () {
                            widget.onClickRecomment(comment.styleupCommentNo);
                          },
                          minSize: 0,
                          padding: EdgeInsets.zero,
                          child: Text(
                            '답글 ${comment.childCommentList.length}개 더 보기',
                            style:
                                ShownyStyle.caption(color: ShownyStyle.gray080),
                          ),
                        ),
                      },
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              CupertinoButton(
                onPressed: () {},
                child: Image.asset(
                  comment.isHeart
                      ? 'assets/icons/home/comment_like.png'
                      : 'assets/icons/home/comment_unlike.png',
                  width: 15.toWidth,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
