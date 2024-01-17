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

class ProfileFollowingScreen extends StatefulWidget {
  const ProfileFollowingScreen({
    super.key,
    required this.profileMemNo,
  });

  final String? profileMemNo;

  @override
  State<ProfileFollowingScreen> createState() => ProfileFollowerScreenState();
}

class ProfileFollowerScreenState extends State<ProfileFollowingScreen> {
  final List<UserModel> followingList = [];

  void getFollowerList(page) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;
    final profileMemNo = widget.profileMemNo;
    ApiHelper.shared.getFollowList(user.memNo, profileMemNo, page, (userList) {
      setState(() {
        followingList.clear();
        followingList.addAll(userList);
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
          title: Text(tr('product_detail.seller_information.following_text')),
          centerTitle: true,
          scrolledUnderElevation: 0,
        ),
        body: ListView.separated(
          separatorBuilder: (context, index) {
            return const SizedBox(height: 16);
          },
          itemCount: followingList.length,
          itemBuilder: (context, index) {
            return SizedBox(
              height: 40.toWidth,
              child: ListTile(
                  title: GestureDetector(
                    onTap: () {
                      if (Provider.of<UserProvider>(context, listen: false)
                              .user
                              .memNo ==
                          followingList[index].memNo) {
                        // Navigator.push(
                        //     context,
                        //     PageRouteBuilderRightLeft(
                        //         child: ProfileScreen(
                        //       isBack: true,
                        //     )));
                      } else {
                        Navigator.push(
                            context,
                            ShownyPageRoute(
                                builder: (context) => OtherProfileScreen(
                                      memNo: followingList[index].memNo,
                                    ),
                                settings: const RouteSettings(
                                    name: PageName.OTHER_PROFILE)));
                      }
                    },
                    child: Text(
                      followingList[index].nickNm,
                      style: ShownyStyle.caption(
                          color: ShownyStyle.black, weight: FontWeight.w400),
                    ),
                  ),
                  leading: ProfileContainer.size40(
                    url: followingList[index].profileImage,
                    onPressed: () {
                      if (Provider.of<UserProvider>(context, listen: false)
                              .user
                              .memNo ==
                          followingList[index].memNo) {
                        //
                      } else {
                        Navigator.push(
                            context,
                            ShownyPageRoute(
                                builder: (context) => OtherProfileScreen(
                                      memNo: followingList[index].memNo,
                                    ),
                                settings: const RouteSettings(
                                    name: PageName.OTHER_PROFILE)));
                      }
                    },
                  ),
                  trailing: followingList[index].memNo != user.memNo
                      ? SVInlineButton(
                          strokeColor: followingList[index].isFollow
                              ? const Color(0xffcccccc)
                              : ShownyStyle.mainPurple,
                          constraints: const BoxConstraints(minWidth: 64),
                          onPressed: () {
                            setState(() {
                              followingList[index].isFollow =
                                  !followingList[index].isFollow;
                            });
                            if (followingList[index].isFollow) {
                              ApiHelper.shared.followUser(
                                  user.memNo, followingList[index].memNo,
                                  (success) {
                                getProfile();
                              }, (error) {});
                            } else {
                              ApiHelper.shared.unFollowUser(
                                  user.memNo, followingList[index].memNo,
                                  (success) {
                                getProfile();
                              }, (error) {});
                            }
                          },
                          text: followingList[index].isFollow == true
                              ? "팔로잉"
                              : "팔로우",
                          textColor: followingList[index].isFollow
                              ? Colors.black
                              : Colors.white,
                          backgroundColor: followingList[index].isFollow
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
