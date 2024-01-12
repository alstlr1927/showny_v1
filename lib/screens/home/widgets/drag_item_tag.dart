import 'package:flutter/material.dart';
import 'package:showny/models/store_good_model.dart';

import 'package:showny/utils/showny_style.dart';

class DraggableTag extends StatefulWidget {
  final String goodsNm;
  final String price;
  final String size;
  final Function(Offset) onChangePosition;
  final StoreGoodModel goodsData;
  final Size viewSize;
  final bool moveTags;

  const DraggableTag({
    super.key,
    required this.goodsNm,
    required this.price,
    required this.size,
    required this.onChangePosition,
    required this.goodsData,
    required this.viewSize,
    this.moveTags = false,
  });

  @override
  _DraggableTagState createState() => _DraggableTagState();
}

class _DraggableTagState extends State<DraggableTag> {
  late Offset position;

  @override
  void initState() {
    super.initState();
    double xPosition = widget.goodsData.left * widget.viewSize.width;
    double yPosition = widget.goodsData.top * widget.viewSize.height;
    debugPrint(xPosition.toString());
    debugPrint(yPosition.toString());
    position = Offset(xPosition, yPosition);
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: widget.moveTags == true
          ? Draggable(
              childWhenDragging: Container(),
              feedback: tagWidget(
                goodsNm: widget.goodsNm,
                price: widget.price,
                size: widget.size,
              ),
              child: tagWidget(
                goodsNm: widget.goodsNm,
                price: widget.price,
                size: widget.size,
              ),
              onDraggableCanceled: (velocity, offset) {
                setState(() {
                  RenderBox renderBox = context.findRenderObject() as RenderBox;
                  position = renderBox.globalToLocal(
                      Offset(offset.dx + position.dx, offset.dy + position.dy));
                  widget.onChangePosition(position);
                });
              },
            )
          : tagWidget(
              goodsNm: widget.goodsNm,
              price: widget.price,
              size: widget.size,
            ),
    );
  }
}

Widget tagWidget({
  required String goodsNm,
  required String price,
  required String size,
}) {
  return Material(
    color: Colors.transparent,
    child: Container(
      width: 130,
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.6),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            goodsNm,
            style: ShownyStyle.overline(color: ShownyStyle.gray030),
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 2.0),
          Text(
            price,
            style: ShownyStyle.overline(
                color: ShownyStyle.gray030, weight: FontWeight.bold),
          ),
          if (size != "") const SizedBox(height: 2.0),
          if (size != "")
            Text(
              '$size 사이즈',
              style: ShownyStyle.overline(
                color: ShownyStyle.gray030,
                weight: FontWeight.bold,
              ),
            ),
        ],
      ),
    ),
  );
}
