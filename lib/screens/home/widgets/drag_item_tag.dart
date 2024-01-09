import 'package:flutter/material.dart';
import 'package:showny/models/goods_data.dart';

class DraggableTag extends StatefulWidget {
  final String goodsNm;
  final String price;
  final String size;
  final Function(Offset) onChangePosition;
  final GoodsData goodsData;
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
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
    decoration: BoxDecoration(
      color: Colors.white.withOpacity(1.0),
      borderRadius: BorderRadius.circular(12.0),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 5,
          blurRadius: 7,
          offset: const Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          goodsNm,
          style: const TextStyle(
              color: Color(0xff000000),
              fontSize: 12.0,
              decoration: TextDecoration.none),
        ),
        const SizedBox(height: 2.0),
        Text(
          price,
          style: const TextStyle(
              color: Color(0xFF444444),
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.none),
        ),
        if (size != "") const SizedBox(height: 2.0),
        if (size != "")
          Text(
            size,
            style: const TextStyle(
                color: Color(0xff000000),
                fontSize: 12.0,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.none),
          ),
      ],
    ),
  );
}
