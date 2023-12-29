import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/intro/screen/login_popup_screen.dart';
import 'package:showny/screens/tabs/home/home_screen.dart';
import 'package:showny/screens/tabs/profile/profile_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key, this.isChangeIndex});
  final bool? isChangeIndex;
  static String routeName = '/root_screen';

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIdx = 0;
  late List<Widget> _tabs;

  var isFirstUse = true;
  static DateTime? _lastPressedAt;

  @override
  void initState() {
    super.initState();
    _tabs = [
      const HomeScreen(),
      const SizedBox(),
      const SizedBox(),
      const SizedBox(),
      ProfileScreen(),
    ];
    _lastPressedAt ??= DateTime.now().subtract(const Duration(seconds: 3));
    isFirstCheck();
    if (widget.isChangeIndex ?? false) {
      _currentIdx = 1;
    }
  }

  void isFirstCheck() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final bool isFirst = prefs.getBool("isFirstUse") ?? true;
    setState(() {
      isFirstUse = isFirst;
    });
    debugPrint("isFirst");
    debugPrint(isFirst.toString());
  }

  void setIsFirstUse() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isFirstUse", false);
  }

  getTabSelected(int idx) => _currentIdx == idx;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final now = DateTime.now();
        if (now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
          _lastPressedAt = now;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('한번 더 뒤로가기를 누를 시 종료됩니다'),
              duration: Duration(seconds: 2),
            ),
          );
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Scaffold(
              extendBody: false,
              body: IndexedStack(
                index: _currentIdx,
                children: _tabs,
              ),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8.0,
                      offset: const Offset(0, -4),
                    )
                  ],
                ),
                child: SafeArea(
                  child: SizedBox(
                    height: 56,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        BottomTabButton(
                          icon: "home",
                          isSelected: getTabSelected(0),
                          onTap: () => setState(() => _currentIdx = 0),
                        ),
                        BottomTabButton(
                          icon: "feed",
                          isSelected: getTabSelected(1),
                          onTap: () => setState(() {
                            UserProvider userProvider =
                                Provider.of<UserProvider>(context,
                                    listen: false);
                            final user = userProvider.user;

                            debugPrint(user.memNo);
                            if (user.memNo == "") {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.0),
                                      topRight: Radius.circular(12.0),
                                    ),
                                  ),
                                  builder: (BuildContext context) {
                                    return const LoginPopupScreen();
                                  });
                              return;
                            }
                            _currentIdx = 1;
                          }),
                        ),
                        BottomTabButton(
                          icon: "shop",
                          isSelected: getTabSelected(2),
                          onTap: () => setState(() => _currentIdx = 2),
                        ),
                        BottomTabButton(
                          icon: "networking",
                          isSelected: getTabSelected(3),
                          onTap: () => setState(() {
                            UserProvider userProvider =
                                Provider.of<UserProvider>(context,
                                    listen: false);
                            final user = userProvider.user;

                            debugPrint(user.memNo);
                            if (user.memNo == "") {
                              showModalBottomSheet(
                                  context: context,
                                  isScrollControlled: true,
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(12.0),
                                      topRight: Radius.circular(12.0),
                                    ),
                                  ),
                                  builder: (BuildContext context) {
                                    return const LoginPopupScreen();
                                  });
                              return;
                            }
                            _currentIdx = 3;
                          }),
                        ),
                        BottomTabButton(
                          icon: "profile",
                          isSelected: getTabSelected(4),
                          onTap: () => setState(() => _currentIdx = 4),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            isFirstUse
                ? SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                          color: Colors.black.withOpacity(0.4),
                          alignment: Alignment.center,
                          child: Image.asset('assets/icons/init_guide.png'),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isFirstUse = false;
                              setIsFirstUse();
                            });
                          },
                        )
                      ],
                    ),
                  )
                : const SizedBox(width: 0, height: 0)
          ],
        ),
      ),
    );
  }
}

class BottomTabButton extends StatelessWidget {
  const BottomTabButton({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  final String icon;
  final bool isSelected;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Bounceable(
      onTap: onTap,
      child: Image.asset(
        isSelected
            ? 'assets/icons/${icon}_black.png'
            : 'assets/icons/$icon.png',
        height: 24.0,
        width: 24.0,
      ),
    );
  }
}
