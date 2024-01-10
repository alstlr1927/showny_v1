import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/screens/intro/screen/login_screen.dart';

class TempSetting extends StatefulWidget {
  const TempSetting({super.key});

  @override
  State<TempSetting> createState() => _TempSettingState();
}

class _TempSettingState extends State<TempSetting> {
  static const storage = FlutterSecureStorage();
  void logout() async {
    await storage.delete(key: 'email');
    await storage.delete(key: 'password');
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.routeName,
        (route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('임시 설정'),
      ),
      body: Center(
        child: ShownyButton(
          onPressed: logout,
          option: ShownyButtonOption.text(
            text: '로그아웃',
            theme: ShownyButtonTextTheme.gray,
            style: ShownyButtonTextStyle.regular,
          ),
        ),
      ),
    );
  }
}
