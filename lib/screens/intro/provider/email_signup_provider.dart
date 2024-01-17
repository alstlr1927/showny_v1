import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/components/title_text_field/field_controller.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';
import 'package:showny/screens/intro/screen/email_sign_up2_screen.dart';
import 'package:showny/utils/validator.dart';

class EmailSignUpProvider with ChangeNotifier {
  State state;

  FieldController emailController = FieldController();
  FieldController pwController = FieldController();
  FieldController checkController = FieldController();

  bool isLoading = false;

  void setIsLoading(bool flag) {
    isLoading = flag;
    notifyListeners();
  }

  void unfocusAllField() {
    emailController.unfocus();
    pwController.unfocus();
    checkController.unfocus();
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

    if (text != checkController.getStatus.text) {
      checkController.setErrorText('비밀번호가 일치하지 않습니다.');
      checkController.setHasError(true);
      checkController.setIsValid(false);
    } else {
      checkController.setHasError(false);
      checkController.setIsValid(true);
      checkController.setIsEnable(true);
    }
  }

  void validateCheckPassword(String text) async {
    if (text.isEmpty) {
      checkController.resetStatus();
      return;
    }
    if (text != pwController.getStatus.text) {
      checkController.setErrorText('비밀번호가 일치하지 않습니다.');
      checkController.setHasError(true);
      checkController.setIsValid(false);
    } else {
      checkController.setHasError(false);
      checkController.setIsValid(true);
      checkController.setIsEnable(true);
    }
  }

  Future onClickNextButton() async {
    String email = emailController.getStatus.text;
    String password = pwController.getStatus.text;
    ApiHelper.shared.checkDuplicateEmail(email, (success) {
      setIsLoading(false);
      Navigator.push(
          state.context,
          ShownyPageRoute(
            builder: (context) => EmailSignUp2Screen(
              email: email,
              password: password,
              loginType: 'email',
              snsId: '',
            ),
          ));
    }, (error) {
      setIsLoading(false);
      final dialog = ShownyDialog(
        message: error,
        primaryLabel: tr("common.confirm"),
      );

      showAlertDialog(state.context, dialog: dialog);
      debugPrint(error);
    });
    debugPrint('DEBUG: tab complete button');
  }

  void showAlertDialog(BuildContext context, {required ShownyDialog dialog}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
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

  EmailSignUpProvider(this.state);
}
