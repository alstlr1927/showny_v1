import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/models/styleup_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/common/components/page_route_builder_right_left.dart';
import 'package:showny/screens/home/widgets/following_button.dart';
import 'package:showny/screens/profile/other_profile_screen.dart';
import 'package:showny/screens/profile/profile_screen.dart';

class StyleupScreenProfile extends StatefulWidget {
  const StyleupScreenProfile({super.key, required this.styleupModel});

  final StyleupModel styleupModel;

  @override
  State<StyleupScreenProfile> createState() => _StyleupScreenProfile();
}

class _StyleupScreenProfile extends State<StyleupScreenProfile> {
  late StyleupModel styleupData;
  bool isExpandDescription = false;

  @override
  void initState() {
    super.initState();
    styleupData = widget.styleupModel;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.5),
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: NetworkImage(styleupData.userInfo.profileImage),
                    fit: BoxFit.cover),
              ),
              child: GestureDetector(
                onTap: () {
                  if (Provider.of<UserProvider>(context, listen: false)
                          .user
                          .memNo ==
                      styleupData.userInfo.memNo) {
                    Navigator.push(
                        context,
                        PageRouteBuilderRightLeft(
                            child: ProfileScreen(
                          isBack: true,
                        )));
                  } else {
                    Navigator.push(
                        context,
                        PageRouteBuilderRightLeft(
                            child: OtherProfileScreen(
                          memNo: styleupData.userInfo.memNo,
                        )));
                  }
                },
              ),
            ),
            const SizedBox(width: 8.0),
            GestureDetector(
              onTap: () {
                if (Provider.of<UserProvider>(context, listen: false)
                        .user
                        .memNo ==
                    styleupData.userInfo.memNo) {
                  Navigator.push(
                      context,
                      PageRouteBuilderRightLeft(
                          child: ProfileScreen(
                        isBack: true,
                      )));
                } else {
                  Navigator.push(
                      context,
                      PageRouteBuilderRightLeft(
                          child: OtherProfileScreen(
                        memNo: styleupData.userInfo.memNo,
                      )));
                }
              },
              child: Text(
                styleupData.userInfo.nickNm,
                style: const TextStyle(
                  shadows: [
                    Shadow(
                      blurRadius: 2.0,
                      color: Colors.black87,
                    ),
                  ],
                  fontSize: 16.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(width: 8.0),
            styleupData.userInfo.isFollow == false
                ? FollowingButton(
                    isFollow: styleupData.userInfo.isFollow,
                    memNo: styleupData.memNo,
                    onCompleted: (value) {
                      styleupData.userInfo.isFollow = value;
                    },
                  )
                : const SizedBox()
          ],
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 2, right: 58),
          child: GestureDetector(
            onTap: () {
              setState(() {
                isExpandDescription = !isExpandDescription;
              });
            },
            child: Text(
              styleupData.description,
              textAlign: TextAlign.left,
              style: const TextStyle(
                shadows: [
                  Shadow(
                    blurRadius: 4.0,
                    color: Color(0xA3000000),
                  ),
                ],
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: isExpandDescription == true ? 15 : 2,
            ),
          ),
        )
      ],
    );
  }
}
