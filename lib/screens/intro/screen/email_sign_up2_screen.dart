import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/constants.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/common/components/page_route_builder_right_left.dart';
import 'package:showny/screens/common/components/sv_button.dart';
import 'package:showny/screens/intro/screen/term_sheet_screen.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';
import 'package:showny/screens/intro/components/sign_up_text_field.dart';
import 'package:showny/screens/intro/screen/input_essential_information_screen.dart';
import 'package:showny/utils/formatter.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/validator.dart';
import 'package:provider/provider.dart';

class EmailSignUp2Screen extends StatefulWidget {
  const EmailSignUp2Screen(
      {super.key,
      required this.email,
      required this.password,
      required this.loginType,
      required this.snsId});

  static String routeName = '/email_sign_up2_screen';

  final String loginType;
  final String snsId;
  final String email;
  final String password;

  @override
  State<EmailSignUp2Screen> createState() => _EmailSignUp2ScreenState();
}

class _EmailSignUp2ScreenState extends State<EmailSignUp2Screen> {
  static const storage = FlutterSecureStorage();

  bool inValidName = false;
  bool inValidCode = true;

  String name = '';
  String phoneNumber = '';
  String validationCode = '';
  String errorStr = '';

  int remainSeconds = 300;
  bool isTimerRunning = false;
  bool validPhoneNum = false;
  bool sendOtpNum = false;
  bool inValidOtp = true;
  bool verifyOtp = false;
  late Timer timer;

  String? _verificationId;

  void signIn(String email, String password) {
    ApiHelper.shared.signinEmail(email, password, (userModel) {
      Provider.of<UserProvider>(context, listen: false)
          .updateUserInfo(userModel);
      // Provider.of<ChatStyleProvider>(context, listen: false).initChat(userModel.memNo, userModel.nickNm, userModel.profileImage);
    }, (error) {});
  }

  void signinSns(loginType, snsId) async {
    ApiHelper.shared.signinSns(snsId, loginType, (userModel) async {
      Provider.of<UserProvider>(context, listen: false)
          .updateUserInfo(userModel);
      // Provider.of<ChatStyleProvider>(context, listen: false).initChat(userModel.memNo, userModel.nickNm, userModel.profileImage);
    }, (error) {});
  }

  void showTermSheet(BuildContext context, void Function(String) onCompleted) {
    showModalBottomSheet<void>(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(12.0),
          topRight: Radius.circular(12.0),
        ),
      ),
      builder: (BuildContext context) {
        return TermSheet(onCompleted: (value) {
          onCompleted(value);
        });
      },
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

  bool checkCondition() {
    if (verifyOtp && !inValidOtp && Validator.validNamePattern(name)) {
      return true;
    }

    return false;
  }

