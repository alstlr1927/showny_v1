import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/constants.dart';
import 'package:showny/screens/common/components/sv_button.dart';

class SendResetPasswordMailScreen extends StatefulWidget {
  const SendResetPasswordMailScreen({
    super.key,
    required this.sendSuccess,
    required this.recentRouteName,
    required this.mailAddress,
  });

  final bool sendSuccess;
  final String recentRouteName;
  final String mailAddress;

  @override
  State<SendResetPasswordMailScreen> createState() =>
      _SendResetPasswordMailScreenState();
}

class _SendResetPasswordMailScreenState
    extends State<SendResetPasswordMailScreen> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(tr("send_reset_password_mail_screen.find_password")),
        leading: CupertinoButton(
          padding: EdgeInsets.zero,
          child: Image.asset(
            'assets/icons/back_button.png',
            width: 20.0,
            height: 20.0,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              const Spacer(),
              Image.asset(
                'assets/icons/mail_open.png',
                width: 96.0,
                height: 96.0,
              ),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  widget.mailAddress,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Spoqa Han Sans Neo',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Text(
                tr("send_reset_password_mail_screen.sent_mail_message"),
                style: Constants.textFieldErrorStyle,
              ),
              const Spacer(),
              SVButton(
                title: tr("common.confirm"),
                titleColor: Colors.white,
                backgroundColor: Colors.black,
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 24.0),
            ],
          ),
        ),
      ),
    );
  }
}
