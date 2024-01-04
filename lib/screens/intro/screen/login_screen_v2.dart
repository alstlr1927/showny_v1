import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:showny/helper/sns_login_helper.dart';
import 'package:showny/models/user_model.dart';
import 'package:showny/providers/user_model_provider.dart';

import 'package:showny/routes.dart';
import 'package:showny/screens/common/components/sv_button.dart';
import 'package:showny/screens/intro/components/login_sheet.dart';
import 'package:showny/screens/intro/provider/login_provider.dart';
import 'package:showny/screens/root_screen.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';
import 'package:video_player/video_player.dart';

class LoginScreenV2 extends StatefulWidget {
  const LoginScreenV2({super.key});

  @override
  State<LoginScreenV2> createState() => _LoginScreenV2State();
}

class _LoginScreenV2State extends State<LoginScreenV2> {
  double width = ScreenUtil().screenWidth;
  double height = ScreenUtil().screenHeight;
  double videoHeight = ScreenUtil().screenWidth * 4 / 3;
  Duration aniDuration = const Duration(milliseconds: 400);
  bool testFlag = true;

  late VideoPlayerController controller;

  @override
  void initState() {
    controller =
        VideoPlayerController.asset('assets/icons/login/test_video2.mp4');
    controller.setLooping(true);
    controller.setVolume(0);
    controller.initialize().then((_) => setState(() {
          // controller.play();
        }));
    super.initState();
  }

  @override
  void dispose() {
    controller.pause();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LoginProvider>(
        create: (_) => LoginProvider(this),
        builder: (context, _) {
          return Stack(
            children: [
              AnimatedPositioned(
                top: testFlag ? (height - videoHeight) / 2 : 0,
                duration: aniDuration,
                child: GestureDetector(
                  onTap: () {
                    testFlag = !testFlag;
                    setState(() {});
                  },
                  child: Container(
                    width: width,
                    height: videoHeight,
                    color: Colors.green.withOpacity(.4),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // VideoPlayer(controller),
                        AnimatedPositioned(
                          top: testFlag
                              ? videoHeight / 2 - 15.toWidth
                              : 140.toWidth,
                          duration: aniDuration,
                          child: AnimatedScale(
                            scale: testFlag ? 1.0 : .75,
                            duration: aniDuration,
                            child: Image.asset(
                              'assets/icons/login/showny_logo.png',
                              width: 200.toWidth,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              // const Spacer(),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //   child: loginButtons(context),
              // ),
              // skipLoginButton(),
              // const SizedBox(height: 24),
              FutureBuilder(
                initialData: true,
                future: test(),
                builder: (context, snapshot) {
                  return _buildButtons(snapshot.data ?? true, context);
                },
              ),
              // _buildButtons(),
            ],
          );
        });
  }

  Future<bool> test() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return testFlag;
  }

  Widget _buildButtons(bool flag, BuildContext context) {
    LoginProvider loginProv =
        Provider.of<LoginProvider>(context, listen: false);
    if (flag) {
      return Container();
    }
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 150),
      opacity: flag ? 0 : 1.0,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            LoginButton(
              icon: Image.asset(
                'assets/icons/login/kakao_logo.png',
                width: 22.toWidth,
              ),
              title: '카카오로 시작하기',
              backgroundColor: const Color(0xFFFAE100),
              onPressed: () {
                debugPrint('DEBUG: tap kakao login button');
                SnsLoginHelper.kakaoLogin((userId) {
                  loginProv.signinSns("kakao", userId);
                });
              },
            ),
            SizedBox(height: 11.toHeight),
            LoginButton(
              title: '다른 방법으로 시작하기',
              backgroundColor: ShownyStyle.black,
              titleColor: ShownyStyle.white,
              onPressed: () {
                Navigator.push(
                    context,
                    SheetRoute(
                      builder: (context) =>
                          OtherLoginSheet(loginProv: loginProv),
                    ));
              },
            ),
            SizedBox(height: 15.toHeight),
            CupertinoButton(
              onPressed: () {
                UserProvider userProvider =
                    Provider.of<UserProvider>(context, listen: false);
                userProvider.updateUserInfo(UserModel());

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => const RootScreen()),
                    (route) => false);
                debugPrint('DEBUG: tab skip login button');
              },
              child: Text(
                '로그인 없이 둘러보기',
                style: ShownyStyle.caption(
                        color: ShownyStyle.black, weight: FontWeight.w500)
                    .copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
            SizedBox(height: 22.toHeight),
            SizedBox(height: ShownyStyle.defaultBottomPadding()),
          ],
        ),
      ),
    );
  }
}
