import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/components/error/image_error.dart';
import 'package:showny/models/styleup_battle_item_model.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/providers/battle_item_provider.dart';

class BattleUser extends StatefulWidget {
  final double defaultImgWidth;
  final StyleupBattleItemModel item;
  final bool isLeft;
  const BattleUser.left({
    Key? key,
    required this.item,
    required this.defaultImgWidth,
  })  : isLeft = true,
        super(key: key);

  const BattleUser.right({
    Key? key,
    required this.item,
    required this.defaultImgWidth,
  })  : isLeft = false,
        super(key: key);

  @override
  State<BattleUser> createState() => _BattleUserState();
}

class _BattleUserState extends State<BattleUser> {
  final double imgRatio = 9 / 16;
  final Duration aniDuration = const Duration(milliseconds: 200);
  double rating = 0.0;
  late StyleupModel styleup;
  int pollCnt = 0;
  int otherPollCnt = 0;
  @override
  void initState() {
    if (widget.isLeft) {
      styleup = widget.item.styleup1;
      pollCnt = widget.item.style1PollCnt;
      otherPollCnt = widget.item.style2PollCnt;
    } else {
      styleup = widget.item.styleup2;
      pollCnt = widget.item.style2PollCnt;
      otherPollCnt = widget.item.style1PollCnt;
    }
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  Widget build(BuildContext context) {
    BattleItemProvider prov =
        Provider.of<BattleItemProvider>(context, listen: false);
    bool isFinished = widget.item.isPoll;
    bool isWin = false;
    if (widget.isLeft) {
      isWin = widget.item.pollTag == 1;
    } else {
      isWin = widget.item.pollTag == 2;
    }
    return SlideTransition(
      position: widget.isLeft ? prov.positionA : prov.positionB,
      child: ScaleTransition(
        scale: widget.isLeft ? prov.scaleAnimationA : prov.scaleAnimationB,
        child: SizedBox(
          width: widget.defaultImgWidth,
          height: widget.defaultImgWidth * (16 / 9),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: widget.defaultImgWidth,
                  height: widget.defaultImgWidth * (16 / 9),
                  child: Image.network(
                    styleup.thumbnailUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const ImageError(),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: AnimatedSize(
                  duration: aniDuration,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Colors.black.withOpacity(.6),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 6),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(200),
                                child: Image.network(
                                  // 'assets/images/${widget.player.image}',
                                  styleup.userInfo.profileImage,
                                  width: 24,
                                  height: 24,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const ImageError(),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  styleup.userInfo.memNm,
                                  style: const TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isFinished && isWin) ...{
                          LayoutBuilder(
                            builder: (context, layout) {
                              WidgetsBinding.instance
                                  .addPersistentFrameCallback((timeStamp) {
                                rating = pollCnt / (pollCnt + otherPollCnt);
                                setState(() {});
                              });
                              return Row(
                                children: [
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 400),
                                    width: layout.maxWidth * rating,
                                    height: 27,
                                    alignment: Alignment.centerLeft,
                                    padding: const EdgeInsets.only(left: 14),
                                    decoration: BoxDecoration(
                                      color: const Color(0xff5900FF),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          const Color(0xff5900FF)
                                              .withOpacity(.3),
                                          const Color(0xff5900FF)
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      rating == 0
                                          ? ''
                                          : '${getRatingInteger(my: pollCnt, other: otherPollCnt)}%',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        },
                      ],
                    ),
                  ),
                ),
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: AnimatedContainer(
                  duration: aniDuration,
                  width: widget.defaultImgWidth,
                  height: widget.defaultImgWidth * (16 / 9),
                  color: isFinished && !isWin
                      ? Colors.black.withOpacity(.4)
                      : Colors.transparent,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int getRatingInteger({int my = 0, int other = 0}) {
    int total = my + other;
    double rate = my / total;
    return (rate * 100.0).toInt();
  }
}
