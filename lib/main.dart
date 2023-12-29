import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kakao_flutter_sdk_common/kakao_flutter_sdk_common.dart';
import 'package:provider/provider.dart' as prod;
import 'package:sendbird_chat_sdk/sendbird_chat_sdk.dart';
import 'package:showny/constants.dart';
import 'package:showny/navigator_key.dart';
import 'package:showny/providers/FetchGetMemberMinishopProductProvider.dart';
import 'package:showny/providers/storeListProvider.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/routes.dart';
import 'package:showny/screens/intro/screen/login_screen.dart';
import 'package:showny/screens/tabs/profile/my_shop/provider/report_provider.dart';
import 'package:showny/screens/tabs/profile/other_profile_tab2_provider.dart';
import 'package:showny/screens/tabs/profile/provider/get_my_profile_provider.dart';
import 'package:showny/screens/tabs/profile/provider/request_return_provider.dart';
import 'package:showny/screens/tabs/profile/provider/get_cancel_infodetail_provider.dart';
import 'package:showny/screens/tabs/profile/provider/get_profile_provider.dart';
import 'package:showny/screens/tabs/profile/provider/getstore_cancel_list_provider.dart';
import 'package:showny/screens/tabs/profile/provider/getstore_cartlist_provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //Sendbird
  SendbirdChat.init(appId: Constants.chatAppId);

  //Kakao
  KakaoSdk.init(
    nativeAppKey: Constants.kakaoNativeAppId,
    javaScriptAppKey: Constants.kakaoJavascriptAppId,
  );
  //Google
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await EasyLocalization.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('ko', 'KR')],
        path: 'assets/translations',
        fallbackLocale: const Locale('ko', 'KR'),
        child: const ProviderScope(child: MyApp())),
  );
}

var formatter = NumberFormat("#,###");

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return prod.MultiProvider(
      providers: [
        prod.ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        prod.ChangeNotifierProvider(
          create: (context) => GetProfileProvider(),
        ),
        prod.ChangeNotifierProvider(
          create: (context) => GetStoreCartListProvider(),
        ),
        prod.ChangeNotifierProvider(
          create: (context) => GetCancelInfoDetailProvider(),
        ),
        prod.ChangeNotifierProvider(
          create: (context) => GetStoreCancelListProvider(),
        ),
        prod.ChangeNotifierProvider(
          create: (context) => RequestReturnProvider(),
        ),
        prod.ChangeNotifierProvider(
          create: (context) => StoreListProvider(),
        ),
        prod.ChangeNotifierProvider(
          create: (context) => ReportProvider(),
        ),
        prod.ChangeNotifierProvider(
          create: (context) => RequestReturnProvider(),
        ),
        prod.ChangeNotifierProvider(
          create: (context) => OtherProfileTab2Provider(),
        ),
        prod.ChangeNotifierProvider(
          create: (context) => FetchGetMemberMinishopProductProvider(),
        ),
        prod.ChangeNotifierProvider(
          create: (context) => GetMyProfileProvider(),
        ),
      ],
      child: MaterialApp(
        title: Constants.appName,
        debugShowCheckedModeBanner: false,
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: Constants.theme,
        home: const LoginScreen(),
        routes: routes,
        navigatorKey: NavigatorKeys.navigatorKeyMain,
      ),
    );
  }
}
