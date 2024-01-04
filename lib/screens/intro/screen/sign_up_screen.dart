// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:provider/provider.dart';
// import 'package:showny/api/new_api/api_helper.dart';
// import 'package:showny/constants.dart';
// import 'package:showny/helper/sns_login_helper.dart';
// import 'package:showny/providers/user_model_provider.dart';
// import 'package:showny/screens/common/components/page_route_builder_right_left.dart';
// import 'package:showny/screens/common/components/sv_button.dart';
// import 'package:showny/screens/intro/components/showny_dialog.dart';
// import 'package:showny/screens/intro/screen/email_sign_up2_screen.dart';
// import 'package:showny/screens/intro/screen/email_sign_up_screen.dart';
// import 'package:showny/screens/intro/screen/input_additional_Information_screen.dart';
// import 'package:showny/screens/intro/screen/input_essential_information_screen.dart';
// import 'package:showny/screens/root_screen.dart';


// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   static String routeName = '/login_screen';

//   @override
//   State<SignUpScreen> createState() => _SignUpScreen();
// }

// class _SignUpScreen extends State<SignUpScreen> {

//   static String routeName = '/sign_up_screen';

//   static const storage = FlutterSecureStorage();

//   void showAlertDialog(BuildContext context, {required ShownyDialog dialog}) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return dialog;
//       },
//     );
//   }

//   Future signinSns(BuildContext context, loginType, snsId) async {

//     ApiHelper.shared.signinSns(
//       snsId,
//       loginType,
//       (userModel) async {
//         Provider.of<UserProvider>(context, listen: false).updateUserInfo(userModel);
//         // Provider.of<ChatStyleProvider>(context, listen: false).initChat(userModel.memNo, userModel.nickNm, userModel.profileImage);

//         if (await loginAction(loginType: loginType, email: "", password: "", snsId: snsId) ==
//             true) {
//           // userProvider에 저장
//           debugPrint('Login Success');
//           if (mounted) {
//             if (userModel.birthday == "") {
//               Navigator.push(
//                   context,
//                   PageRouteBuilderRightLeft(
//                       child: const InputEssentialInfoScreen()));
//             } else if (userModel.colorIdList.isEmpty) {
//               var dialog = ShownyDialog(
//                 message: tr("intro_popup.not_found_style_title"),
//                 subMessage: tr("intro_popup.not_found_style_content"),
//                 primaryLabel: tr("intro_popup.not_found_style_button1"),
//                 secondaryLabel: tr("intro_popup.not_found_style_button2"),
//                 primaryRoute: InputAdditionalInfoScreen.routeName,
//                 secondaryRoute: RootScreen.routeName,
//                 primaryAction: () {},
//               );
//               showAlertDialog(context, dialog: dialog);
//             } else {
//               Constants.currentUser = userModel;
//               Navigator.pushNamedAndRemoveUntil(
//                 context,
//                 RootScreen.routeName,
//                 (route) => false,
//               );
//             }
//           }
//         }
//       },
//       (error) {
//         Navigator.push(
//           context,
//           PageRouteBuilderRightLeft(child: EmailSignUp2Screen(
//             email: '',
//             password: '',
//             loginType: loginType,
//             snsId: snsId,
//           )));
//       }
//     );
//   }

//   Future<bool> loginAction({
//     required String loginType,
//     required String email,
//     required String password,
//     required String snsId
//   }) async {
//     try {
//       await storage.write(
//         key: "loginType", 
//         value: loginType
//       );
//       await storage.write(
//         key: 'email',
//         value: email,
//       );
//       await storage.write(
//         key: 'password',
//         value: password,
//       );
//       await storage.write(
//         key: "snsId", 
//         value: snsId
//       );
//       return true;
//     } catch (e) {
//       debugPrint(e.toString());
//       return false;
//     }
//   }

