import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:showny/api/new_api/api_service.dart';
import 'package:showny/models/StoreOrderListModel.dart';
import 'package:showny/models/brandDearchModel.dart';
import 'package:showny/providers/user_model_provider.dart';

class StoreListProvider extends ChangeNotifier {
  StoreOrderListResponse? _brandResponse;

  StoreOrderListResponse? get brandResponse => _brandResponse;


  bool _isBrandSearchLoading = true;


  bool getIsBrandSearchLoading() => _isBrandSearchLoading;


  setIsBrandSearchLoading(bool value) {
    _isBrandSearchLoading = value;
    notifyListeners();
  }

  getBrandSearch(String memNo, BuildContext context) {
    UserProvider userProvider =
    Provider.of<UserProvider>(context, listen: false);
    if (!_isBrandSearchLoading) {
      setIsBrandSearchLoading(true);
    }
    ApiService().fetchStoreOrderList(memNo: userProvider.user.memNo).then((getBrandSearchSuccess) {
      if (getBrandSearchSuccess!.success!) {
        _brandResponse = getBrandSearchSuccess;
        setIsBrandSearchLoading(false);
        notifyListeners();
      }
    });
  }
}
