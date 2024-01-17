import 'package:flutter/material.dart';
import 'package:showny/components/drag_to_dispose/drag_to_dispose.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/helper/sns_login_helper.dart';
import 'package:showny/screens/intro/provider/login_provider.dart';
import 'package:showny/screens/intro/screen/email_login_v2.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class OtherLoginSheet extends StatelessWidget {
  final LoginProvider loginProv;
  const OtherLoginSheet({
    super.key,
    required this.loginProv,
  });

  @override
  Widget build(BuildContext context) {
    return DragToDispose(
      maxHeight: 354,
      dragEnable: true,
      backdropTapClosesPanel: true,
      onPageClosed: () {
        Navigator.pop(context);
      },
      panelBuilder: (sc, ac) {
        return Container();
      },
      header: Material(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
        child: Container(
          height: 354,
          decoration: const BoxDecoration(
            color: ShownyStyle.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
            child: Column(
              children: [
                const SizedBox(height: 28),
                _buildHeader(context),
                const SizedBox(height: 28),
                _buildLoginButton(
                    iconPath: 'assets/icons/login/naver_logo.png',
                    text: '네이버로 시작하기',
                    bgColor: const Color(0xff03C75A),
                    onPressed: () {
                      debugPrint('DEBUG: tab naver login');
                      SnsLoginHelper.naverLogin((userId) {
                        loginProv.signinSns("naver", userId);
                      });
                    }),
                const SizedBox(height: 10),
                _buildLoginButton(
                    iconPath: 'assets/icons/login/google_logo.png',
                    text: '구글로 시작하기',
                    onPressed: () {
                      debugPrint('DEBUG: tab google login button');
                      SnsLoginHelper.googleLogin((userId) {
                        loginProv.signinSns("google", userId);
                      });
                    }),
                const SizedBox(height: 10),
                _buildLoginButton(
                    iconPath: 'assets/icons/login/apple_logo.png',
                    text: 'Apple로 시작하기',
                    onPressed: () {
                      debugPrint('DEBUG: tab apple login button');
                      SnsLoginHelper.appleLogin((userId) {
                        loginProv.signinSns("apple", userId);
                      });
                    }),
                const SizedBox(height: 10),
                _buildLoginButton(
                    iconPath: 'assets/icons/login/email_logo.png',
                    text: '이메일로 시작하기',
                    onPressed: () {
                      Navigator.push(
                          context,
                          ShownyPageRoute(
                              builder: (context) => const EmailLoginV2(),
                              settings: const RouteSettings(
                                  name: PageName.EMAIL_LOGIN)));

                      debugPrint('DEBUG: tab email login button');
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '다른 방법으로 로그인',
              style: ShownyStyle.body2(
                  color: ShownyStyle.black, weight: FontWeight.w700),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ShownyButton(
              onPressed: () => Navigator.pop(context),
              option: ShownyButtonOption.icon(
                icon: Icons.close,
                theme: ShownyButtonIconTheme.deepGray,
                style: ShownyButtonIconStyle.regular,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoginButton({
    required String iconPath,
    required String text,
    // required Color textColor,
    Color? bgColor,
    required VoidCallback onPressed,
  }) {
    Color textColor = ShownyStyle.white;
    Color borderColor = Colors.transparent;
    if (bgColor == null) {
      textColor = ShownyStyle.black;
      borderColor = const Color(0xffD9D9D9);
    } else {
      borderColor = bgColor;
    }

    return InkWell(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        height: 45,
        padding: EdgeInsets.symmetric(horizontal: 30.toWidth),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: borderColor),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              text,
              style:
                  ShownyStyle.body2(color: textColor, weight: FontWeight.w600),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Image.asset(
                iconPath,
                width: bgColor != null ? 16.toWidth : 20.toWidth,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
