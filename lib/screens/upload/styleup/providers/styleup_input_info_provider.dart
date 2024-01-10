import 'package:flutter/material.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/screens/intro/components/preset_color_button.dart';
import 'package:showny/screens/upload/styleup/styleup_item_tag.dart';
import 'package:showny/screens/upload/styleup/stylup_input_info.dart';

class StyleupInputInfoProvider with ChangeNotifier {
  State<StyleupInputInfo> state;

  // description
  TextEditingController desController = TextEditingController();
  FocusNode desFocusNode = FocusNode();
  String description = '';
  int get descriptionLeng => description.length;

  // style tag
  TextEditingController tagController = TextEditingController();
  FocusNode tagFocusNode = FocusNode();
  ScrollController styleTagScrollController = ScrollController();
  String tagText = '';
  List<String> selectedStyleTags = [];

  // main color
  List<PresetColor> selectedColors = [];

  // season
  Season? selectedSeason;

  // item tag
  List<List<StoreGoodModel?>?>? goodsDataList;

  // carousel idx
  int viewIdx = 0;

  void changeIdx(int idx) {
    viewIdx = idx;
    notifyListeners();
  }

  void unfocusedAll() {
    desFocusNode.unfocus();
    tagFocusNode.unfocus();
  }

  void setDescription(String val) {
    description = val;
    notifyListeners();
  }

  void setTagText(String val) {
    tagText = val;
    notifyListeners();
  }

  void onClickAddTag() {
    if (!selectedStyleTags.contains(tagController.text.trim())) {
      selectedStyleTags.add(tagController.text.trim());
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        styleTagScrollController.animateTo(
            styleTagScrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut);
      });
    }

    tagController.clear();
    notifyListeners();
  }

  void onClickDeleteTag(String val) {
    int deleteIdx = selectedStyleTags.indexWhere((element) => element == val);
    if (deleteIdx == -1) return;
    selectedStyleTags.removeAt(deleteIdx);
    notifyListeners();
  }

  void onClickColor(PresetColor newColor) {
    if (selectedColors.contains(newColor)) {
      selectedColors.remove(newColor);
    } else {
      if (selectedColors.length <= 2) {
        selectedColors.add(newColor);
      }
    }
    notifyListeners();
  }

  void onClickSeason(Season season) {
    if (selectedSeason == season) {
      selectedSeason = null;
    } else {
      selectedSeason = season;
    }
    print(season);
    notifyListeners();
  }

  void onClickItemTagTile() {
    String type = state.widget.type;
    Navigator.push(
        state.context,
        MaterialPageRoute(
          builder: (context) => StyleupItemTag(
            onCompleted: (v) {},
            type: state.widget.type,
            goodsDataList: goodsDataList,
            imgFileList: type == 'img' ? state.widget.fileList : [],
          ),
        ));
  }

  @override
  void notifyListeners() {
    if (state.mounted) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    desController.dispose();
    desFocusNode.dispose();
    tagController.dispose();
    tagFocusNode.dispose();
    styleTagScrollController.dispose();
    super.dispose();
  }

  StyleupInputInfoProvider(this.state) {
    int fileCount = state.widget.fileList.length;
    if (state.widget.type == 'img') {
      goodsDataList = List.filled(fileCount, null);
      for (int i = 0; i < fileCount; i++) {
        List<StoreGoodModel?> goodsDataListTemp =
            List<StoreGoodModel?>.filled(6, null);
        goodsDataList![i] = goodsDataListTemp;
      }
    } else {
      goodsDataList = List.filled(1, List<StoreGoodModel?>.filled(6, null));
    }
    print('print : ${goodsDataList}');
  }
}
