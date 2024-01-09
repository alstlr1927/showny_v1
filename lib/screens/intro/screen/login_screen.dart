import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/constants.dart';
import 'package:showny/helper/sns_login_helper.dart';
import 'package:showny/models/user_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/common/components/page_route_builder_right_left.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';
import 'package:showny/screens/common/components/sv_button.dart';
import 'package:showny/screens/intro/screen/email_login_screen.dart';
import 'package:showny/screens/intro/screen/email_sign_up2_screen.dart';
import 'package:showny/screens/intro/screen/input_additional_information_screen.dart';
import 'package:showny/screens/intro/screen/input_essential_information_screen.dart';
import 'package:showny/screens/intro/screen/login_screen_v2.dart';
import 'package:showny/screens/intro/screen/sign_up_screen.dart';
import 'package:showny/screens/intro/screen/splash_screen.dart';
import 'package:showny/screens/main/root_screen.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  static String routeName = '/login_screen';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const storage = FlutterSecureStorage();

  bool isSplashScreenOn = true;
  bool isLoggined = false;
  bool hasEssentialData = false;
  bool hasAdditionalData = false;

  void turnOffSplashScreen() async {
    // await Future.delayed(const Duration(seconds: 1));
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
  void initState() {
    super.initState();

    turnOffSplashScreen();
  }

  @override
  void didChangeDependencies() async {
    var loginType = await storage.read(key: "loginType");
    final snsId = await storage.read(key: "snsId");
    final email = await storage.read(key: 'email');
    final password = await storage.read(key: 'password');

    // loginType = '';

    debugPrint(email);
    debugPrint(password);

    if (loginType == null || loginType == "") {
      setState(() {
        isSplashScreenOn = false;
        hasAdditionalData = true;
      });
      debugPrint('DEBUG: Login Required');
    } else if (loginType == "email" && email != "" && password != "") {
      ApiHelper.shared.signinEmail(email, password, (userModel) {
        Provider.of<UserProvider>(context, listen: false)
            .updateUserInfo(userModel);
        // Provider.of<ChatStyleProvider>(context, listen: false).initChat(userModel.memNo, userModel.nickNm, userModel.profileImage);
        setState(() => hasAdditionalData = (userModel.colorIdList.isNotEmpty));
        if (!hasAdditionalData) {
          var dialog = ShownyDialog(
            message: tr('intro_popup.not_found_style_title'),
            subMessage: tr('intro_popup.not_found_style_content'),
            primaryLabel: tr('intro_popup.not_found_style_button1'),
            secondaryLabel: tr('intro_popup.not_found_style_button2'),
            primaryRoute: InputAdditionalInfoScreen.routeName,
            secondaryRoute: MainLanding.routeName,
          );
          showAlertDialog(context, dialog: dialog);
        } else {
          Constants.currentUser = userModel;
          Navigator.pushNamedAndRemoveUntil(
              context, MainLanding.routeName, (route) => false);
        }
      }, (error) {
        setState(() {
          isSplashScreenOn = false;
          hasAdditionalData = true;
        });
      });
    } else {
      signinSns(loginType, snsId);
    }

    super.didChangeDependencies();
  }

  Future signinSns(loginType, snsId) async {
    ApiHelper.shared.signinSns(snsId, loginType, (userModel) async {
      Provider.of<UserProvider>(context, listen: false)
          .updateUserInfo(userModel);
      // Provider.of<ChatStyleProvider>(context, listen: false).initChat(userModel.memNo, userModel.nickNm, userModel.profileImage);

      if (await loginAction(
              loginType: loginType, email: "", password: "", snsId: snsId) ==
          true) {
        // userProvider에 저장
        debugPrint('Login Success');
        if (mounted) {
          if (userModel.birthday == "") {
            Navigator.push(
                context,
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
            showAlertDialog(context, dialog: dialog);
          } else {
            Constants.currentUser = userModel;
            Navigator.pushNamedAndRemoveUntil(
              context,
              MainLanding.routeName,
              (route) => false,
            );
          }
        }
      }
    }, (error) {
      Navigator.push(
          context,
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

  // Widget loginButtons(BuildContext context) {
  //   return Column(
  //     children: [
  //       SVButton(
  //         icon: Image.asset(
  //           'assets/logos/kakao.png',
  //           width: 24.0,
  //           height: 24.0,
  //         ),
  //         title: tr("login.kakao_login"),
  //         backgroundColor: const Color(0xFFFAE100),
  //         onPressed: () {
  //           debugPrint('DEBUG: tap kakao login button');
  //           SnsLoginHelper.kakaoLogin((userId) {
  //             signinSns("kakao", userId);
  //           });
  //         },
  //       ),
  //       const SizedBox(height: 16.0),
  //       SVButton(
  //         icon: Image.asset(
  //           'assets/logos/naver.png',
  //           width: 24.0,
  //           height: 24.0,
  //         ),
  //         title: tr("login.naver_login"),
  //         backgroundColor: const Color(0xFF03C75A),
  //         onPressed: () {
  //           debugPrint('DEBUG: tab naver login');
  //           SnsLoginHelper.naverLogin((userId) {
  //             signinSns("naver", userId);
  //           });
  //         },
  //       ),
  //       const SizedBox(height: 16.0),
  //       SVButton(
  //         icon: Image.asset(
  //           'assets/logos/google.png',
  //           width: 24.0,
  //           height: 24.0,
  //         ),
  //         title: tr("login.google_login"),
  //         strokeColor: const Color(0xFFD9D9D9),
  //         backgroundColor: Colors.white,
  //         onPressed: () {
  //           debugPrint('DEBUG: tab google login button');
  //           SnsLoginHelper.googleLogin((userId) {
  //             signinSns("google", userId);
  //           });
  //         },
  //       ),
  //       const SizedBox(height: 16.0),
  //       SVButton(
  //         icon: Image.asset(
  //           'assets/logos/apple.png',
  //           width: 24.0,
  //           height: 24.0,
  //         ),
  //         title: tr("login.apple_login"),
  //         strokeColor: const Color(0xFFD9D9D9),
  //         backgroundColor: Colors.white,
  //         onPressed: () {
  //           debugPrint('DEBUG: tab apple login button');
  //           SnsLoginHelper.appleLogin((userId) {
  //             signinSns("apple", userId);
  //           });
  //         },
  //       ),
  //       const SizedBox(height: 16.0),
  //       SVButton(
  //         icon: Image.asset(
  //           'assets/icons/mail.png',
  //           width: 24.0,
  //           height: 24.0,
  //         ),
  //         title: tr("login.email_login"),
  //         strokeColor: Colors.black,
  //         backgroundColor: Colors.white,
  //         onPressed: () {
  //           Navigator.push(context,
  //               PageRouteBuilderRightLeft(child: const EmailLoginScreen()));

  //           debugPrint('DEBUG: tab email login button');
  //         },
  //       ),
  //       const SizedBox(height: 16.0),
  //       SVButton(
  //         title: tr("login.signup"),
  //         titleColor: Colors.white,
  //         backgroundColor: Colors.black,
  //         onPressed: () {
  //           Navigator.push(context,
  //               PageRouteBuilderRightLeft(child: const SignUpScreen()));

  //           debugPrint('DEBUG: tab sign up showny button');
  //         },
  //       ),
  //     ],
  //   );
  // }

  // Widget skipLoginButton() {
  //   return CupertinoButton(
  //     padding: const EdgeInsets.all(16.0),
  //     child: Column(
  //       children: [
  //         Text(
  //           tr("login.without_login"),
  //           textAlign: TextAlign.center,
  //           style: Constants.defaultTextStyle.copyWith(fontSize: 12.0),
  //         ),
  //         const SizedBox(height: 6.0),
  //         Container(
  //           width: 105,
  //           height: 1,
  //           color: Colors.black,
  //         )
  //       ],
  //     ),
  //     onPressed: () {
  //       UserProvider userProvider =
  //           Provider.of<UserProvider>(context, listen: false);
  //       userProvider.updateUserInfo(UserModel());

  //       Navigator.pushAndRemoveUntil(
  //           context,
  //           MaterialPageRoute(builder: (builder) => const RootScreen()),
  //           (route) => false);
  //       debugPrint('DEBUG: tab skip login button');
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            if (isLoggined && !hasEssentialData) ...{
              const InputEssentialInfoScreen()
            } else ...{
              const LoginScreenV2(),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.center,
              //   children: [
              //     const SizedBox(height: 96),
              //     Image.asset(
              //       'assets/logos/showny.png',
              //       width: 158,
              //       height: 24,
              //     ),
              //     const Spacer(),
              //     Padding(
              //       padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //       child: loginButtons(context),
              //     ),
              //     skipLoginButton(),
              //     const SizedBox(height: 24),
              //   ],
              // ),
            },
            if (isSplashScreenOn) const SplashScreen(),
            if (!hasAdditionalData) const SplashScreen()
          ],
        ),
      ),
    );
  }
}
