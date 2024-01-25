import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/models/store_good_model.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/common/components/app_bar_widget.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/widgets/common_button_widget.dart';

import '../../../api/new_api/api_helper.dart';
import 'widgets/text_field_widget.dart';

class StoreInquiryScreen extends StatefulWidget {
  final StoreGoodModel goodsData;
  final Function() onComplete;

  const StoreInquiryScreen(
      {Key? key, required this.goodsData, required this.onComplete})
      : super(key: key);

  @override
  State<StoreInquiryScreen> createState() => _StoreInquiryScreen();
}

class _StoreInquiryScreen extends State<StoreInquiryScreen> {
  List<String> categoryList = [];
  String? selectedCategory;

  TextEditingController? titleController;
  TextEditingController? contentController;

  var isSecret = false;

  @override
  void initState() {
    super.initState();

    getStoreQaCategory();
    titleController = TextEditingController();
    contentController = TextEditingController();
  }

  void getStoreQaCategory() {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    String memNo = userProvider.user.memNo;
    ApiHelper.shared.getStoreGoodsQaCategory(memNo, (getCategoryList) {
      setState(() {
        categoryList = getCategoryList;
      });
    }, (error) {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    String memNo = userProvider.user.memNo;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: white,
        appBar: AppBarWidget(title: tr("inquiry_page.write_inquiry")),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(
                children: [
                  Container(
                    height: 56,
                    width: 56,
                    decoration: const BoxDecoration(
                      color: greyExtraLight,
                    ),
                    child: Image.network(widget.goodsData.goodsImageUrlList[0],
                        fit: BoxFit.cover, width: size.width,
                        errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.white,
                      );
                    }),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                      child: SizedBox(
                    height: 56,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Text(
                          widget.goodsData.brandNm,
                          style: ShownyStyle.overline(),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          widget.goodsData.goodsNm,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: ShownyStyle.caption(),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 48,
                child: DropdownButtonFormField<String>(
                  icon: Image.asset(
                    arrowUp,
                    width: 24,
                    height: 24,
                  ),
                  value: selectedCategory,
                  style: FontHelper.regular_14_000000,
                  hint: Text(
                    "문의 유형을 선택해주세요.",
                    style: ShownyStyle.body2(),
                  ),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 16)),
                  items: categoryList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(
                        value,
                        style: FontHelper.regular_14_000000,
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedCategory = newValue;
                    });
                  },
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an option';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                children: [
                  SizedBox(
                    height: 48,
                    child: TextFieldWidget(
                      borderColor: black,
                      borderRadius: 8,
                      hintText: "제목을 15자 이내로 입력해 주세요.",
                      styleFont: FontHelper.regular_14_000000,
                      hintStyle: ShownyStyle.body2(),
                      textEditingController: titleController,
                      onChange: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  SizedBox(
                    height: 240,
                    child: TextFieldWidget(
                      height: 240,
                      borderColor: black,
                      borderRadius: 8,
                      maxWord: 500,
                      isExpanded: true,
                      hintText: "내용을 작성해주세요.",
                      styleFont: FontHelper.regular_14_000000,
                      hintStyle: ShownyStyle.body2(),
                      textEditingController: contentController,
                      onChange: (value) {
                        setState(() {});
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isSecret = !isSecret;
                      });
                    },
                    child: Icon(
                      isSecret == true
                          ? Icons.check_circle
                          : Icons.circle_outlined,
                      color: black,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    tr("inquiry_page.secret_msg"),
                    style: ShownyStyle.caption(),
                  )
                ],
              ),
              const Spacer(),
              CommonButtonWidget(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  if (titleController!.text.isNotEmpty &&
                      contentController!.text.isNotEmpty &&
                      selectedCategory != null) {
                    var isSecretStr = 'n';
                    if (isSecret == true) {
                      isSecretStr = 'y';
                    }

                    ApiHelper.shared.insertStoreQa(
                        memNo,
                        selectedCategory,
                        widget.goodsData.goodsNo,
                        titleController!.text,
                        contentController!.text,
                        isSecretStr,
                        (success) {},
                        (error) {});

                    showDialog(
                      context: context,
                      builder: (c) {
                        return ShownyDialog(
                          message: tr("inquiry_page.inquiry_registration"),
                          primaryLabel: tr("common.confirm"),
                          primaryAction: () {
                            widget.onComplete();
                            Navigator.of(context).pop();
                          },
                        );
                      },
                    );
                  }
                },
                horizontalPadding: 0,
                text: tr("inquiry_page.registration"),
                radius: 12,
                height: 48,
                color: titleController!.text.isEmpty ||
                        contentController!.text.isEmpty ||
                        selectedCategory == null
                    ? greyExtraLight
                    : black,
                textcolor: titleController!.text.isEmpty ||
                        contentController!.text.isEmpty ||
                        selectedCategory == null
                    ? grey
                    : white,
              ),
            ]),
          ),
        ));
  }
}
