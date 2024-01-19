import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/user_profile/profile_container.dart';
import 'package:showny/models/user_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/utils/formatter.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

import '../../../../models/styleup_comment_model.dart';
import '../../../home/widgets/report_sheet_screen.dart';

enum CommentType { comment, recomment, parent }

class CommentTile extends StatefulWidget {
  final StyleupCommentModel comment;
  final CommentType type;
  final Function()? onClickRecomment;
  final Function(bool flag)? onClickHeart;
  final VoidCallback? onClickDelete;
  final VoidCallback? onClickReport;

  const CommentTile.comment({
    Key? key,
    required this.comment,
    this.onClickRecomment,
    this.onClickHeart,
    this.onClickDelete,
    this.onClickReport,
  })  : type = CommentType.comment,
        super(key: key);

  const CommentTile.recomment({
    Key? key,
    required this.comment,
    this.onClickRecomment,
    this.onClickHeart,
    this.onClickDelete,
    this.onClickReport,
  })  : type = CommentType.recomment,
        super(key: key);

  const CommentTile.parent({
    Key? key,
    required this.comment,
    this.onClickRecomment,
    this.onClickHeart,
    this.onClickDelete,
    this.onClickReport,
  })  : type = CommentType.parent,
        super(key: key);

  @override
  State<CommentTile> createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    StyleupCommentModel comment = widget.comment;
    UserModel commentUser = widget.comment.userInfo;
    return Slidable(
      enabled: widget.type != CommentType.parent,
      endActionPane: ActionPane(
        extentRatio: 0.2,
        motion: const BehindMotion(),
        children: [
          user.memNo == commentUser.memNo
              ? _slideDeleteButton()
              : _slideReportButton()
        ],
      ),
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: 10.toWidth, horizontal: 16.toWidth),
        width: double.infinity,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileContainer.size24(
                    url: commentUser.profileImage,
                  ),
                  SizedBox(width: 10.toWidth),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              commentUser.memNm,
                              style: ShownyStyle.caption(
                                  color: ShownyStyle.gray080,
                                  weight: FontWeight.w700),
                            ),
                            SizedBox(width: 6.toWidth),
                            Text(
                              Formatter.convertToRelativeTime(
                                  DateTime.parse(comment.createdAt)),
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
                            if (widget.type == CommentType.comment)
                              CupertinoButton(
                                onPressed: () {
                                  if (widget.onClickRecomment != null) {
                                    widget.onClickRecomment!();
                                  }
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
                        if (comment.childCommentList.isNotEmpty &&
                            widget.type == CommentType.comment) ...{
                          SizedBox(height: 10.toWidth),
                          CupertinoButton(
                            onPressed: () {
                              if (widget.onClickRecomment != null) {
                                widget.onClickRecomment!();
                              }
                            },
                            minSize: 0,
                            padding: EdgeInsets.zero,
                            child: Text(
                              '답글 ${comment.childCommentList.length}개 더 보기',
                              style: ShownyStyle.caption(
                                  color: ShownyStyle.gray080),
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
                  onPressed: () {
                    if (widget.onClickHeart != null) {
                      widget.onClickHeart!(!comment.isHeart);
                    }
                  },
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
      ),
    );
  }

  Widget _slideDeleteButton() {
    return Builder(builder: (context) {
      return Expanded(
        child: CupertinoButton(
          minSize: 0.0,
          padding: EdgeInsets.zero,
          color: const Color(0xFFF14545),
          borderRadius: BorderRadius.zero,
          onPressed: () {
            Slidable.of(context)?.close();
            widget.onClickDelete?.call();
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/trash.png',
                width: 24.0,
                height: 24.0,
              ),
              const SizedBox(height: 8.0),
              Text(
                '삭제하기',
                style: ShownyStyle.overline(color: ShownyStyle.white),
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _slideReportButton() {
    return Builder(builder: (context) {
      return Expanded(
        child: CupertinoButton(
          minSize: 0.0,
          padding: EdgeInsets.zero,
          color: const Color(0xFFEEEEEE),
          borderRadius: BorderRadius.zero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/report.png',
                width: 24.0,
                height: 24.0,
              ),
              const SizedBox(height: 8.0),
              Text(
                '신고하기',
                style: ShownyStyle.overline(color: Color(0xFFAAAAAA)),
              ),
            ],
          ),
          onPressed: () {
            Slidable.of(context)?.close();
            widget.onClickReport?.call();
          },
        ),
      );
    });
  }
}
