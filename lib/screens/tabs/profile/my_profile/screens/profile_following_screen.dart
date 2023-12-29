import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/models/user_model.dart';
import 'package:showny/screens/common/components/page_route_builder_right_left.dart';
import 'package:showny/screens/tabs/profile/my_profile/components/sv_inline_button.dart';
import 'package:provider/provider.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/tabs/profile/my_profile/components/sv_inline_button.dart';
import 'package:showny/screens/tabs/profile/other_profile_screen.dart';
import 'package:showny/screens/tabs/profile/profile_screen.dart';

import '../../../../../constants.dart';
import '../../../../common/components/app_bar_widget.dart';

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
        appBar: AppBarWidget(
          title: tr('product_detail.seller_information.following_text'),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 24),
          child: ListView.separated(
            separatorBuilder: (context, index) {
              return const SizedBox(height: 16);
            },
            itemCount: followingList.length,
            itemBuilder: (context, index) {
              return SizedBox(
                height: 40,
                child: ListTile(
                    title: GestureDetector(
                      onTap: () {
                          if(Provider.of<UserProvider>(context, listen: false).user.memNo == followingList[index].memNo) {
                            Navigator.push(
                              context,
                              PageRouteBuilderRightLeft(
                                  child: ProfileScreen(isBack: true,)));
                          } else {
                            Navigator.push(
                              context,
                              PageRouteBuilderRightLeft(
                                  child: OtherProfileScreen(
                                memNo: followingList[index].memNo,
                              )));
                        }
                      },
                      child: Text(followingList[index].nickNm,
                        style: Constants.defaultTextStyle),
                    ),
                    leading: Container(
                      width: 40,
                      height: 40,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image:
                          NetworkImage(followingList[index].profileImage),
                          fit: BoxFit.cover,
                        ),
                        shape: const OvalBorder(),
                      ),
                      child: GestureDetector(onTap: () {
                        if(Provider.of<UserProvider>(context, listen: false).user.memNo == followingList[index].memNo) {
                          Navigator.push(
                            context,
                            PageRouteBuilderRightLeft(
                                child: ProfileScreen(isBack: true,)));
                        } else {
                          Navigator.push(
                            context,
                            PageRouteBuilderRightLeft(
                                child: OtherProfileScreen(
                              memNo: followingList[index].memNo,
                            )));
                        }
                      }),
                    ),
                    trailing: followingList[index].memNo != user.memNo ? SVInlineButton(
                      height: 24,
                      strokeColor: followingList[index].isFollow
                          ? const Color(0xffcccccc)
                          : Colors.black,
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
                      text:
                      followingList[index].isFollow == true ? "팔로잉" : "팔로우",
                      textColor: followingList[index].isFollow
                          ? Colors.black
                          : Colors.white,
                      backgroundColor: followingList[index].isFollow
                          ? Colors.white
                          : Colors.black,
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 20),
                    ): const SizedBox()),
              );
            },
          ),
        ));
  }
}
