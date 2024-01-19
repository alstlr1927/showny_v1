import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/components/user_profile/profile_container.dart';
import 'package:showny/models/user_model.dart';
import 'package:showny/screens/tabs/profile/my_profile/components/sv_inline_button.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/profile/other_profile_screen.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class ProfileFollowerScreen extends StatefulWidget {
  const ProfileFollowerScreen({
    super.key,
    required this.profileMemNo,
  });

  final String? profileMemNo;

  @override
  State<ProfileFollowerScreen> createState() => ProfileFollowerScreenState();
}

class ProfileFollowerScreenState extends State<ProfileFollowerScreen> {
  final List<UserModel> followerList = [];

  void getFollowerList(page) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final profileMemNo = widget.profileMemNo;
    ApiHelper.shared.getFollowerList(user.memNo, profileMemNo, page,
        (userList) {
      setState(() {
        followerList.clear();
        followerList.addAll(userList);
      });
    }, (error) {});
  }

  void getProfile() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    ApiHelper.shared.getProfile(user.memNo, user.memNo, (getUser) {
      debugPrint(getUser.memNo);
      userProvider.updateUserInfo(getUser);
    }, (error) {});
  }

  @override
  void initState() {
    super.initState();
    getFollowerList(0);
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    return Scaffold(
        appBar: AppBar(
          title: Text(tr('profile_screen.followers')),
          centerTitle: true,
          scrolledUnderElevation: 0,
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
          itemCount: followerList.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 40.toWidth,
              child: ListTile(
                  title: GestureDetector(
                    onTap: () {
                      if (Provider.of<UserProvider>(context, listen: false)
                              .user
                              .memNo ==
                          followerList[index].memNo) {
                      } else {
                        Navigator.push(
                            context,
                            ShownyPageRoute(
                                builder: (context) => OtherProfileScreen(
                                      memNo: followerList[index].memNo,
                                    ),
                                settings: const RouteSettings(
                                    name: PageName.OTHER_PROFILE)));
                      }
                    },
                    child: Text(
                      followerList[index].nickNm,
                      style: ShownyStyle.caption(
                          color: ShownyStyle.black, weight: FontWeight.w400),
                    ),
                  ),
                  leading: ProfileContainer.size40(
                    url: followerList[index].profileImage,
                    onPressed: () {
                      if (Provider.of<UserProvider>(context, listen: false)
                              .user
                              .memNo ==
                          followerList[index].memNo) {
                        //
                      } else {
                        Navigator.push(
                            context,
                            ShownyPageRoute(
                                builder: (context) => OtherProfileScreen(
                                      memNo: followerList[index].memNo,
                                    ),
                                settings: const RouteSettings(
                                    name: PageName.OTHER_PROFILE)));
                      }
                    },
                  ),
                  trailing: followerList[index].memNo != user.memNo
                      ? SVInlineButton(
                          strokeColor: followerList[index].isFollow
                              ? const Color(0xffcccccc)
                              : ShownyStyle.mainPurple,
                          constraints: const BoxConstraints(minWidth: 64),
                          onPressed: () {
                            setState(() {
                              followerList[index].isFollow =
                                  !followerList[index].isFollow;
                            });
                            if (followerList[index].isFollow) {
                              ApiHelper.shared.followUser(
                                  user.memNo, followerList[index].memNo,
                                  (success) {
                                getProfile();
                              }, (error) {});
                            } else {
                              ApiHelper.shared.unFollowUser(
                                  user.memNo, followerList[index].memNo,
                                  (success) {
                                getProfile();
                              }, (error) {});
                            }
                          },
                          text: followerList[index].isFollow == true
                              ? tr(
                                  'product_detail.seller_information.following_text')
                              : tr('profile_screen.follow'),
                          textColor: followerList[index].isFollow
                              ? Colors.black
                              : Colors.white,
                          backgroundColor: followerList[index].isFollow
                              ? Colors.white
                              : ShownyStyle.mainPurple,
                          padding: const EdgeInsets.symmetric(
                              vertical: 6, horizontal: 20),
                        )
                      : const SizedBox()),
            );
          },
        ));
  }
}
