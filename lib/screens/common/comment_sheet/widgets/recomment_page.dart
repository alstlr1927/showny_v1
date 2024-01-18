import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/bottom_sheet/theme/bottom_sheet_theme.dart';
import 'package:showny/components/slivers/sliver_tween.dart';
import 'package:showny/models/styleup_comment_model.dart';
import 'package:showny/screens/common/comment_sheet/providers/comment_sheet_provider.dart';
import 'package:showny/screens/common/comment_sheet/widgets/comment_tile.dart';
import 'package:showny/utils/showny_util.dart';

class RecommentPage extends StatefulWidget {
  final List<StyleupCommentModel> recommentList;
  const RecommentPage({
    super.key,
    required this.recommentList,
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
          slivers: [
            SliverTween(
              child: SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                sliver: SliverList(
                  delegate:
                      SliverChildListDelegate(widget.recommentList.map((item) {
                    return CommentTile.recomment(
                      comment: item,
                      onClickRecomment: (String commentNo) {
                        prov.changeToRecomment(commentNo);
                      },
                    );
                  }).toList()),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
