import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/screens/common/components/sv_button.dart';
import 'package:showny/screens/intro/components/checkbox_term_list_tile.dart';

import '../../../../constants.dart';

class TermSheet extends StatefulWidget {
  const TermSheet({super.key, required this.onCompleted});

  final void Function(String value) onCompleted;

  @override
  State<TermSheet> createState() => _TermSheetState();
}

class _TermSheetState extends State<TermSheet> {
  bool agreePrivacy = false;
  bool agreeTerm = false;
  bool agreeMarketing = false;

  Widget checkAllAgree() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      pressedOpacity: 1.0,
      child: Container(
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Color(0xFFCCCCCC),
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              if (agreePrivacy && agreeTerm && agreeMarketing)
                Image.asset(
                  'assets/icons/check_circle.png',
                  width: 24.0,
                  height: 24.0,
                )
              else
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Container(
                    width: 20.0,
                    height: 20.0,
                    decoration: const ShapeDecoration(
                      shape: CircleBorder(
                        side: BorderSide(color: Color(0xFFCCCCCC), width: 1.0),
                      ),
                    ),
                  ),
                ),
              const SizedBox(width: 8.0),
              Text(tr("terms_screen.agree_all"),
                  style: Constants.textFieldHintStyle),
            ],
          ),
        ),
      ),
      onPressed: () {
        final newValue = (agreePrivacy && agreeTerm && agreeMarketing);
        setState(() {
          agreePrivacy = !newValue;
          agreeTerm = !newValue;
          agreeMarketing = !newValue;
        });

        debugPrint('DEBUG: tab agree all');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.all(7.0),
                  child: Icon(
                    Icons.close_rounded,
                    color: Colors.transparent,
                  ),
                ),
                Text(tr("terms_screen.terms_agree"),
                    style: FontHelper.bold_16_000000),
                CupertinoButton(
                  padding: const EdgeInsets.all(7.0),
                  child: const Icon(
                    Icons.close_rounded,
                    weight: 2.0,
                    color: Colors.black,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16.0),
            checkAllAgree(),
            const SizedBox(height: 13.0),
            CheckboxTermListTile(
              value: agreePrivacy,
              title: tr("terms_screen.privacy1"),
              term: "privacy",
              onChanged: (newValue) {
                setState(() => agreePrivacy = newValue!);
              },
            ),
            const SizedBox(height: 8.0),
            CheckboxTermListTile(
              value: agreeTerm,
              title: tr("terms_screen.terms1"),
              term: "terms",
              onChanged: (newValue) {
                setState(() => agreeTerm = newValue!);
              },
            ),
            const SizedBox(height: 8.0),
            CheckboxTermListTile(
              value: agreeMarketing,
              title: tr("terms_screen.marketing1"),
              term: "marketing",
              onChanged: (newValue) {
                setState(() => agreeMarketing = newValue!);
              },
            ),
            const Spacer(),
            ShownyButton(
              onPressed: () {
                if (agreePrivacy && agreeTerm) {
                  Navigator.pop(context);
                  widget.onCompleted(agreeMarketing ? '1' : '0');
                }

                debugPrint('DEBUG: tab agree button');
              },
              option: ShownyButtonOption.fill(
                text: tr("terms_screen.agree"),
                theme: ShownyButtonFillTheme.violet,
                style: ShownyButtonFillStyle.fullRegular,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
