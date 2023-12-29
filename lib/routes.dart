import 'package:showny/screens/intro/screen/input_additional_information_screen.dart';
import 'package:showny/screens/intro/screen/email_login_screen.dart';
import 'package:showny/screens/intro/screen/login_screen.dart';
import 'package:showny/screens/intro/screen/sign_up_screen.dart';
import 'package:showny/screens/root_screen.dart';
import 'package:showny/screens/tabs/profile/other_profile_screen.dart';
import 'package:showny/screens/tabs/profile/profile_screen.dart';

final routes = {
  RootScreen.routeName: (context) => const RootScreen(),

  // Login
  LoginScreen.routeName: (context) => const LoginScreen(),
  EmailLoginScreen.routeName: (context) => const EmailLoginScreen(),
  SignUpScreen.routeName: (context) => const SignUpScreen(),
  InputAdditionalInfoScreen.routeName: (context) =>
      const InputAdditionalInfoScreen(),

  // Profile
  ProfileScreen.routeName: (context) => ProfileScreen(),
  OtherProfileScreen.routeName: (context) => const OtherProfileScreen(memNo: '',),
};
