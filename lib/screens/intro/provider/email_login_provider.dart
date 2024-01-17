import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/components/title_text_field/field_controller.dart';
import 'package:showny/constants.dart';
import 'package:showny/helper/sns_login_helper.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';
import 'package:showny/screens/intro/screen/email_sign_up2_screen.dart';
import 'package:showny/screens/intro/screen/input_additional_Information_screen.dart';
import 'package:showny/screens/intro/screen/input_essential_information_screen.dart';
import 'package:showny/screens/main/root_screen.dart';
import 'package:showny/utils/validator.dart';

import '../../../providers/user_model_provider.dart';

class EmailLoginProvider with ChangeNotifier {
  static const storage = FlutterSecureStorage();
  State state;

  FieldController emailController = FieldController();
  FieldController pwController = FieldController();

  bool isLoading = false;

  void setIsLoading(bool flag) {
    isLoading = flag;
    notifyListeners();
  }

  void unfocusAllField() {
    emailController.unfocus();
    pwController.unfocus();
  }

  void validateEmail(String text) async {
    emailController.resetStatus();
    if (text.isEmpty) {
      return;
    }
    String p =
        r'^(([^ㄱ-ㅎ가-힣<>()\[\].,;:\s@“]+(\.[^ㄱ-ㅎ가-힣<>()\[\].,;:\s@“]+)*)|(“.+“))@(([^ㄱ-ㅎ가-힣<>()\[\].,;:\s@“]+\.)+[^ㄱ-ㅎ가-힣<>()\[\].,;:\s@“]{2,})$';
    RegExp regExp = RegExp(p);

    if (!regExp.hasMatch(text)) {
      emailController.setErrorText('올바르지 않은 이메일 형식입니다.');
      emailController.setHasError(true);
      emailController.setIsValid(false);
    } else {
      emailController.setHasError(false);
      emailController.setIsEnable(true);
      emailController.setIsValid(true);
    }
  }

  void validatePassword(String text) async {
    if (text.isEmpty) {
      pwController.resetStatus();
      return;
    }
    if (!Validator.validPasswordPattern(text)) {
      pwController.setErrorText('8~15자리 영문자, 숫자, 특수문자 조합으로 만들어주세요!');
      pwController.setHasError(true);
      pwController.setIsValid(false);
    } else {
      pwController.setHasError(false);
      pwController.setIsValid(true);
      pwController.setIsEnable(true);
    }
  }

  Future onClickKakao() async {
    setIsLoading(true);
    debugPrint('DEBUG: tap kakao login button');
    SnsLoginHelper.kakaoLogin((userId) {
      signinSns("kakao", userId);
    });
  }

  Future onClickGoogle() async {
    setIsLoading(true);
    debugPrint('DEBUG: tab google login button');
    SnsLoginHelper.googleLogin((userId) {
      signinSns("google", userId);
    });
  }

  Future onClickApple() async {
    setIsLoading(true);
    debugPrint('DEBUG: tab apple login button');
    SnsLoginHelper.appleLogin((userId) {
      signinSns("apple", userId);
    });
  }

  Future onClickNaver() async {
    setIsLoading(true);
    debugPrint('DEBUG: tab naver login');
    SnsLoginHelper.naverLogin((userId) {
      signinSns("naver", userId);
    });
  }

  Future onClickLogin() async {
    String email = emailController.getStatus.text;
    String pw = pwController.getStatus.text;
    await ApiHelper.shared.signinEmail(
      email,
      pw,
      (userModel) async {
        setIsLoading(false);
        Provider.of<UserProvider>(state.context, listen: false)
            .updateUserInfo(userModel);
        // Provider.of<ChatStyleProvider>(context, listen: false).initChat(userModel.memNo, userModel.nickNm, userModel.profileImage);
        if (await loginAction(
            loginType: "email", email: email, password: pw, snsId: "")) {
          // userProvider에 저장
          debugPrint('Login Success');
          if (state.mounted) {
            if (userModel.birthday == "") {
              Navigator.push(
                  state.context,
                  ShownyPageRoute(
                    builder: (context) => const InputEssentialInfoScreen(),
                  ));
            } else if (userModel.colorIdList.isEmpty) {
              var dialog = ShownyDialog(
                message: tr("intro_popup.not_found_style_title"),
                subMessage: tr("intro_popup.not_found_style_content"),
                primaryLabel: tr("intro_popup.not_found_style_button1"),
                secondaryLabel: tr("intro_popup.not_found_style_button2"),
                primaryRoute: InputAdditionalInfoScreen.routeName,
                secondaryRoute: MainLanding.routeName,
                primaryAction: () {},
              );
              showAlertDialog(state.context, dialog: dialog);
            } else {
              Constants.currentUser = userModel;
              Navigator.pushNamedAndRemoveUntil(
                state.context,
                MainLanding.routeName,
                (route) => false,
              );
            }
          }
        }
      },
      (error) {
        ApiHelper.shared.checkDuplicateEmail(email, (success) {
          setIsLoading(false);
          var dialog = ShownyDialog(
            message: tr("email_login.email_not_exist"),
            primaryLabel: tr("common.confirm"),
          );

          showAlertDialog(state.context, dialog: dialog);
        }, (error) {
          setIsLoading(false);
          var dialog = ShownyDialog(
            message: tr("email_login.incorrect_password"),
            primaryLabel: tr("common.confirm"),
          );

          showAlertDialog(state.context, dialog: dialog);
        });
      },
    );
    print('end');
  }

  void showAlertDialog(BuildContext context, {required ShownyDialog dialog}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
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

  Future signinSns(loginType, snsId) async {
    ApiHelper.shared.signinSns(snsId, loginType, (userModel) async {
      Provider.of<UserProvider>(state.context, listen: false)
          .updateUserInfo(userModel);
      // Provider.of<ChatStyleProvider>(context, listen: false).initChat(userModel.memNo, userModel.nickNm, userModel.profileImage);

      if (await loginAction(
          loginType: loginType, email: "", password: "", snsId: snsId)) {
        // userProvider에 저장
        setIsLoading(false);
        debugPrint('Login Success');
        if (state.mounted) {
          if (userModel.birthday == "") {
            Navigator.push(
                state.context,
                ShownyPageRoute(
                  builder: (context) => const InputEssentialInfoScreen(),
                ));
          } else if (userModel.colorIdList.isEmpty) {
            var dialog = ShownyDialog(
              message: tr("intro_popup.not_found_style_title"),
              subMessage: tr("intro_popup.not_found_style_content"),
              primaryLabel: tr("intro_popup.not_found_style_button1"),
              secondaryLabel: tr("intro_popup.not_found_style_button2"),
              primaryRoute: InputAdditionalInfoScreen.routeName,
              secondaryRoute: MainLanding.routeName,
              primaryAction: () {},
            );
            showAlertDialog(state.context, dialog: dialog);
          } else {
            Constants.currentUser = userModel;
            Navigator.pushNamedAndRemoveUntil(
              state.context,
              MainLanding.routeName,
              (route) => false,
            );
          }
        }
      }
    }, (error) {
      setIsLoading(false);
      Navigator.push(
          state.context,
          ShownyPageRoute(
            builder: (context) => EmailSignUp2Screen(
              email: '',
              password: '',
              loginType: loginType,
              snsId: snsId,
            ),
          ));
    });
  }

  @override
  void notifyListeners() {
    if (state.mounted) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  EmailLoginProvider(this.state);
}
