import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/intro/screen/login_screen.dart';
import 'package:showny/screens/tabs/profile/my_shop/my_shop_screen.dart';
import 'package:showny/screens/tabs/profile/myshopping/pages/my_shopping_page.dart';
import 'package:showny/screens/tabs/profile/profile_not_logged_in_screen.dart';
import 'package:showny/screens/tabs/profile/provider/get_my_profile_provider.dart';
import 'package:showny/screens/tabs/profile/provider/getstore_cartlist_provider.dart';
import 'package:showny/screens/tabs/profile/provider/request_return_provider.dart';
import '../../../utils/images.dart';
import 'my_profile/my_profile_screen.dart';
import 'profile_tab_button.dart';

class ProfileScreen extends StatefulWidget {
  bool? isBack = false;

  ProfileScreen({super.key, this.category, this.isBack});
  final ProfilePageCategory? category;
  static const routeName = "profile_screen";

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const storage = FlutterSecureStorage();

  void logout() async {
    await storage.delete(key: 'email');
    await storage.delete(key: 'password');
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        LoginScreen.routeName,
            (route) => false,
      );
    }
  }

  ProfilePageCategory? category;
  @override
  void initState() {
    super.initState();
    category = widget.category ?? ProfilePageCategory.myProfile;
    Provider.of<GetMyProfileProvider>(context, listen: false).getProfileData(context);
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    debugPrint(user.memNo);
    if (user.memNo == "") {
      return const ProfileNotLoggedInScreen();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(user.memId, style: FontHelper.appBarTitle,),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: widget.isBack == true
            ? GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Image.asset(
              arrowBackward,
              height: 18,
              width: 9,
            ),
          ),
        )
            : null,
        actions: [
          CupertinoButton(
            minSize: 0.0,
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            onPressed: (){
              // Navigator.push(
              //     context, PageRouteBuilderRightLeft(
              //     child: const SettingPage()));
            },
            child: Image.asset(
              'assets/icons/setting.png',
              width: 24.0,
              height: 24.0,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [

            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ProfieTabButton<ProfilePageCategory>(
                        currentCategory: category!,
                        category: ProfilePageCategory.myProfile,
                        onTap: () {
                          setState(() {
                            category = ProfilePageCategory.myProfile;
                          });
                        },
                      ),
                      Container(
                          width: 1, height: 12, color: const Color(0xFF444444)),
                      ProfieTabButton<ProfilePageCategory>(
                        currentCategory: category!,
                        category: ProfilePageCategory.myShop,
                        onTap: () {
                          setState(() {
                            category = ProfilePageCategory.myShop;
                          });
                        },
                      ),
                      Container(
                          width: 1, height: 12, color: const Color(0xFF444444)),
                      ProfieTabButton<ProfilePageCategory>(
                        currentCategory: category!,
                        category: ProfilePageCategory.myShopping,
                        onTap: () {
                          setState(() {
                            category = ProfilePageCategory.myShopping;
                          });
                        },
                      ),
                    ],
                  ),
                  pageAtCategory(),
                ],
              ),
            ),
            if (category == ProfilePageCategory.myProfile ||
                category == ProfilePageCategory.myShop) ...[
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FloatingActionButton(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                        child: const Icon(Icons.camera_alt),
                        onPressed: () {
                        //   Navigator.push(
                        //         context,
                        //         PageRouteBuilderRightLeft(
                        //             child: UploadContentScreen(
                        //         onCompleted: () {
                        //           Provider.of<GetMyProfileProvider>(context, listen: false).getProfileData(context);
                        //           Provider.of<GetMyProfileProvider>(context, listen: false).getMyStyleupList(context);
                        //           Provider.of<GetMyProfileProvider>(context, listen: false).getMyBookmarkList(context);
                        // })));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 28),
                ],
              ),

            ],
              category==ProfilePageCategory.myShopping && (Provider.of<RequestReturnProvider>(context).selectedIndex ==
                  0)? Positioned(
              bottom: 10,
              left: 16,
              right: 16,
              child: Consumer<GetStoreCartListProvider>(
                builder: (context, getStoreCartListProvider, child) =>
                SizedBox()
                    // CommonButtonWidget(
                    //   text: tr('my_profile.btn_text'),
                    //   radius: 12,
                    //   height: 48,
                    //   color: !getStoreCartListProvider.checkFalse() ? grey444 : black,
                    //   textcolor: white,
                    //   onTap: !getStoreCartListProvider.checkFalse()
                    //       ? null
                    //       : () {
                        // List<cartResponse.Data> newList =
                        // getStoreCartListProvider
                        //     .getProducts()
                        //     .where((i) => (i.isSelected ?? false))
                        //     .toList();
                        // context
                        //     .read<OrderFormProvider>()
                        //     .setCartProducts(newList);
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const OrderFormScreen(),
                        //     ));
                    //   },
                    // ),
              ),):Container(),

          ],

        ),
      ),
    );
  }

  Widget pageAtCategory() {
    switch (category!) {
      case ProfilePageCategory.myProfile:
        return const MyProfileScreen();
      case ProfilePageCategory.myShop:
        return const MyShopScreen();
      case ProfilePageCategory.myShopping:
        return const MyShoppingPage();
    }
  }
}

enum ProfilePageCategory with CategoryMixin {
  myProfile,
  myShop,
  myShopping;

  @override
  String get name {
    switch (this) {
      case ProfilePageCategory.myProfile:
        return "내 프로필";
      case ProfilePageCategory.myShop:
        return "내 상점";
      case ProfilePageCategory.myShopping:
        return "내 쇼핑";
    }
  }
}
