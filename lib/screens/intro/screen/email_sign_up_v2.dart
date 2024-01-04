import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:showny/components/showny_button/showny_button.dart';
import 'package:showny/components/title_text_field/title_text_field.dart';
import 'package:showny/screens/intro/provider/email_signup_provider.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';
import 'package:showny/utils/validator.dart';

class EmailSignUpV2 extends StatefulWidget {
  const EmailSignUpV2({super.key});
  static String routeName = '/sign_up_screen';
  @override
  State<EmailSignUpV2> createState() => _EmailSignUpV2State();
}

class _EmailSignUpV2State extends State<EmailSignUpV2> {
  late EmailSignUpProvider provider;

  @override
  void initState() {
    provider = EmailSignUpProvider(this);
    super.initState();
  }

  @override
  void dispose() {
    provider.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<EmailSignUpProvider>.value(
      value: provider,
      builder: (context, _) {
        EmailSignUpProvider signUpProv =
            Provider.of<EmailSignUpProvider>(context, listen: false);
        return GestureDetector(
          onTap: () {
            signUpProv.unfocusAllField();
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                '정보입력',
                style: ShownyStyle.body2(
                  color: ShownyStyle.black,
                  weight: FontWeight.w600,
                ),
              ),
            ),
            body: Container(
              width: ScreenUtil().screenWidth,
              padding: EdgeInsets.symmetric(horizontal: 16.toWidth),
              child: Column(
                children: [
                  const SizedBox(height: 40),
                  _buildInputArea(),
                  const Spacer(),
                  _buildNextButton(context),
                  const SizedBox(height: 24),
                  SizedBox(height: ShownyStyle.defaultBottomPadding()),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInputArea() {
    return Consumer<EmailSignUpProvider>(builder: (ctx, prov, child) {
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
          TitleTextField(
            title: '비밀번호 확인',
            hintText: '비밀번호 확인',
            controller: prov.checkController,
            keyboardType: TextInputType.text,
            isObscure: true,
            inputFormatters: [
              FilteringTextInputFormatter.deny(Validator().kWhiteSpaceRegex)
            ],
            autofillHints: const [AutofillHints.password],
            onChanged: prov.validateCheckPassword,
            onSubmitted: (value) => prov.unfocusAllField(),
          ),
        ],
      );
    });
  }

  Widget _buildNextButton(BuildContext ctx) {
    EmailSignUpProvider prov =
        Provider.of<EmailSignUpProvider>(ctx, listen: false);
    return StreamBuilder<bool>(
        initialData: false,
        stream: Rx.combineLatest3(prov.emailController.statusStream!,
            prov.pwController.statusStream!, prov.checkController.statusStream!,
            (dynamic a, dynamic b, dynamic c) {
          return (a.isValid && b.isValid && c.isValid);
        }),
        builder: (context, snapshot) {
          bool isCheck = snapshot.data!;
          return ShownyButton(
            onPressed: isCheck
                ? () async {
                    if (prov.isLoading) return;
                    prov.setIsLoading(true);
                    await prov.onClickNextButton();
                  }
                : null,
            option: ShownyButtonOption.fill(
              text: '다음',
              theme: ShownyButtonFillTheme.violet,
              style: ShownyButtonFillStyle.fullRegular,
            ),
          );
        });
  }
}
