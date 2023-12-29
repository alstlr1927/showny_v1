import 'package:flutter/cupertino.dart';
import 'package:showny/constants.dart';
import 'package:showny/models/battle_model.dart';
import 'package:showny/utils/formatter.dart';

class BattleItem extends StatelessWidget {
  const BattleItem({
    super.key,
    required this.onSelected,
    required this.selectedBattleNo,
    required this.battleData,
  });

  final Function(String battleNo) onSelected;
  final String? selectedBattleNo;
  final BattleModel battleData;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 114,
            height: 178,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(battleData.thumbnailUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8.0),
          SizedBox(
            width: 114,
            child: Center(
              child: Builder(builder: (context) {
                if (selectedBattleNo == battleData.styleupBattleNo) {
                  return Image.asset(
                    'assets/icons/check_circle.png',
                    width: 16.7,
                    height: 16.7,
                  );
                } else {
                  return Container(
                    width: 16.67,
                    height: 16.67,
                    decoration: const ShapeDecoration(
                      shape: OvalBorder(
                        side: BorderSide(
                          width: 1,
                          strokeAlign: BorderSide.strokeAlignCenter,
                        ),
                      ),
                    ),
                  );
                }
              }),
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            '모집기간 ${Formatter.formatDateString(battleData.recruitmentStart)} - ${Formatter.formatDateString(battleData.recruitmentEnd)}',
            style: Constants.defaultTextStyle.copyWith(
              fontSize: 10.0,
              color: const Color(0xFF555555),
            ),
          ),
          const SizedBox(height: 11.0),
          Text(
            '배틀시작 ${Formatter.formatDateString(battleData.participationStart)}',
            style: Constants.defaultTextStyle.copyWith(
              fontSize: 10.0,
              color: const Color(0xFF555555),
            ),
          )
        ],
      ),
      onPressed: () {
        onSelected(battleData.styleupBattleNo);
      },
    );
  }
}
