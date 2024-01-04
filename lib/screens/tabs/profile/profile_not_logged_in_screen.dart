import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/constants.dart';
import 'package:showny/screens/common/components/page_route_builder_right_left.dart';
import 'package:showny/screens/intro/screen/sign_up_screen.dart';

class ProfileNotLoggedInScreen extends StatefulWidget {
  const ProfileNotLoggedInScreen({
    super.key,
  });

  @override
  State<ProfileNotLoggedInScreen> createState() =>
      _ProfileNotLoggedInScreenState();
}

class _ProfileNotLoggedInScreenState extends State<ProfileNotLoggedInScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          tr('profile_screen.profile'),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              tr('profile_screen.use_it_after_registering'),
              style: TextStyle(
                color: Color(0xFF777777),
                fontSize: 12,
                fontFamily: 'pretendard',
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            CupertinoButton(
              minSize: 0.0,
              padding: EdgeInsets.zero,
              child: Container(
                width: 160.0,
                height: 48.0,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: Center(
                  child: Text(
                    tr('profile_screen.join'),
                    style: Constants.defaultTextStyle
                        .copyWith(color: Colors.white),
                  ),
                ),
              ),
              onPressed: () {
                Navigator.push(context,
                    PageRouteBuilderRightLeft(child: const SignUpScreen()));
              },
            ),
          ],
        ),
      )),
    );
  }
}
