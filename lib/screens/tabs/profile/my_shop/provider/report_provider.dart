import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_service.dart';
import 'package:showny/models/GetMemberMinishopProductReviewModel.dart';
import 'package:showny/models/GetMemberMinishopProductSheetModel.dart';
import 'package:showny/providers/user_model_provider.dart';

class ReportProvider with ChangeNotifier {
  bool _isStoreCartLoading = true;
  bool _isReviewUpdating = false;

  bool getIsStoreCartLoading() => _isStoreCartLoading;

  GetMemberMinishopProductReviewModel? _memberMinishopProductReviewModel;

  GetMemberMinishopProductReviewModel? get memberMinishopProductReviewModel =>
      _memberMinishopProductReviewModel;

  GetMemberMinishopProductSheetModel? _memberMinishopProductSheetModel;

  GetMemberMinishopProductSheetModel? get memberMinishopProductSheetModel =>
      _memberMinishopProductSheetModel;

  String? _selectedValue;

  String? get selectedValue => _selectedValue;

  void setSelectedValue(String? value) {
    _selectedValue = value;
    notifyListeners();
  }

  setIsStoreCartLoading(bool value) {
    _isStoreCartLoading = value;
    notifyListeners();
  }

  bool getIsReviewUpdating() => _isReviewUpdating;

  setIsReviewUpdating(bool value) {
    _isReviewUpdating = value;
    notifyListeners();
  }

  getStoreCartListData(BuildContext context) {
    UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);
    if (!_isStoreCartLoading) {
      setIsStoreCartLoading(true);
    }
    ApiService()
        .fetchMemberMinishopProductReview(userProvider.user.memNo, "0")
        .then((getStoreCartListSuccess) {
      if (getStoreCartListSuccess.success!) {
        _memberMinishopProductReviewModel = getStoreCartListSuccess;
        setIsStoreCartLoading(false);
        notifyListeners();
      }
    });
    ApiService()
        .fetchMemberMinishopProductSheet()
        .then((getStoreCartListSuccess) {
      if (getStoreCartListSuccess.success!) {
        _memberMinishopProductSheetModel = getStoreCartListSuccess;
        setIsStoreCartLoading(false);
        notifyListeners();
      }
    });
  }

  updateReview(
      {required BuildContext context,
        required String productReviewId,
        required String reportTypeNo}) {
    UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);
    if (!_isReviewUpdating) {
      setIsReviewUpdating(true);
    }
    ApiService()
        .updateMiniShopProductReview(
        memNo: userProvider.user.memNo,
        productReviewId: productReviewId,
        reportTypeNo: reportTypeNo)
        .then((success) {
      if (success) {
        setIsReviewUpdating(false);
      }
    });
  }
}