import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/screens/intro/screen/email_login_v2.dart';
import 'package:showny/screens/intro/screen/email_sign_up_v2.dart';
import 'package:showny/screens/intro/screen/input_additional_information_screen.dart';
import 'package:showny/screens/intro/screen/login_screen.dart';
import 'package:showny/screens/main/root_screen.dart';
import 'package:showny/screens/profile/other_profile_screen.dart';
import 'package:showny/screens/profile/profile_screen.dart';

const pageTransitionDuration = Duration(milliseconds: 400);

final routes = {
  MainLanding.routeName: (context) => const MainLanding(),

  // Login
  LoginScreen.routeName: (context) => const LoginScreen(),
  EmailLoginV2.routeName: (context) => const EmailLoginV2(),
  EmailSignUpV2.routeName: (context) => const EmailSignUpV2(),
  InputAdditionalInfoScreen.routeName: (context) =>
      const InputAdditionalInfoScreen(),

  // Profile
  ProfileScreen.routeName: (context) => ProfileScreen(),
  OtherProfileScreen.routeName: (context) => const OtherProfileScreen(
        memNo: '',
      ),
};
