import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/bottom_sheet/theme/bottom_sheet_theme.dart';
import 'package:showny/components/indicator/showny_indicator.dart';
import 'package:showny/components/slivers/sliver_tween.dart';
import 'package:showny/models/styleup_comment_model.dart';
import 'package:showny/screens/common/comment_sheet/providers/comment_sheet_provider.dart';
import 'package:showny/screens/common/comment_sheet/widgets/comment_tile.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class RecommentPage extends StatefulWidget {
  final StyleupCommentModel? parent;
  final List<StyleupCommentModel> recommentList;
  final ScrollController controller;
  const RecommentPage({
    super.key,
    this.parent,
    required this.recommentList,
    required this.controller,
  });

  @override
  State<RecommentPage> createState() => _RecommentPageState();
}

class _RecommentPageState extends State<RecommentPage> {
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
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            // SliverToBoxAdapter(
            //   child: SizedBox(
            //     height: 22.toWidth,
            //   ),
            // ),
            if (widget.parent != null)
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 0.toWidth),
                sliver: SliverToBoxAdapter(
                  child: CommentTile.parent(
                    comment: widget.parent!,
                    onClickHeart: (flag) {
                      prov.setCommentData(
                          flag: flag,
                          commentNo: widget.parent!.styleupCommentNo);
                    },
                  ),
                ),
              ),
            if (prov.isRecommentLoading) ...{
              SliverToBoxAdapter(
                child: Container(
                  margin: EdgeInsets.only(top: 160),
                  child: ShownyIndicator(),
                ),
              ),
            } else ...{
              SliverTween(
                duration: const Duration(milliseconds: 200),
                child: SliverPadding(
                  padding: EdgeInsets.only(left: 34.toWidth, right: 0.toWidth),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                        widget.recommentList.map((item) {
                      return CommentTile.recomment(
                        comment: item,
                        onClickHeart: (flag) {
                          prov.setRecommentData(
                              flag: flag, commentNo: item.styleupCommentNo);
                        },
                        onClickRecomment: () {
                          prov.showReportBottomSheet(item);
                        },
                        onClickDelete: () {
                          prov.showDeleteDialog(item);
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
