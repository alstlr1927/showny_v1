import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:showny/components/indicator/showny_indicator.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/components/title_text_field/title_text_field.dart';
import 'package:showny/models/user_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/common/components/page_route_builder_right_left.dart';
import 'package:showny/screens/common/components/sv_button.dart';
import 'package:showny/screens/intro/provider/email_login_provider.dart';
import 'package:showny/screens/intro/screen/email_sign_up_screen.dart';
import 'package:showny/screens/intro/screen/email_sign_up_v2.dart';
import 'package:showny/screens/intro/screen/find_password_screen.dart';
import 'package:showny/screens/main/root_screen.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';
import 'package:showny/utils/validator.dart';

class EmailLoginV2 extends StatefulWidget {
  const EmailLoginV2({super.key});

  static String routeName = '/email_login_screen';

  @override
  State<EmailLoginV2> createState() => _EmailLoginV2State();
}

class _EmailLoginV2State extends State<EmailLoginV2> {
  late EmailLoginProvider provider;

  @override
  void initState() {
    provider = EmailLoginProvider(this);
    super.initState();
  }

  @override
  void dispose() {
    provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EmailLoginProvider>.value(
      value: provider,
      builder: (context, _) {
        EmailLoginProvider emailProv =
            Provider.of<EmailLoginProvider>(context, listen: false);
        return GestureDetector(
          onTap: emailProv.unfocusAllField,
          child: Stack(
            children: [
              Scaffold(
                resizeToAvoidBottomInset: false,
                appBar: AppBar(),
                body: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
                  width: ScreenUtil().screenWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 70),
                      _buildLogoTitle(),
                      const SizedBox(height: 100),
                      _buildLoginArea(),
                      const Spacer(),
                      _buildBottomArea(context),
                      SizedBox(height: ShownyStyle.defaultBottomPadding()),
                    ],
                  ),
                ),
              ),
              // Consumer<EmailLoginProvider>(
              //   builder: (ctx, prov, child) {
              //     if (prov.isLoading) {
              //       return Container(
              //         color: Colors.black.withOpacity(.6),
              //         child: ShownyIndicator(
              //           color: ShownyStyle.white,
              //           radius: 20,
              //         ),
              //       );
              //     }
              //     return const SizedBox();
              //   },
              // ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLogoTitle() {
    return Image.asset(
      'assets/icons/login/showny_logo.png',
      width: 158.toWidth,
      fit: BoxFit.cover,
    );
  }

  Widget _buildLoginArea() {
    return Consumer<EmailLoginProvider>(builder: (ctx, prov, child) {
      return Column(
        children: [
          TitleTextField(
            title: '이메일 주소',
            hintText: '이메일 주소',
            controller: prov.emailController,
            keyboardType: TextInputType.text,
            inputFormatters: [
              FilteringTextInputFormatter.deny(Validator().kWhiteSpaceRegex)
            ],
            autofillHints: const [AutofillHints.email],
            onChanged: prov.validateEmail,
            onSubmitted: (value) => prov.unfocusAllField(),
          ),
          TitleTextField(
            title: '비밀번호',
            hintText: '비밀번호',
            controller: prov.pwController,
            keyboardType: TextInputType.text,
            isObscure: true,
            inputFormatters: [
              FilteringTextInputFormatter.deny(Validator().kWhiteSpaceRegex)
            ],
            autofillHints: const [AutofillHints.password],
            onChanged: prov.validatePassword,
            onSubmitted: (value) => prov.unfocusAllField(),
          ),
          const SizedBox(height: 16),
          StreamBuilder<bool>(
            initialData: false,
            stream: Rx.combineLatest2(prov.emailController.statusStream!,
                prov.pwController.statusStream!, (dynamic a, dynamic b) {
              return (a.isValid && b.isValid);
            }),
            builder: (context, snapshot) {
              bool isChecked = snapshot.data!;
              return ShownyButton(
                onPressed: isChecked
                    ? () async {
                        if (prov.isLoading) return;
                        prov.setIsLoading(true);
                        await prov.onClickLogin();
                      }
                    : null,
                option: ShownyButtonOption.fill(
                  text: '로그인',
                  theme: ShownyButtonFillTheme.violet,
                  style: ShownyButtonFillStyle.fullRegular,
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          ShownyButton(
            onPressed: () {
              Navigator.push(
                  context,
                  PageRouteBuilderRightLeft(
                    child: FindPasswordScreen(
                        recentRouteName: EmailLoginV2.routeName),
                  ));

              debugPrint('DEBUG: tab skip login button');
            },
            option: ShownyButtonOption.text(
              text: '비밀번호를 잊어버렸나요?',
              theme: ShownyButtonTextTheme.gray,
              style: ShownyButtonTextStyle.small,
            ),
          ),
        ],
      );
    });
  }

  Widget _buildBottomArea(BuildContext ctx) {
    EmailLoginProvider emailProv =
        Provider.of<EmailLoginProvider>(ctx, listen: false);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialBtn(
              onPressed: emailProv.onClickKakao,
              padding: 8,
              child: Container(
                padding: EdgeInsets.all(6.toWidth),
                decoration: const BoxDecoration(
                  color: Color(0xffFEE500),
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/icons/login/kakao_logo.png'),
              ),
            ),
            SizedBox(width: 24.toWidth),
            _buildSocialBtn(
              onPressed: emailProv.onClickGoogle,
              child: Image.asset('assets/icons/login/google_logo.png'),
            ),
            SizedBox(width: 24.toWidth),
            _buildSocialBtn(
              onPressed: emailProv.onClickApple,
              child: Image.asset('assets/icons/login/apple_logo.png'),
            ),
            SizedBox(width: 24.toWidth),
            _buildSocialBtn(
              onPressed: emailProv.onClickNaver,
              padding: 8,
              child: Container(
                padding: EdgeInsets.all(8.toWidth),
                decoration: const BoxDecoration(
                  color: Color(0xff03C75A),
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/icons/login/naver_logo.png'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 30),
        LoginButton(
          onPressed: () {
            Navigator.push(context,
                PageRouteBuilderRightLeft(child: const EmailSignUpV2()));

            debugPrint('DEBUG: tab email sign up button');
          },
          title: '쇼니버스 회원가입',
          backgroundColor: ShownyStyle.black,
          titleColor: ShownyStyle.white,
          icon: Image.asset(
            'assets/icons/showny_icon.png',
            height: 24.toWidth,
          ),
        ),
        CupertinoButton(
          onPressed: () {
            UserProvider userProvider =
                Provider.of<UserProvider>(context, listen: false);
            userProvider.updateUserInfo(UserModel());

            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder) => const MainLanding()),
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
      ],
    );
  }

  Widget _buildSocialBtn({
    double padding = 12,
    VoidCallback? onPressed,
    required Widget child,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 44.toWidth,
        height: 44.toWidth,
        padding: EdgeInsets.all(padding.toWidth),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: ShownyStyle.elevation_03dp(),
        ),
        child: child,
      ),
    );
  }
}
