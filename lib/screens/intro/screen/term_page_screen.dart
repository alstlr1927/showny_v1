import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/helper/font_helper.dart';


class TermPageScreen extends StatefulWidget {
  final String term;
  const TermPageScreen({super.key, required this.term});

  static String routeName = 'input_additional_info_screen';

  @override
  State<TermPageScreen> createState() =>
      _TermPageScreen();
}

class _TermPageScreen extends State<TermPageScreen> {

  var appBarTitle = '';
  var content = '';

  @override
  void initState() {
    super.initState();

    switch (widget.term) {
      case 'privacy':
        appBarTitle = tr("terms_screen.privacy2");
        ApiHelper.shared.getPrivacy(
          (getContent) {
            setState(() {
              content = getContent;  
            });
          },
          (error) {});
      case 'terms':
        appBarTitle = tr("terms_screen.terms2");
        ApiHelper.shared.getTerms(
          (getContent) {
            setState(() {
              content = getContent;  
            });
          },
          (error) {});
      case 'marketing':
        appBarTitle = tr("terms_screen.marketing2");
        ApiHelper.shared.getMarketing(
          (getContent) {
            setState(() {
              content = getContent;  
            });
          },
          (error) {});
    }
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: CupertinoButton(
          child: Image.asset(
            'assets/icons/back_button.png',
            width: 20.0,
            height: 20.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(appBarTitle, style: FontHelper.bold_16_000000,),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Text(content),),
    );
  }
}
