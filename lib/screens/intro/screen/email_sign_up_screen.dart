import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/screens/common/components/page_route_builder_right_left.dart';
import 'package:showny/screens/common/components/sv_button.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';
import 'package:showny/screens/intro/components/sign_up_text_field.dart';
import 'package:showny/screens/intro/screen/email_sign_up2_screen.dart';

import '../../../utils/validator.dart';

class EmailSignUpScreen extends StatefulWidget {
  const EmailSignUpScreen({super.key});

  static String routeName = '/email_sign_up_screen';

  @override
  State<EmailSignUpScreen> createState() => _EmailSignUpScreenState();
}

class _EmailSignUpScreenState extends State<EmailSignUpScreen> {
  bool hasEmailFocus = false;
  bool hasPasswordFocus = false;
  bool hasDiffPassword = false;

  bool inValidEmail = false;
  bool inValidPassword = false;
  bool isDiffPassword = false;

  String email = '';
  String password = '';
  String passwordConfirm = '';

  bool checkCondition() {
    if (email.isNotEmpty &&
        password.isNotEmpty &&
        passwordConfirm.isNotEmpty &&
        !inValidEmail &&
        !inValidPassword &&
        !isDiffPassword) {
      return true;
    }

    return false;
  }

  void showAlertDialog(BuildContext context, {required ShownyDialog dialog}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  Widget accountInfoTextField() {
    return Column(
      children: [
        Focus(
          child: SignUpTextField(
            hintText: tr("signup1.email"),
            error: inValidEmail,
            errorText: tr("signup1.invalid_email"),
            onChanged: (text) {
              // setState(() => inValidEmail = false);
              email = text;
            },
          ),
          onFocusChange: (hasFocus) {
            setState(() => hasEmailFocus = hasFocus);
            if (hasFocus == false && email.isNotEmpty) {
              setState(() => inValidEmail = !Validator.isValidEmail(email));
            }
          },
        ),
        SizedBox(height: inValidEmail ? 8.0 : 16.0),
        Focus(
          child: SignUpTextField(
            hintText: tr("signup1.password"),
            error: inValidPassword,
            errorText: tr("signup1.invalid_password"),
            obscureText: true,
            onChanged: (text) {
              // setState(() => inValidPassword = false);
              password = text;
            },
          ),
          onFocusChange: (hasFocus) {
            setState(() => hasPasswordFocus = hasFocus);
            if (hasFocus == false && password.isNotEmpty) {
              setState(() =>
                  inValidPassword = !Validator.validPasswordPattern(password));
            }
          },
        ),
        SizedBox(height: inValidPassword ? 8.0 : 16.0),
        Focus(
          child: SignUpTextField(
            hintText: tr("signup1.confirm_password"),
            error: isDiffPassword,
            errorText: tr("signup1.password_mismatch"),
            obscureText: true,
            onChanged: (text) {
              // setState(() => isDiffPassword = false);
              passwordConfirm = text;
            },
          ),
          onFocusChange: (hasFocus) {
            setState(() => hasDiffPassword = hasFocus);
            if (hasFocus == false && passwordConfirm.isNotEmpty) {
              setState(() => isDiffPassword = (password != passwordConfirm));
            }
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(tr("signup1.information_input"),
          style: FontHelper.bold_16_000000,),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 40.0),
                accountInfoTextField(),
                const Spacer(),
                SVButton(
                  title: tr("signup1.next_button"),
                  titleColor:
                      checkCondition() ? Colors.white : const Color(0xFF555555),
                  backgroundColor:
                      checkCondition() ? Colors.black : const Color(0xFFEEEEEE),
                  onPressed: checkCondition()
                      ? () {
                          ApiHelper.shared.checkDuplicateEmail(email,
                              (success) {
                                Navigator.push(
                                  context, 
                                  PageRouteBuilderRightLeft(
                                  child: EmailSignUp2Screen(
                                    email: email,
                                    password: password,
                                    loginType: 'email',
                                    snsId: '',
                                  ),
                                ));
                          }, (error) {
                            final dialog = ShownyDialog(
                              message: error,
                              primaryLabel: tr("common.confirm"),
                            );

                            showAlertDialog(context, dialog: dialog);
                            debugPrint(error);
                          });
                          debugPrint('DEBUG: tab complete button');
                        }
                      : null,
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
