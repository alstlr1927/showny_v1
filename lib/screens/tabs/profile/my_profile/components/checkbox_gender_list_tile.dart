import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CheckboxGenderListTile extends StatelessWidget {
  const CheckboxGenderListTile({
    super.key,
    required this.value,
    required this.title,
    required this.onChanged,
  });

  final bool value;
  final String title;
  final Function(bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      color: const Color(0xFFEEEEEE),
      borderRadius: BorderRadius.circular(12),
      minSize: 48.0,
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: Colors.white,
            child: Icon(
              Icons.check_rounded,
              color:
                  value ? Colors.black : const Color(0xFFCCCCCC).withAlpha(0),
              size: 20.0,
              weight: 1.0,
            ),
          ),
          const SizedBox(width: 12.0),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 14,
              fontFamily: 'Spoqa Han Sans Neo',
              fontWeight: FontWeight.w400,
            ),
          ),
          const Spacer()
        ],
      ),
      onPressed: () {
        onChanged(!value);

        debugPrint('DEBUG: tab $title list tile');
      },
    );
  }
}
