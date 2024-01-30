import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/providers/user_model_provider.dart';

import '../../../../api/new_api/api_helper.dart';
import '../../../../models/store_good_model.dart';
import '../widgets/tab_store_category.dart';

enum Category {
  outer('아우터', '001'),
  top('상의', '002'),
  bottom('하의', '003'),
  shoes('신발', '004'),
  accessory('악세서리', '005'),
  stuff('잡화', '006');

  const Category(this.name, this.code);
  final String name;
  final String code;
}

class StoreTabHomeProvider with ChangeNotifier {
  State state;

  GenderType selectGender = GenderType.female;

  bool get isFemale => selectGender == GenderType.female;
  bool get isMale => selectGender == GenderType.male;

  List<StoreGoodModel> outerList = [];
  List<StoreGoodModel> topList = [];
  List<StoreGoodModel> bottomList = [];
  List<StoreGoodModel> shoesList = [];
  List<StoreGoodModel> accessoryList = [];
  List<StoreGoodModel> stuffList = [];

  void setOuterList(List<StoreGoodModel> list) {
    outerList = [...list];
    notifyListeners();
  }

  void setTopList(List<StoreGoodModel> list) {
    topList = [...list];
    notifyListeners();
  }

  void setBotList(List<StoreGoodModel> list) {
    bottomList = [...list];
    notifyListeners();
  }

  void setShoesList(List<StoreGoodModel> list) {
    shoesList = [...list];
    notifyListeners();
  }

  void setAccessoryList(List<StoreGoodModel> list) {
    accessoryList = [...list];
    notifyListeners();
  }

  void setStuffList(List<StoreGoodModel> list) {
    stuffList = [...list];
    notifyListeners();
  }

  void setSelectGender(GenderType gender) {
    selectGender = gender;
    notifyListeners();
  }

  Future _getNewestProduct({
    required String mainCategory,
    required String categoryCode,
    required Function(List<StoreGoodModel>) setList,
  }) async {
    UserProvider userProvider =
        Provider.of<UserProvider>(state.context, listen: false);
    ApiHelper.shared.getGoodsList(
        userProvider.user.memNo,
        '',
        mainCategory,
        categoryCode,
        '',
        1,
        null,
        null,
        null,
        null,
        null,
        null,
        null,
        0,
        1, (response) {
      setList(response.goodsList);
    }, (error) {
      setList([]);
    });
  }

  Future getNewestProductList() async {
    String code = selectGender == GenderType.female ? '008' : '007';
    _getNewestProduct(
        mainCategory: code,
        categoryCode: Category.outer.code,
        setList: setOuterList);
    _getNewestProduct(
        mainCategory: code,
        categoryCode: Category.top.code,
        setList: setTopList);
    _getNewestProduct(
        mainCategory: code,
        categoryCode: Category.bottom.code,
        setList: setBotList);
    _getNewestProduct(
        mainCategory: code,
        categoryCode: Category.shoes.code,
        setList: setShoesList);
    _getNewestProduct(
        mainCategory: code,
        categoryCode: Category.accessory.code,
        setList: setAccessoryList);
    _getNewestProduct(
        mainCategory: code,
        categoryCode: Category.stuff.code,
        setList: setStuffList);
  }

  @override
  void notifyListeners() {
    if (state.mounted) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  StoreTabHomeProvider(this.state) {
    getNewestProductList();
  }
}
