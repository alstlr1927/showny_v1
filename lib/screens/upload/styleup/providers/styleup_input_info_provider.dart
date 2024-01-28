import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/components/page_route.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/models/style.dart';
import 'package:showny/models/user_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/intro/components/preset_color_button.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';
import 'package:showny/providers/get_my_profile_provider.dart';
import 'package:showny/screens/upload/styleup/styleup_item_tag.dart';
import 'package:showny/screens/upload/styleup/styleup_style_tag.dart';
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

  // style tag
  List<Style> selectedStyles = [];

  // main color
  List<PresetColor> selectedColors = [];

  // season
  Season? selectedSeason;

  // item tag
  List<List<StoreGoodModel?>?> goodsDataList = [];

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

  void setStyles(List<Style> styles) {
    selectedStyles = [...styles];
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

    notifyListeners();
  }

  void onClickItemTagTile() {
    String type = state.widget.type;

    Navigator.push(
        state.context,
        ShownyPageRoute(
          builder: (context) => StyleupItemTag(
            onCompleted: (goodsList) {
              goodsDataList = deepCopyGoodsDataList(goodsList!);
              notifyListeners();
            },
            type: type,
            goodsDataList: deepCopyGoodsDataList(goodsDataList),
            imgFileList:
                type == 'img' ? state.widget.fileList : [state.widget.thumb!],
          ),
        ));
  }

  void onClickStyleTagTile() {
    Navigator.push(
        state.context,
        ShownyPageRoute(
          builder: (context) => StyleupStyleTag(
            selectedStyles: selectedStyles,
            onSelected: setStyles,
          ),
        ));
  }

  void handleUploadButton() {
    UserProvider userProvider =
        Provider.of<UserProvider>(state.context, listen: false);
    final user = userProvider.user;
    final dialog = ShownyDialog(
      message: "스타일업 등록을 완료하시겠습니까?",
      primaryLabel: "취소",
      primaryAction: () {},
      secondaryLabel: '완료',
      secondaryAction: () {
        if (state.widget.type == 'img') {
          // img upload
          uploadImage(user);
        } else {
          // video upload
          uploadVideo(user);
        }
      },
    );
    showDialog(
      context: state.context,
      builder: (context) => dialog,
    );
    // if (state.widget.type == 'img') {
    //   // img upload
    //   uploadImage(user);
    // } else {
    //   // video upload
    //   uploadVideo(user);
    // }
  }

  void uploadImage(UserModel user) {
    debugPrint("API - 스타일업(이미지) 업로드 시작");
    final colorIds =
        selectedColors.map((color) => color.apiId.toString()).toList();
    final seasonID = ((selectedSeason?.index ?? 0) + 1).toString();

    debugPrint("""
            imageUrlList - ${["./test1.png", "./test2.png", "./test3.png"]}
            memNo - ${user.memNo}
            description - $description
            styles - ${user.memNo}
            colors - $colorIds 
            season - $seasonID
              """);

    ApiHelper.shared.insertStyleupImage(state.widget.fileList, user.memNo,
        description, user.memNo, colorIds, seasonID, goodsDataList, (success) {
      debugPrint("API - 스타일업 업로드 성공");
      Provider.of<GetMyProfileProvider>(state.context, listen: false)
          .removeMyStyleupList();
      Provider.of<GetMyProfileProvider>(state.context, listen: false)
          .getProfileData(state.context);
      Provider.of<GetMyProfileProvider>(state.context, listen: false)
          .getMyStyleupList(state.context);
      Provider.of<GetMyProfileProvider>(state.context, listen: false)
          .getMyBookmarkList(state.context);

      Navigator.of(state.context).pop();
      Navigator.of(state.context).pop();
    }, (error) {
      debugPrint(error);
      const dialog = ShownyDialog(
        message: "업로드에 실패하였습니다.",
        primaryLabel: "확인",
      );
      showDialog(
        context: state.context,
        builder: (context) => dialog,
      );
    });
  }

  void uploadVideo(UserModel user) {
    debugPrint("API - 스타일업(비디오) 업로드 시작");
    final colorIds =
        selectedColors.map((color) => color.apiId.toString()).toList();
    final seasonID = ((selectedSeason?.index ?? 0) + 1).toString();

    ApiHelper.shared.insertStyleupVideo(
        state.widget.fileList.first.path,
        state.widget.thumb?.path,
        user.memNo,
        description,
        user.memNo,
        colorIds,
        seasonID,
        goodsDataList, (success) {
      debugPrint("API - 스타일업 업로드 성공");

      Provider.of<GetMyProfileProvider>(state.context, listen: false)
          .removeMyStyleupList();
      Provider.of<GetMyProfileProvider>(state.context, listen: false)
          .getProfileData(state.context);
      Provider.of<GetMyProfileProvider>(state.context, listen: false)
          .getMyStyleupList(state.context);
      Provider.of<GetMyProfileProvider>(state.context, listen: false)
          .getMyBookmarkList(state.context);

      Navigator.of(state.context).pop();
      Navigator.of(state.context).pop();
    }, (error) {
      debugPrint(error);
      const dialog = ShownyDialog(
        message: "업로드에 실패하였습니다.2",
        primaryLabel: "확인",
      );
      showDialog(
        context: state.context,
        builder: (context) => dialog,
      );
    });
  }

  List<List<StoreGoodModel?>?> deepCopyGoodsDataList(
      List<List<StoreGoodModel?>?> original) {
    return original
        .map((list) => list
            ?.map((item) => item != null ? StoreGoodModel.clone(item) : null)
            .toList())
        .toList();
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
        goodsDataList[i] = goodsDataListTemp;
      }
    } else {
      goodsDataList = List.filled(1, List<StoreGoodModel?>.filled(6, null));
    }
  }
}
