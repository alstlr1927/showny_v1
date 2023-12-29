// import 'dart:developer';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:image_picker/image_picker.dart';

// import '../api/new_api/api_service.dart';

// class UploadCameraProvider extends ChangeNotifier {

//   List<String> _productImage = ["demo"];
//   List<String> get productImage => _productImage;

//   List<String> _wearImage = ["demo"];
//   List<String> get wearImage => _wearImage;

//   TextEditingController nameController = TextEditingController();

//   List<String> categoryItemList = ["아우터", "상의", "하의", "신발", "액세서리"];
//   List<bool> selectedCategoryList = [];
//   bool isNew = true;

//   bool _isBannerLoading = false;
//   bool getIsBannerLoading() => _isBannerLoading;
//   int _selectedItemList = 0;
//   bool isNew = true;

//   int get selectedItemList => _selectedItemList;
//   bool _showAnswers = false;
//   bool get showAnswer => _showAnswers;

//   String get selectedItem => _selectedItem;

//   void selectNewItem() {
//     _selectedItem = "1";
//     notifyListeners();
//   }

//   void selectUsedItem() {
//     _selectedItem = "2";
//     notifyListeners();
//   }

//   void toggleAnswer() {
//     _showAnswers = !_showAnswers;
//     notifyListeners();
//   }

//   setIsBannerLoading(bool value) {
//     _isBannerLoading = value;
//     notifyListeners();
//   }


//   imagePickerCameraProduct(int source) async {
//     XFile? image = await ImagePicker().pickImage(
//         source: source == 0 ? ImageSource.camera : ImageSource.gallery);
//     if (image != null) {
//       _productImage.removeLast();
//       _productImage.add(image.path);
//       _productImage.add("demo");
//       notifyListeners();
//     }
//   }

//   removeProductImage(index) {
//     _productImage.removeAt(index);
//     notifyListeners();
//   }

//   imagePickerCameraWear(int source) async {
//     XFile? image = await ImagePicker().pickImage(
//         source: source == 0 ? ImageSource.camera : ImageSource.gallery);
//     if (image != null) {
//       _wearImage.removeLast();
//       _wearImage.add(image.path);
//       _wearImage.add("demo");
//       notifyListeners();
//     }
//   }

//   removeWearImage(index) {
//     _wearImage.removeAt(index);
//     notifyListeners();
//   }

//   updateListItemSelected(index) {
//     _selectedItemList = index;
//     notifyListeners();
//   }

//   updateCatgegorySelect(index) {
//     catIndex = index;
//     notifyListeners();
//   }

//   uploadDataList( context,
//   nameController,
//   catIdController,
//   priceController,
//   deliveryPriceController,
//   viewSizeController,
//   selectedItem,
//   descriptionController,
//   brandController,
//   actualSizeController) {
//     if (!_isBannerLoading) {
//       setIsBannerLoading(true);
//     }
//     ApiService().uploadProductData(context,
//         nameController,
//         catIdController,
//         priceController,
//         deliveryPriceController,
//         viewSizeController,
//         selectedItem,
//         descriptionController,
//         brandController,
//         actualSizeController).then((getBannerListSuccess) {
//           log("${getBannerListSuccess}",name: "sueecss");
//       if(getBannerListSuccess!){
//         //_getBannerListResponseModel = getBannerListSuccess;
//         setIsBannerLoading(false);
//         notifyListeners();
//       }
//       else{


//         setIsBannerLoading(false);
//       }
//     });
//   }
// }
