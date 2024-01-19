import 'package:flutter/material.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/utils/formatter.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

import '../../../components/showny_image/showny_image.dart';
import '../../../models/battle_model.dart';

class BattleSliderItem extends StatefulWidget {
  final BattleModel item;
  final VoidCallback? onClickListener;
  const BattleSliderItem({
    super.key,
    required this.item,
    this.onClickListener,
  });

  @override
  State<BattleSliderItem> createState() => _BattleSliderItemState();
}

class _BattleSliderItemState extends State<BattleSliderItem> {
  bool isInfoMode = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        isInfoMode = !isInfoMode;
        setState(() {});
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: ShownyImage(
                imageUrl: widget.item.thumbnailUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            opacity: isInfoMode ? 1 : 0,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: ShownyStyle.black.withOpacity(.85),
              ),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 20.toWidth),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${widget.item.progress}',
                            style: ShownyStyle.body1(
                                color: ShownyStyle.white,
                                weight: FontWeight.w700),
                          ),
                          Text(
                            '${ShownyUtil.formatDateString(widget.item.participationEnd)} 까지',
                            style: ShownyStyle.body1(
                                color: ShownyStyle.white,
                                weight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 35.toWidth, horizontal: 30.toWidth),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '투표오픈 : ${ShownyUtil.formatDateString(widget.item.participationStart)}',
                            style:
                                ShownyStyle.caption(color: ShownyStyle.white),
                          ),
                          SizedBox(height: 8.toWidth),
                          ShownyButton(
                            onPressed: () {
                              if (!isInfoMode) {
                                isInfoMode = true;
                                setState(() {});
                                return;
                              }
                              widget.onClickListener?.call();
                            },
                            option: ShownyButtonOption.fill(
                              text: ShownyUtil.battleStatusString(
                                  widget.item.status),
                              theme: ShownyButtonFillTheme.coral,
                              style: ShownyButtonFillStyle.fullSmall,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
