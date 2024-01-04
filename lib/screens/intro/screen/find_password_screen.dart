import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/constants.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/screens/common/components/page_route_builder_right_left.dart';
import 'package:showny/screens/common/components/sv_button.dart';
import 'package:showny/screens/intro/screen/sign_up_screen.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';
import 'package:showny/screens/intro/components/sign_up_text_field.dart';
import 'package:showny/screens/intro/screen/email_login_screen.dart';
import 'package:showny/screens/intro/screen/send_reset_password_mail_screen.dart';
import 'package:showny/utils/showny_style.dart';

import '../../../utils/validator.dart';

class FindPasswordScreen extends StatefulWidget {
  const FindPasswordScreen({
    super.key,
    required this.recentRouteName,
  });

  final String recentRouteName;

  @override
  State<FindPasswordScreen> createState() => _FindPasswordScreenState();
}

class _FindPasswordScreenState extends State<FindPasswordScreen> {
  bool isLoading = false;

  bool inValidEmail = false;
  bool inValidEmailSub = false;
  String email = '';

  static String routeName = '/find_password';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            tr("find_password_screen.find_password"),
            style: FontHelper.bold_16_000000,
          ),
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Image.asset(
              'assets/icons/back_button.png',
              width: 20.0,
              height: 20.0,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 40.0),
                Focus(
                  child: SignUpTextField(
                    hintText: tr("find_password_screen.email_hint"),
                    error: inValidEmail,
                    errorText: tr("find_password_screen.invalid_email"),
                    onChanged: (text) {
                      setState(() => inValidEmail = false);
                      inValidEmailSub = !Validator.isValidEmail(email);
                      email = text;
                    },
                  ),
                  onFocusChange: (hasFocus) {
                    if (hasFocus == false && email.isNotEmpty) {
                      setState(
                          () => inValidEmail = !Validator.isValidEmail(email));
                    }
                  },
                ),
                const Spacer(),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  decoration: ShapeDecoration(
                    color: const Color(0xFFEEEEEE),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  child: Text(
                    tr("find_password_screen.reset_email_description"),
                    textAlign: TextAlign.center,
                    style: Constants.textFieldErrorStyle,
                  ),
                ),
                const SizedBox(height: 12.0),
                SVButton(
                  title: tr("find_password_screen.reset_email_button"),
                  isLoading: isLoading,
                  titleColor: (email.isNotEmpty && !inValidEmailSub)
                      ? Colors.white
                      : const Color(0xFF555555),
                  backgroundColor: (email.isNotEmpty && !inValidEmailSub)
                      ? ShownyStyle.mainPurple
                      : const Color(0xFFEEEEEE),
                  onPressed: () {
                    isLoading = true;

                    ApiHelper.shared.findPassword(email, (success) {
                      Navigator.push(
                          context,
                          PageRouteBuilderRightLeft(
                            child: SendResetPasswordMailScreen(
                              sendSuccess: success,
                              recentRouteName: EmailLoginScreen.routeName,
                              mailAddress: email,
                            ),
                          ));
                      isLoading = false;
                    }, (error) {
                      var dialog = ShownyDialog(
                        message: tr("find_password_screen.not_found_email"),
                        primaryRoute: routeName,
                        secondaryRoute: SignUpScreen.routeName,
                        primaryLabel: tr("common.cancel"),
                        secondaryLabel: tr("find_password_screen.signup"),
                      );

                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return dialog;
                        },
                      );
                      isLoading = false;
                    });

                    debugPrint('DEBUG: tab reset password button');
                  },
                ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
