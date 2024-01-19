import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/indicator/showny_indicator.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/components/slivers/sliver_tween.dart';
import 'package:showny/models/styleup_comment_model.dart';
import 'package:showny/screens/common/comment_sheet/providers/comment_sheet_provider.dart';
import 'package:showny/screens/common/comment_sheet/widgets/comment_tile.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

import '../../../../components/bottom_sheet/theme/bottom_sheet_theme.dart';

class CommentPage extends StatefulWidget {
  final List<StyleupCommentModel> commentList;
  final ScrollController controller;
  const CommentPage({
    super.key,
    required this.commentList,
    required this.controller,
  });

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  @override
  Widget build(BuildContext context) {
    CommentSheetProvider prov =
        Provider.of<CommentSheetProvider>(context, listen: false);
    return Material(
      color: BottomSheetThemeColor.sheet_base_white,
      child: LazyLoadScrollView(
        onEndOfPage: () {},
        child: CustomScrollView(
          controller: widget.controller,
          slivers: [
            if (prov.isCommentLoading) ...{
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(top: 200),
                  child: ShownyIndicator(),
                ),
              ),
            } else ...{
              // SliverToBoxAdapter(
              //   child: SizedBox(
              //     height: 22.toWidth,
              //   ),
              // ),
              SliverTween(
                duration: const Duration(milliseconds: 200),
                child: SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 0.toWidth),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                        widget.commentList.reversed.map((item) {
                      return CommentTile.comment(
                        comment: item,
                        onClickRecomment: () {
                          prov.changeToRecomment(item);
                        },
                        onClickHeart: (bool flag) {
                          prov.setCommentData(
                              flag: flag, commentNo: item.styleupCommentNo);
                        },
                        onClickDelete: () {
                          prov.showDeleteDialog(item);
                        },
                        onClickReport: () {
                          prov.showReportBottomSheet(item);
                        },
                      );
                    }).toList()),
                  ),
                ),
              ),
            },
            SliverToBoxAdapter(
              child: SizedBox(
                height: ShownyStyle.defaultBottomPadding() + 70.toWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