//   Widget loginButtons(BuildContext context) {
//     return Column(
//       children: [
//         SVButton(
//           icon: Image.asset(
//             'assets/logos/kakao.png',
//             width: 24.0,
//             height: 24.0,
//           ),
//           title: tr("signup.kakao_signup"),
//           backgroundColor: const Color(0xFFFAE100),
//           onPressed: () {
//             debugPrint('DEBUG: tap kakao sign up button');
//             SnsLoginHelper.kakaoLogin(
//               (userId) {
//                 signinSns(context, "kakao", userId);
//               });
//           },
//         ),
//         const SizedBox(height: 16.0),
//         SVButton(
//           icon: Image.asset(
//             'assets/logos/naver.png',
//             width: 24.0,
//             height: 24.0,
//           ),
//           title: tr("signup.naver_signup"),
//           backgroundColor: const Color(0xFF03C75A),
//           onPressed: () {
//             debugPrint('DEBUG: tab naver sign up');
//             SnsLoginHelper.naverLogin(
//               (userId) {
//                 signinSns(context, "naver", userId);
//               });
//           },
//         ),
//         const SizedBox(height: 16.0),
//         SVButton(
//           icon: Image.asset(
//             'assets/logos/google.png',
//             width: 24.0,
//             height: 24.0,
//           ),
//           title: tr("signup.google_signup"),
//           strokeColor: const Color(0xFFD9D9D9),
//           backgroundColor: Colors.white,
//           onPressed: () {
//             debugPrint('DEBUG: tab google sign up button');
//             SnsLoginHelper.googleLogin(
//               (userId) {
//                 signinSns(context, "google", userId);
//               });
//           },
//         ),
//         const SizedBox(height: 16.0),
//         SVButton(
//           icon: Image.asset(
//             'assets/logos/apple.png',
//             width: 24.0,
//             height: 24.0,
//           ),
//           title: tr("signup.apple_signup"),
//           strokeColor: const Color(0xFFD9D9D9),
//           backgroundColor: Colors.white,
//           onPressed: () {
//             debugPrint('DEBUG: tab apple sign up button');
//             SnsLoginHelper.appleLogin(
//               (userId) {
//                 signinSns(context, "apple", userId);
//               });
//           },
//         ),
//         const SizedBox(height: 16.0),
//         SVButton(
//           icon: Image.asset(
//             'assets/icons/mail.png',
//             width: 24.0,
//             height: 24.0,
//           ),
//           title: tr("signup.email_signup"),
//           strokeColor: Colors.black,
//           backgroundColor: Colors.white,
//           onPressed: () {
//             Navigator.push(
//               context,
//               PageRouteBuilderRightLeft(child: const EmailSignUpScreen()));

//             debugPrint('DEBUG: tab email sign up button');
//           },
//         ),
//       ],
//     );
//   }

//   Widget skipLoginButton(BuildContext context) {
//     return CupertinoButton(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           Text(
//             tr("signup.without_login"),
//             textAlign: TextAlign.center,
//             style: Constants.defaultTextStyle.copyWith(fontSize: 12.0),
//           ),
//           const SizedBox(height: 6.0),
//           Container(
//             width: 105,
//             height: 1,
//             color: Colors.black,
//           )
//         ],
//       ),
//       onPressed: () {
//         Navigator.pushAndRemoveUntil(
//             context,
//             MaterialPageRoute(builder: (builder) => const RootScreen()),
//             (route) => false);
//         debugPrint('DEBUG: tab skip login button');
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: CupertinoButton(
//           padding: EdgeInsets.zero,
//           child: Image.asset(
//             'assets/icons/back_button.png',
//             width: 20.0,
//             height: 20.0,
//           ),
//           onPressed: () => Navigator.pop(context),
//         ),
//       ),
//       body: SafeArea(
//         child: Center(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const SizedBox(height: 48),
//               Image.asset('assets/logos/showny.png', width: 158, height: 24),
//               const Spacer(),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                 child: loginButtons(context),
//               ),
//               skipLoginButton(context),
//               const SizedBox(height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
