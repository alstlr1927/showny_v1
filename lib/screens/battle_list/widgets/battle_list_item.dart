import 'package:flutter/material.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/components/showny_image/showny_image.dart';
import 'package:showny/models/battle_model.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class BattleListItem extends StatefulWidget {
  final BattleModel battleData;
  final VoidCallback? onClickItemButton;
  const BattleListItem({
    super.key,
    required this.battleData,
    required this.onClickItemButton,
  });

  @override
  State<BattleListItem> createState() => _BattleListItemState();
}

class _BattleListItemState extends State<BattleListItem> {
  @override
  Widget build(BuildContext context) {
    BattleModel battle = widget.battleData;
    return Container(
      margin: EdgeInsets.only(top: 32.toWidth),
      height: 154.toWidth,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: ShownyImage(
              width: 100.toWidth,
              height: 154.toWidth,
              imageUrl: battle.thumbnailUrl,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 15.toWidth),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.battleData.title}',
                  style: ShownyStyle.body2(
                      color: ShownyStyle.black, weight: FontWeight.w700),
                ),
                const Spacer(),
                Row(
                  children: [
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'adsfsdfasdfasdf',
                          style: ShownyStyle.caption(),
                        ),
                        // SizedBox(height: 6.toWidth),
                        // Container(
                        //   width: 120.toWidth,
                        //   child: ShownyButton(
                        //     onPressed: () {},
                        //     option: ShownyButtonOption.fill(
                        //       text: '참여완료',
                        //       theme: ShownyButtonFillTheme.black,
                        //       style: ShownyButtonFillStyle.fullSmall,
                        //     ),
                        //   ),
                        // ),
                        SizedBox(height: 6.toWidth),
                        _buildStatusButton(battle.status),
                        // Container(
                        //   width: 120.toWidth,
                        //   child: ShownyButton(
                        //     onPressed: () {},
                        //     option: ShownyButtonOption.fill(
                        //       text:
                        //           '${ShownyUtil.battleStatusString(battle.status)}',
                        //       theme: ShownyButtonFillTheme.coral,
                        //       style: ShownyButtonFillStyle.small,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusButton(String status) {
    return Container(
      width: 120.toWidth,
      child: ShownyButton(
        onPressed: () {
          widget.onClickItemButton?.call();
        },
        option: ShownyButtonOption.fill(
          text: ShownyUtil.battleStatusString(status),
          theme: getButtonTheme(status),
          style: ShownyButtonFillStyle.small,
        ),
      ),
    );
  }

  ShownyButtonFillTheme getButtonTheme(String status) {
    switch (status) {
      case '0':
        return ShownyButtonFillTheme.black;
      case '1':
        return ShownyButtonFillTheme.violet;
      case '2':
        return ShownyButtonFillTheme.black;
      case '3':
        return ShownyButtonFillTheme.coral;
      case '4':
        return ShownyButtonFillTheme.gray;
      default:
        return ShownyButtonFillTheme.black;
    }
  }
}
