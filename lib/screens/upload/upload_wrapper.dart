import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:showny/screens/upload/stylup_pick_image.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class UploadWrapper extends StatefulWidget {
  const UploadWrapper({super.key});

  @override
  State<UploadWrapper> createState() => _UploadWrapperState();
}

class _UploadWrapperState extends State<UploadWrapper> {
  int curIdx = 0;

  @override
  void initState() {
    super.initState();
  }

  void setStackIdx(int value) {
    curIdx = value;
    setState(() {});
  }

  String getTitle() {
    switch (curIdx) {
      case 0:
        return '스타일업';
      case 1:
        return '배틀';
      case 2:
        return '미니샵';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   scrolledUnderElevation: 0,
      //   title: Text(getTitle()),
      // ),
      body: Stack(
        children: [
          IndexedStack(
            index: curIdx,
            children: [
              const StylupPickImage(),
              Scaffold(
                appBar: AppBar(
                  title: const Text('배틀'),
                  scrolledUnderElevation: 0,
                ),
                body: Container(
                  color: Colors.red[100],
                  child: Center(
                    child: Text(
                      '배틀',
                      style: ShownyStyle.title(),
                    ),
                  ),
                ),
              ),
              Scaffold(
                appBar: AppBar(
                  title: const Text('미니샵'),
                  scrolledUnderElevation: 0,
                ),
                body: Container(
                  color: Colors.green[100],
                  child: Center(
                    child: Text(
                      '미니샵',
                      style: ShownyStyle.title(),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: ScreenUtil().screenWidth,
              height: 50,
              margin: EdgeInsets.only(
                bottom: ShownyStyle.safeAreaPadding(),
                right: 35.toWidth,
                left: 35.toWidth,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(.8),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildBottomButtonItem(
                    title: '스타일업',
                    idx: 0,
                  ),
                  SizedBox(width: 20.toWidth),
                  _buildBottomButtonItem(
                    title: '배틀',
                    idx: 1,
                  ),
                  SizedBox(width: 20.toWidth),
                  _buildBottomButtonItem(
                    title: '미니샵',
                    idx: 2,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtonItem({
    required String title,
    required int idx,
  }) {
    bool isTop = idx == curIdx;
    return GestureDetector(
      onTap: () {
        if (isTop) return;
        setStackIdx(idx);
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: 58.toWidth,
        height: 30,
        alignment: Alignment.center,
        child: Text(
          title,
          style: ShownyStyle.caption(
              color: isTop ? Colors.white : const Color(0xff868686),
              weight: isTop ? FontWeight.w700 : FontWeight.w400),
        ),
      ),
    );
  }
}
