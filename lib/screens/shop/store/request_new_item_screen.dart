import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/models/category_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/common/components/app_bar_widget.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/widgets/common_dialougue.dart';

import '../../../../../widgets/common_button_widget.dart';
import '../../../api/new_api/api_helper.dart';
import 'widgets/text_field_widget.dart';

class RequestNewItemScreen extends StatefulWidget {
  static String routeName = "UploadMinishopScreen";

  const RequestNewItemScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<RequestNewItemScreen> createState() => _RequestNewItemScreen();
}

class _RequestNewItemScreen extends State<RequestNewItemScreen> {
  final _formKey = GlobalKey<FormState>();

  List<XFile> productImageList = [];

  TextEditingController nameController = TextEditingController();
  TextEditingController infoController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController wearSizeController = TextEditingController();
  TextEditingController linkController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  void imagePickerCameraProduct(int source) async {
    XFile? image = await ImagePicker().pickImage(
        source: source == 0 ? ImageSource.camera : ImageSource.gallery);
    if (image != null) {
      setState(() {
        productImageList.add(image);
      });
    }
  }

  void removeProductImage(index) {
    setState(() {
      productImageList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBarWidget(
        title: "아이템 등록 신청",
      ),
      body: SafeArea(
          child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        height: size.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 24,
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 32,
                      child: Text(
                        "브랜드명",
                        style: ShownyStyle.body2(),
                      ),
                    ),
                    TextFieldWidget(
                      textEditingController: nameController,
                      borderRadius: 8,
                      borderColor: black,
                      alignment: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      tr("mini_shop_product.product_image"),
                      style: FontHelper.bold_12_000000,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    SizedBox(
                        width: size.width,
                        height: 120,
                        child: GridView.builder(
                          itemCount: productImageList.length + 1,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return index == productImageList.length
                                ? GestureDetector(
                                    onTap: () {
                                      imagePickerCameraProduct(1);
                                    },
                                    child: Container(
                                        height: 120,
                                        width: 120,
                                        color: const Color(0xffebebeb),
                                        alignment: Alignment.center,
                                        child: Stack(
                                          children: [
                                            const SizedBox(
                                              height: 60,
                                            ),
                                            SizedBox(
                                              width: 48,
                                              height: 48,
                                              child: Image.asset(
                                                  'assets/images/camera.png',
                                                  fit: BoxFit.cover),
                                            ),
                                            Positioned(
                                              bottom: 0,
                                              left: 0,
                                              right: 0,
                                              child: Text(
                                                "${productImageList.length}/3",
                                                textAlign: TextAlign.center,
                                                style: const TextStyle(
                                                    fontSize: 11),
                                              ),
                                            ),
                                          ],
                                        )))
                                : Stack(
                                    children: [
                                      SizedBox(
                                          width: 120,
                                          height: 120,
                                          child: Image.file(
                                            File(productImageList[index].path),
                                            fit: BoxFit.cover,
                                          )),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (c) {
                                                return OptionDialog(
                                                  title: tr(
                                                      "upload_minishop_product.sure_to_delete"),
                                                  button1Text:
                                                      tr("common.cancel"),
                                                  button2Text:
                                                      tr("common.confirm"),
                                                  button1OnTap: () {
                                                    removeProductImage(index);
                                                    Navigator.pop(context);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          child: const Stack(
                                            children: <Widget>[
                                              Positioned(
                                                left: 1.0,
                                                top: 2.0,
                                                child: Icon(Icons.close,
                                                    color: Colors.black54),
                                              ),
                                              Icon(Icons.close,
                                                  color: Colors.white),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                          },
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  mainAxisSpacing: 8.0,
                                  crossAxisSpacing: 8.0,
                                  childAspectRatio: 1.0),
                        )),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "제품명 / 시즌정보",
                      style: ShownyStyle.body2(),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFieldWidget(
                      borderColor: black,
                      borderRadius: 8,
                      textEditingController: infoController,
                      styleFont: FontHelper.regular_14_000000,
                      alignment: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "가격",
                      style: ShownyStyle.body2(),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFieldWidget(
                      borderColor: black,
                      borderRadius: 8,
                      textEditingController: priceController,
                      styleFont: FontHelper.regular_14_000000,
                      alignment: TextAlign.start,
                      textInputType: TextInputType.number,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "착용 사이즈",
                      style: ShownyStyle.body2(),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFieldWidget(
                      borderColor: black,
                      borderRadius: 8,
                      textEditingController: wearSizeController,
                      styleFont: FontHelper.regular_14_000000,
                      alignment: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Text(
                      "구매링크",
                      style: ShownyStyle.body2(),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    TextFieldWidget(
                      borderColor: black,
                      borderRadius: 8,
                      textEditingController: linkController,
                      styleFont: FontHelper.regular_14_000000,
                      alignment: TextAlign.start,
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    CommonButtonWidget(
                      text: "제품 등록 신청",
                      radius: 12,
                      height: 48,
                      color: black,
                      textcolor: white,
                      horizontalPadding: 0,
                      onTap: () {
                        if (productImageList.isEmpty) {
                          const dialog = ShownyDialog(
                            message: "상품이미지를 등록해주세요.",
                            primaryLabel: '확인',
                          );
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return dialog;
                            },
                          );
                          return;
                        }

                        bool isValid = _formKey.currentState!.validate();
                        if (isValid == true) {
                          UserProvider userProvider =
                              Provider.of<UserProvider>(context, listen: false);
                          final user = userProvider.user;

                          ApiHelper.shared.registNewItemRequest(
                              user.memNo,
                              nameController.text,
                              infoController.text,
                              priceController.text,
                              wearSizeController.text,
                              linkController.text,
                              productImageList, () {
                            Navigator.pop(context);

                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return ShownyDialog(
                                  message: "아이템 신청이 완료되었습니다.",
                                  primaryLabel: '확인',
                                  primaryAction: () {
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            );
                          }, (error) {
                            debugPrint(error);
                          });

                          // ApiHelper.shared.insertMinishopProduct(
                          //     user.memNo,
                          //     nameController.text,
                          //     selectedCategoryIndex,
                          //     priceController.text,
                          //     deliveryPriceController.text,
                          //     viewSizeController.text,
                          //     isNew,
                          //     descriptionController.text,
                          //     brandController.text,
                          //     actualSizeController.text,
                          //     colorIdListStr,
                          //     productImageList,
                          //     wearImageList, (sucess) {
                          //   final dialog = ShownyDialog(
                          //     message: "상품이 등록되었습니다.",
                          //     primaryLabel: '확인',
                          //     primaryAction: () {
                          //       Navigator.of(context).pop();
                          //       Navigator.of(context).pop();
                          //     },
                          //   );
                          //   showDialog(
                          //     context: context,
                          //     builder: (BuildContext context) {
                          //       return dialog;
                          //     },
                          //   );
                          // }, (error) {
                          //   debugPrint(error);
                          // });
                        } else {
                          log("message error");

                          // if (nameController.text.isEmpty) {
                          //   Fluttertoast.showToast(
                          //       msg: "Name  Required",
                          //       backgroundColor: Colors.red,
                          //       textColor: Colors.white,
                          //       fontSize: 16.0);
                          // } else if (priceController.text.isEmpty) {
                          //   Fluttertoast.showToast(
                          //       msg: "Price Required",
                          //       backgroundColor: Colors.red,
                          //       textColor: Colors.white,
                          //       fontSize: 16.0);
                          // } else if (infoController.text.isEmpty) {
                          //   Fluttertoast.showToast(
                          //       msg: "info Price Required",
                          //       backgroundColor: Colors.red,
                          //       textColor: Colors.white,
                          //       fontSize: 16.0);
                          // } else if (viewSizeController.text.isEmpty) {
                          //   Fluttertoast.showToast(
                          //       msg: "Size Required",
                          //       backgroundColor: Colors.red,
                          //       textColor: Colors.white,
                          //       fontSize: 16.0);
                          // } else if (descriptionController.text.isEmpty) {
                          //   Fluttertoast.showToast(
                          //       msg: "Description  Required",
                          //       backgroundColor: Colors.red,
                          //       textColor: Colors.white,
                          //       fontSize: 16.0);
                          // } else if (brandController.text.isEmpty) {
                          //   Fluttertoast.showToast(
                          //       msg: "Brand Required",
                          //       backgroundColor: Colors.red,
                          //       textColor: Colors.white,
                          //       fontSize: 16.0);
                          // } else if (actualSizeController.text.isEmpty) {
                          //   Fluttertoast.showToast(
                          //       msg: "Actual Size Required",
                          //       backgroundColor: Colors.red,
                          //       textColor: Colors.white,
                          //       fontSize: 16.0);
                          // }
                        }
                      },
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}

class CategoryWidget extends StatefulWidget {
  final Function(int) onComplete;
  final List<MinishopCategoryModel>? categoryList;

  const CategoryWidget({
    Key? key,
    required this.onComplete,
    required this.categoryList,
  }) : super(key: key);

  @override
  State<CategoryWidget> createState() => _CategoryWidget();
}

class _CategoryWidget extends State<CategoryWidget> {
  var selectedCateogryIndex = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBarWidget(
        title: tr("mini_shop_product.category"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            const SizedBox(height: 16),
            GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 8,
                  childAspectRatio: ((size.width - 32 - 24) / 4) / 40,
                  mainAxisSpacing: 8),
              itemCount: widget.categoryList?.length ?? 0,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCateogryIndex = index;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      border: Border.all(
                          color: selectedCateogryIndex == index
                              ? Colors.black
                              : Colors.grey),
                    ),
                    child: Center(
                      child: Text(
                        widget.categoryList?[index].name ?? "",
                        style: TextStyle(
                            color: selectedCateogryIndex == index
                                ? Colors.black
                                : Colors.grey,
                            fontSize: 12),
                      ),
                    ),
                  ),
                );
              },
            ),
            const Spacer(),
            CommonButtonWidget(
              text: tr("mini_shop_product.change"),
              radius: 12,
              height: 48,
              color: black,
              textcolor: white,
              onTap: () {
                widget.onComplete(selectedCateogryIndex);
                Navigator.of(context).pop();
              },
            ),
            const SizedBox(
              height: 40.0,
            ),
          ],
        ),
      ),
    );
  }
}
