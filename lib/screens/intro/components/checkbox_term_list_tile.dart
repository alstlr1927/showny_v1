import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/constants.dart';
import 'package:showny/screens/common/components/page_route_builder_right_left.dart';
import 'package:showny/screens/intro/screen/term_page_screen.dart';

class CheckboxTermListTile extends StatelessWidget {
  const CheckboxTermListTile({
    super.key,
    required this.value,
    required this.title,
    required this.onChanged,
    required this.term,
  });

  final bool value;
  final String title;
  final Function(bool?) onChanged;
  final String term;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 0.0,
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      child: Row(
        children: [
          Icon(
            Icons.check_rounded,
            color: value ? Colors.black : const Color(0xFFCCCCCC),
            size: 20.0,
            weight: 1.0,
          ),
          const SizedBox(width: 8.0),
          Text(title, style: Constants.textFieldHintStyle),
          const Spacer(),
          CupertinoButton(
            minSize: 0.0,
            padding: EdgeInsets.zero,
            child: Image.asset(
              'assets/icons/chevron_right_rounded.png',
              color: const Color(0xFFCCCCCC),
              width: 16.0,
              height: 16.0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                ShownyPageRoute(
                  builder: (context) => TermPageScreen(term: term),
                ),
              );

              debugPrint('DEBUG: tab navigate to $title');
            },
          )
        ],
      ),
      onPressed: () {
        onChanged(!value);

        debugPrint('DEBUG: tab $title list tile');
      },
    );
  }
}
