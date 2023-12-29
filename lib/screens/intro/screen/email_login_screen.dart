import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/screens/common/components/page_route_builder_right_left.dart';
import 'package:showny/screens/common/components/sv_button.dart';
import 'package:showny/screens/intro/components/login_text_field.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';
import 'package:showny/screens/intro/screen/find_password_screen.dart';
import 'package:showny/screens/intro/screen/input_additional_information_screen.dart';
import 'package:showny/screens/intro/screen/input_essential_information_screen.dart';
import 'package:showny/screens/root_screen.dart';
import 'package:provider/provider.dart';
import 'package:showny/providers/user_model_provider.dart';

import '../../../constants.dart';
import '../../../utils/validator.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  static String routeName = '/email_login_screen';

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  bool isError = false;
  bool canProceedLogin = false;

  String email = '';
  String password = '';

  bool isLoggingIn = false;

  static const storage = FlutterSecureStorage();

  void checkLoginCondition() {
    setState(
      () => canProceedLogin = Validator.canProceedLogin(
        email: email,
        password: password,
      ),
    );
  }

  void showAlertDialog(BuildContext context, {required ShownyDialog dialog}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  Future<bool> loginAction({
    required String loginType,
    required String email,
    required String password,
    required String snsId
  }) async {
    try {
      await storage.write(
        key: "loginType", 
        value: loginType
      );
      await storage.write(
        key: 'email',
        value: email,
      );
      await storage.write(
        key: 'password',
        value: password,
      );
      await storage.write(
        key: "snsId", 
        value: snsId
      );
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Widget forgotPasswordButton() {
    return CupertinoButton(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            tr("email_login.forgot_password"),
            textAlign: TextAlign.center,
            style: Constants.defaultTextStyle.copyWith(fontSize: 12.0),
          ),
          const SizedBox(height: 6.0),
          Container(
            width: 142,
            height: 1,
            color: Colors.black,
          )
        ],
      ),
      onPressed: () {
        Navigator.push(
          context, 
          PageRouteBuilderRightLeft(
          child: FindPasswordScreen(recentRouteName: EmailLoginScreen.routeName),
        ));

        debugPrint('DEBUG: tab skip login button');
      },
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
          leading: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Image.asset(
              'assets/icons/back_button.png',
              width: 20.0,
              height: 20.0,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 48),
                  Image.asset(
                    'assets/logos/showny.png',
                    width: 158,
                    height: 24,
                  ),
                  const SizedBox(height: 80.0),
                  Focus(
                    child: LoginTextField(
                      hintText: tr("email_login.email_hint"),
                      error: isError,
                      errorText: tr("email_login.invalid_email"),
                      onChanged: (text) {
                        setState(() => isError = false);
                        email = text;
                        checkLoginCondition();
                      },
                    ),
                    onFocusChange: (hasFocus) {
                      if (hasFocus == false && email.isNotEmpty) {
                        setState(
                          () => isError = !Validator.isValidEmail(email),
                        );
                      }
                    },
                  ),
                  SizedBox(height: isError ? 8.0 : 16.0),
                  LoginTextField(
                    hintText: tr("email_login.password_hint"),
                    obscureText: true,
                    onChanged: (text) {
                      password = text;
                      checkLoginCondition();
                    },
                  ),
                  const Spacer(),
                  SVButton(
                    title: tr("email_login.login"),
                    isLoading: isLoggingIn,
                    titleColor: canProceedLogin ? Colors.white : Colors.black,
                    backgroundColor: canProceedLogin
                        ? Colors.black
                        : const Color(0xFFEEEEEE),
                    onPressed: canProceedLogin
                        ? () async {
                            setState(() => isLoggingIn = true);
                            if (canProceedLogin) {
                              ApiHelper.shared.signinEmail(email, password,
                                  (userModel) async {
                                Provider.of<UserProvider>(context,
                                        listen: false)
                                    .updateUserInfo(userModel);
                                // Provider.of<ChatStyleProvider>(context, listen: false).initChat(userModel.memNo, userModel.nickNm, userModel.profileImage);

                                if (await loginAction(
                                        loginType: "email", email: email, password: password, snsId: "") ==
                                    true) {
                                  // userProvider에 저장
                                  debugPrint('Login Success');
                                  if (mounted) {
                                    if (userModel.birthday == "") {
                                      Navigator.push(
                                        context,
                                        PageRouteBuilderRightLeft(child: const InputEssentialInfoScreen()));
                                    } else if (userModel.colorIdList.isEmpty) {
                                      var dialog = ShownyDialog(
                                        message: tr("intro_popup.not_found_style_title"),
                                        subMessage:
                                             tr("intro_popup.not_found_style_content"),
                                        primaryLabel: tr("intro_popup.not_found_style_button1"),
                                        secondaryLabel: tr("intro_popup.not_found_style_button2"),
                                        primaryRoute:
                                            InputAdditionalInfoScreen.routeName,
                                        secondaryRoute: RootScreen.routeName,
                                        primaryAction: () {},
                                      );
                                      showAlertDialog(context, dialog: dialog);
                                    } else {
                                      Constants.currentUser = userModel;
                                      Navigator.pushNamedAndRemoveUntil(
                                        context,
                                        RootScreen.routeName,
                                        (route) => false,
                                      );
                                    }
                                  }
                                }
                                setState(() => isLoggingIn = false);
                              }, (error) {
                                setState(() {
                                    isLoggingIn = false;
                                  });
                                ApiHelper.shared.checkDuplicateEmail(email,
                                    (success) {
                                  var dialog = ShownyDialog(
                                    message: tr("email_login.email_not_exist"),
                                    primaryLabel: tr("common.confirm"),
                                  );

                                  showAlertDialog(context, dialog: dialog);
                                }, (error) {
                                  var dialog = ShownyDialog(
                                    message: tr("email_login.incorrect_password"),
                                    primaryLabel: tr("common.confirm"),
                                  );

                                  showAlertDialog(context, dialog: dialog);
                                });
                              });
                            }

                            debugPrint(
                              'DEBUG: tab login button: ${canProceedLogin ? 'Valid' : 'Invalid'}',
                            );
                          }
                        : null,
                  ),
                  forgotPasswordButton(),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