  void startTimer() {
    resetTimer();
    isTimerRunning = true;
    setState(() => sendOtpNum = true);
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (remainSeconds == 0) {
          errorStr = tr("email_sign_up_screen2.verification_time_error");
          inValidCode = true;

          isTimerRunning = false;
          timer.cancel();
        } else {
          remainSeconds--;
        }
      });
    });
  }

  void resetTimer() {
    if (isTimerRunning) {
      timer.cancel();
    }
    setState(() => remainSeconds = 300);
  }

  Future<bool> loginAction(
      {required String loginType,
      required String email,
      required String password,
      required String snsId}) async {
    try {
      await storage.write(key: "loginType", value: loginType);
      await storage.write(
        key: 'email',
        value: email,
      );
      await storage.write(
        key: 'password',
        value: password,
      );
      await storage.write(key: "snsId", value: snsId);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  @override
  void dispose() {
    if (isTimerRunning) {
      timer.cancel();
    }
    super.dispose();
  }

  Future<void> signInWithSmsCode(String code) async {
    if (_verificationId != null) {
      FirebaseAuth auth = FirebaseAuth.instance;
      PhoneAuthCredential _phoneCredential = PhoneAuthProvider.credential(
          verificationId: _verificationId!, smsCode: code);
      try {
        UserCredential _user =
            await auth.signInWithCredential(_phoneCredential);
        setState(() {
          inValidCode = false;
          verifyOtp = true;
        });
      } catch (error) {
        var dialog = ShownyDialog(
          message: tr("email_sign_up_screen2.invalid_code_error"),
          primaryLabel: tr("common.confirm"),
        );
        if (!mounted) return;
        showAlertDialog(context, dialog: dialog);
      }
    }
  }

  Widget phoneNumberTextField() {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: SignUpTextField(
            hintText: tr("email_sign_up_screen2.phone_number"),
            onChanged: (text) {
              phoneNumber = text;
              setState(() {
                if (Validator.validatePhoneNumber(phoneNumber)) {
                  validPhoneNum = true;
                } else {
                  sendOtpNum = false;
                  validPhoneNum = false;
                }
              });
            },
          ),
        ),
        const SizedBox(width: 8.0),
        CupertinoButton(
          padding: EdgeInsets.zero,
          child: Container(
            decoration: ShapeDecoration(
              color: verifyOtp
                  ? const Color(0xFFEEEEEE)
                  : sendOtpNum
                      ? Colors.white
                      : validPhoneNum
                          ? ShownyStyle.mainPurple
                          : const Color(0xFFEEEEEE),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: verifyOtp
                      ? Colors.transparent
                      : sendOtpNum
                          ? ShownyStyle.mainPurple
                          : Colors.transparent,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            width: 120.0,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: Text(
                verifyOtp
                    ? tr("email_sign_up_screen2.otp_confirmation")
                    : sendOtpNum
                        ? tr("email_sign_up_screen2.resend_otp")
                        : tr("email_sign_up_screen2.send_otp"),
                style: Constants.defaultTextStyle.copyWith(
                  color: verifyOtp
                      ? const Color(0xFF555555)
                      : sendOtpNum
                          ? ShownyStyle.mainPurple
                          : validPhoneNum
                              ? Colors.white
                              : const Color(0xFF555555),
                ),
              ),
            ),
          ),
          onPressed: () {
            if (verifyOtp == true) {
              return;
            }
            if (validPhoneNum) {
              ApiHelper.shared.verifyPhoneNumberSend(phoneNumber, (success) {
                FirebaseAuth auth = FirebaseAuth.instance;
                auth.verifyPhoneNumber(
                    timeout: const Duration(seconds: 120),
                    phoneNumber: "+82$phoneNumber",
                    verificationCompleted: (PhoneAuthCredential credential) {
                      debugPrint("credential :: $credential");
                    },
                    verificationFailed: (FirebaseAuthException exception) {
                      debugPrint("exception :: $exception");
                      var dialog = ShownyDialog(
                        message:
                            tr("email_sign_up_screen2.invalid_phone_number"),
                        primaryLabel: tr("common.confirm"),
                      );
                      showAlertDialog(context, dialog: dialog);
                    },
                    codeSent: (String verificationId, int? resendToken) {
                      _verificationId = verificationId;
                      debugPrint("verificationId :: $verificationId");
                      debugPrint("resendToken :: $resendToken");
                      var dialog = ShownyDialog(
                        message: tr("email_sign_up_screen2.send_otp_complete"),
                        primaryLabel: tr("common.confirm"),
                      );

                      showAlertDialog(context, dialog: dialog);
                      startTimer();
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {
                      debugPrint("verificationId :: $verificationId");
                    });
              }, (error) {
                debugPrint(error); // 전송 실패
                var dialog = ShownyDialog(
                  message: error,
                  primaryLabel: tr("common.confirm"),
                );
                showAlertDialog(context, dialog: dialog);
              });
            }

            setState(() => verifyOtp = false);

            debugPrint('DEBUG: tab send otp code');
          },
        ),
      ],
    );
  }

  Widget otpTextField() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: SignUpTextField(
            hintText: tr("email_sign_up_screen2.otp"),
            maxLength: 6,
            error: inValidCode,
            errorText: errorStr,
            suffix: verifyOtp
                ? null
                : Text(
                    Formatter.formatIntInMSs(remainSeconds),
                    style: Constants.textFieldHintStyle
                        .copyWith(fontFamily: 'Poppins', height: 1.0),
                  ),
            onChanged: (text) {
              setState(() {
                inValidCode = false;
                verifyOtp = false;
                if (text.length == 6) {
                  inValidOtp = false;
                } else {
                  inValidOtp = true;
                }
              });
              validationCode = text;
            },
          ),
        ),
        const SizedBox(width: 8.0),
        CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: (inValidOtp || remainSeconds == 0)
              ? null
              : () {
                  signInWithSmsCode(validationCode);
                },
          child: Container(
            decoration: ShapeDecoration(
              color: (inValidOtp || remainSeconds == 0)
                  ? const Color(0xFFEEEEEE)
                  : ShownyStyle.mainPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            width: 120.0,
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Center(
              child: Text(
                tr("email_sign_up_screen2.otp_confirmation"),
                style: Constants.defaultTextStyle.copyWith(
                    color: (inValidOtp || remainSeconds == 0)
                        ? const Color(0xFF555555)
                        : Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget accountInfoTextField() {
    return Column(
      children: [
        Focus(
          child: SignUpTextField(
            hintText: tr("email_sign_up_screen2.name"),
            error: inValidName,
            errorText: (name.length < 3 || name.length > 20)
                ? tr("email_sign_up_screen2.invalid_name_error_length")
                : tr("email_sign_up_screen2.invalid_name_error_character"),
            onChanged: (text) {
              setState(() => inValidName = false);
              name = text;
            },
            maxLength: 20,
          ),
          onFocusChange: (hasFocus) {
            if (hasFocus == false && name.isNotEmpty) {
              setState(() => inValidName = !Validator.validNamePattern(name));
            }
          },
        ),
        SizedBox(height: inValidName ? 8.0 : 16.0),
        phoneNumberTextField(),
        const SizedBox(height: 16.0),
        if (sendOtpNum && verifyOtp == false) otpTextField(),
      ],
    );
  }

  Future signupSns(loginType, email, snsId, name, phoneNumber) async {
    ApiHelper.shared.signup(
        loginType, email, snsId, snsId, name, phoneNumber, true, (success) {
      signinSns(loginType, snsId);
      Navigator.push(context,
          PageRouteBuilderRightLeft(child: const InputEssentialInfoScreen()));
      loginAction(
          loginType: loginType, email: email, password: '', snsId: snsId);
      debugPrint('DEBUG: Sign up successful');
    }, (error) {
      var dialog = ShownyDialog(
        message: error,
        primaryLabel: tr("common.confirm"),
      );
      showAlertDialog(context, dialog: dialog);
      debugPrint(error);
    });
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
          title: Text(tr("email_sign_up_screen2.title")),
          titleTextStyle: FontHelper.bold_16_000000,
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
                ShownyButton(
                  onPressed: checkCondition()
                      ? () {
                          inValidName = !Validator.validNamePattern(name);
                          setState(() =>
                              inValidName = !Validator.validNamePattern(name));
                          if (inValidName == true) {
                            return;
                          }

                          showTermSheet(context, (value) {
                            if (widget.loginType == 'email') {
                              ApiHelper.shared.signup(
                                  "email",
                                  widget.email,
                                  "",
                                  widget.password,
                                  name,
                                  phoneNumber,
                                  value, (success) {
                                signIn(widget.email, widget.password);
                                Navigator.push(
                                    context,
                                    PageRouteBuilderRightLeft(
                                        child:
                                            const InputEssentialInfoScreen()));
                                loginAction(
                                    loginType: "email",
                                    email: widget.email,
                                    password: widget.password,
                                    snsId: "");
                                debugPrint('DEBUG: Sign up successful');
                              }, (error) {
                                var dialog = ShownyDialog(
                                  message: error,
                                  primaryLabel: tr("common.confirm"),
                                );
                                showAlertDialog(context, dialog: dialog);
                                debugPrint(error);
                              });
                            } else {
                              signupSns(widget.loginType, '', widget.snsId,
                                  name, phoneNumber);
                            }
                          });

                          debugPrint('DEBUG: tab complete button');
                        }
                      : null,
                  option: ShownyButtonOption.fill(
                    text: tr("common.complete"),
                    theme: ShownyButtonFillTheme.violet,
                    style: ShownyButtonFillStyle.fullRegular,
                  ),
                ),
                // SVButton(
                //   title: tr("common.complete"),
                //   titleColor:
                //       checkCondition() ? Colors.white : const Color(0xFF555555),
                //   backgroundColor: checkCondition()
                //       ? ShownyStyle.mainPurple
                //       : const Color(0xFFEEEEEE),

                // ),
                const SizedBox(height: 24.0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
