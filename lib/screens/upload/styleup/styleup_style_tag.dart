import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/models/style.dart';
import 'package:showny/screens/common/components/style_button.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class StyleupStyleTag extends StatefulWidget {
  final List<Style> selectedStyles;
  final Function(List<Style>) onSelected;

  const StyleupStyleTag({
    super.key,
    required this.selectedStyles,
    required this.onSelected,
  });

  @override
  State<StyleupStyleTag> createState() => _StyleupStyleTagState();
}

class _StyleupStyleTagState extends State<StyleupStyleTag> {
  List<Style> selectedStyles = [];

  @override
  void initState() {
    super.initState();
    selectedStyles = [...widget.selectedStyles];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('스타일'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 35.toWidth),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                tr('profile_edit.upTo_five_style_can_selected'),
                style: ShownyStyle.caption(color: ShownyStyle.black),
              ),
            ),
            SizedBox(height: 24.toWidth),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: Style.values.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                childAspectRatio:
                    (MediaQuery.of(context).size.width - 56.0) / 4 / 40,
                mainAxisSpacing: 8.0,
                crossAxisSpacing: 8.0,
              ),
              itemBuilder: (BuildContext context, int index) {
                return StyleButton(
                  style: Style.values[index],
                  selectedStyles: selectedStyles,
                  onPressed: (style) {
                    setState(() {
                      if (selectedStyles.contains(style)) {
                        selectedStyles.remove(style);
                      } else {
                        if (selectedStyles.length < 5) {
                          selectedStyles.add(style);
                        }
                      }
                    });
                  },
                );
              },
            ),
            const Spacer(),
            Row(
              children: [
                ShownyButton(
                  onPressed: () {
                    selectedStyles.clear();
                    setState(() {});
                    widget.onSelected(selectedStyles);
                  },
                  option: ShownyButtonOption.fill(
                    text: '초기화',
                    theme: ShownyButtonFillTheme.gray,
                    style: ShownyButtonFillStyle.regular,
                  ),
                ),
                SizedBox(width: 8.toWidth),
                Expanded(
                  child: ShownyButton(
                    onPressed: () {
                      widget.onSelected(selectedStyles);
                      showSelectDialog();
                    },
                    option: ShownyButtonOption.fill(
                      text: '변경',
                      theme: ShownyButtonFillTheme.violet,
                      style: ShownyButtonFillStyle.fullRegular,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: ShownyStyle.defaultBottomPadding() + 24.toWidth,
            )
          ],
        ),
      ),
    );
  }

  void showSelectDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return const ShownyDialog(
          message: '스타일 선택이 완료되었습니다.',
          primaryLabel: '확인',
        );
      },
    ).then((value) {
      Navigator.pop(context);
    });
  }
}
