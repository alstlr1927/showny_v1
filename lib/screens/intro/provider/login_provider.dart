import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/constants.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/common/components/page_route_builder_right_left.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';
import 'package:showny/screens/intro/screen/email_sign_up2_screen.dart';
import 'package:showny/screens/intro/screen/input_additional_information_screen.dart';
import 'package:showny/screens/intro/screen/input_essential_information_screen.dart';
import 'package:showny/screens/main/root_screen.dart';

class LoginProvider with ChangeNotifier {
  State state;

  static const storage = FlutterSecureStorage();

  Future signinSns(loginType, snsId) async {
    ApiHelper.shared.signinSns(snsId, loginType, (userModel) async {
      Provider.of<UserProvider>(state.context, listen: false)
          .updateUserInfo(userModel);
      // Provider.of<ChatStyleProvider>(context, listen: false).initChat(userModel.memNo, userModel.nickNm, userModel.profileImage);

      if (await loginAction(
          loginType: loginType, email: "", password: "", snsId: snsId)) {
        // userProvider에 저장
        debugPrint('Login Success');
        if (state.mounted) {
          if (userModel.birthday == "") {
            Navigator.push(
                state.context,
                PageRouteBuilderRightLeft(
                    child: const InputEssentialInfoScreen()));
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
      Navigator.push(
          state.context,
          PageRouteBuilderRightLeft(
              child: EmailSignUp2Screen(
            email: '',
            password: '',
            loginType: loginType,
            snsId: snsId,
          )));
    });
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

  LoginProvider(this.state);
}
