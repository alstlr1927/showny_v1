import 'package:flutter/material.dart';
import 'package:showny/models/user_model.dart';
import 'package:showny/utils/showny_style.dart';

class Constants {
  static String appName = 'SHOWNY';

  // Theme
  static ThemeData theme = ThemeData(
    fontFamily: 'pretendard',
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.black),
      titleTextStyle: ShownyStyle.body2(
        color: Colors.black,
        weight: FontWeight.w600,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
    ),
  );

  // Text Styles
  static var defaultTextStyle = const TextStyle(
    color: Colors.black,
    fontSize: 14,
    fontFamily: 'pretendard',
    fontWeight: FontWeight.w400,
  );

  static var textFieldHintStyle = defaultTextStyle.copyWith(
    color: const Color(0xFF555555),
  );
  static var textFieldErrorStyle = defaultTextStyle.copyWith(
    color: const Color(0xFF777777),
    fontSize: 12.0,
  );

  static var appBarTitleStyle =
      defaultTextStyle.copyWith(fontWeight: FontWeight.w700);

  static String chatAppId = '540E3A52-E400-4298-8C13-BFC8CCC30EA5';
  static String chatDemoAppId = '728E8736-5D0C-47CE-B934-E39B656900F3';
  static List<UserModel> allUsers = [
    UserModel(memNo: '1071', memNm: 'User1'),
    UserModel(memNo: '1073', memNm: 'User2'),
    UserModel(memNo: '1074', memNm: 'User3'),
    UserModel(memNo: '1075', memNm: 'User4'),
  ];
  static UserModel? currentUser = UserModel();

  static String kakaoNativeAppId = '06b9d3fdb6466739149f91a2707ca75b';
  static String kakaoJavascriptAppId = '20665dd4b2ee2e6e445047491ec1734f';
}

class MiniShopSortType {
  static const int newest = 0;
  static const int recommended = 1;
  static const int lowestPrice = 2;
  static const int highestPrice = 3;
}

class MiniShopTransactionStatus {
  static const int checked = 0;
  static const int unChecked = 2;
}

class MiniShopSearchTransactionStatus {
  static const int checked = 0;
  static const int unChecked = 2;
}

class MiniShopProductsType {
  static const int newGoods = 1;
  static const int oldOnes = 0;
}

class MiniShopSearchProductsType {
  static const int newGoods = 1;
  static const int oldOnes = 0;
}

class MiniShopProductsViewWearingShot {
  static const int view = 1;
  static const int hide = 0;
}

class MiniShopSearchProductsViewWearingShot {
  static const int view = 1;
  static const int hide = 0;
}

class StoreSelectionTab {
  static const int men = 0;
  static const int women = 1;
  static const int brand = 2;
}
