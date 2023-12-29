import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/helper/font_helper.dart';
import 'package:showny/screens/common/components/sv_button.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';
import 'package:showny/screens/intro/components/sv_drop_down_picker.dart';
import 'package:showny/screens/intro/screen/input_additional_information_screen.dart';
import 'package:showny/screens/tabs/profile/my_profile/components/sv_text_field.dart';
import 'package:provider/provider.dart';
import 'package:showny/providers/user_model_provider.dart';

import '../../tabs/profile/my_profile/components/sv_dropdown.dart';

class InputEssentialInfoScreen extends StatefulWidget {
  const InputEssentialInfoScreen({super.key});

  static String routeName = 'input_essential_info_screen';

  @override
  State<InputEssentialInfoScreen> createState() =>
      _InputEssentialInfoScreenState();
}

class _InputEssentialInfoScreenState extends State<InputEssentialInfoScreen> {
  bool? isMale = true;

  final idController = TextEditingController();
  final birthDateController = TextEditingController();
  // 영문, 숫자, 밑줄, 마침표만 허용하는 정규표현식
  final RegExp _validCharacters = RegExp(r'^[a-zA-Z0-9_.]*$');
  String birthDay = '';

  List<String> heightList = List.generate(201 - 100, (index) => "${index + 100}cm");
  List<String> weightList = List.generate(121 - 40, (index) => "${index + 40}kg");

  int? selectedHeightIndex;
  int? selectedWeightIndex;

  bool isIDVerified = true;
  bool isBirthDateError = false;
  bool isActivated = false; // CTA 버튼 활성화

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
              tr("input_essential_information_screen.required_information"),
              style: FontHelper.bold_16_000000),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 42),
              Text(tr("input_essential_information_screen.gender_selection"),
                  style: FontHelper.regular_16_000000),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: SVButton(
                      title: tr("input_essential_information_screen.male"),
                      backgroundColor: (isMale == null)
                          ? const Color(0xFFEEEEEE)
                          : isMale!
                              ? Colors.black
                              : const Color(0xFFEEEEEE),
                      titleColor: (isMale == null)
                          ? const Color(0xFF555555)
                          : isMale!
                              ? Colors.white
                              : const Color(0xFF555555),
                      onPressed: () {
                        setState(() {
                          isMale = true;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: SVButton(
                      title: tr("input_essential_information_screen.female"),
                      backgroundColor: (isMale == null)
                          ? const Color(0xFFEEEEEE)
                          : !isMale!
                              ? Colors.black
                              : const Color(0xFFEEEEEE),
                      titleColor: (isMale == null)
                          ? const Color(0xFF555555)
                          : !isMale!
                              ? Colors.white
                              : const Color(0xFF555555),
                      onPressed: () {
                        setState(() {
                          isMale = false;
                        });
                      },
                    ),
                  ),
                ],
              ),
              CupertinoButton(
                onPressed: () {
                  setState(() {
                    isMale = null;
                  });
                },
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    if (isMale == null)
                      Image.asset(
                        'assets/icons/check_circle.png',
                        width: 24.0,
                        height: 24.0,
                      )
                    else
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Container(
                          width: 20.0,
                          height: 20.0,
                          decoration: const ShapeDecoration(
                            shape: CircleBorder(
                              side: BorderSide(color: Color(0xFFCCCCCC), width: 1.0),
                            ),
                          ),
                        ),
                      ),
                    const SizedBox(width: 8),
                    Text(
                      tr("input_essential_information_screen.unspecified"),
                      style: const TextStyle(
                        color: Color(0xFF555555),
                        fontSize: 14,
                        fontFamily: 'Spoqa Han Sans Neo',
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 26),
              //MARK: - ID
              Text(tr("input_essential_information_screen.please_enter_id"),
                  style: FontHelper.regular_16_000000),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    flex: 240,
                    child: SVTextField(
                      controller: idController,
                      error: isIDVerified,
                      hintText:
                          tr("input_essential_information_screen.enter_id"),
                      inputFormatters: [
                        LengthLimitingTextInputFormatter(20),
                        FilteringTextInputFormatter.allow(_validCharacters),
                      ],
                      onChanged: (p0) {
                        setState(() {
                          isIDVerified = true;
                          isIDVerified = !isIdLongerThanFour(p0);
                          checkReadyToConfirm();
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    flex: 100,
                    child: SizedBox(
                      height: 48,
                      child: SVButton(
                        title: tr(
                            "input_essential_information_screen.check_duplicate"),
                        titleColor: isIDVerified
                            ? const Color(0xFF666666)
                            : Colors.white,
                        backgroundColor: isIDVerified
                            ? const Color(0xFFEEEEEE)
                            : Colors.black,
                        onPressed: () {
                          if (idController.text.trim().isEmpty) {
                            return;
                          }
                          if (isIdLongerThanFour(idController.text) == false) {
                            var dialog = ShownyDialog(
                                message: tr("input_essential_information_screen.validation_id_length_fail"),
                                primaryLabel: tr("common.confirm"));
                            showDialog(
                              context: context,
                              builder: (context) => dialog,
                            );
                            return;
                          }
                          setState(() {
                            isIDVerified = false;
                          });
                          if (idController.text.endsWith(".")) {
                            var dialog = ShownyDialog(
                                message: tr(
                                    "input_essential_information_screen.validation_id_fail"),
                                primaryLabel: tr("common.confirm"));
                            showDialog(
                              context: context,
                              builder: (context) => dialog,
                            );
                            return;
                          }

                          ApiHelper.shared.checkDuplicatedId(
                              idController.text.trim(), (success) {
                            // 중복확인 성공
                            setState(() {
                              isIDVerified = true;
                              var dialog = ShownyDialog(
                                  message: tr(
                                      "input_essential_information_screen.vaildation_id_ok"),
                                  primaryLabel: tr("common.confirm"));
                              showDialog(
                                context: context,
                                builder: (context) => dialog,
                              );
                              checkReadyToConfirm();
                            });
                          }, (error) {
                            // 중복확인 실패
                            setState(() {
                              isIDVerified = false;
                              var dialog = ShownyDialog(
                                  message: tr(
                                      "input_essential_information_screen.vaildation_id_duplicate"),
                                  primaryLabel: tr("common.confirm"));
                              showDialog(
                                context: context,
                                builder: (context) => dialog,
                              );
                            });
                          });
                          checkReadyToConfirm();
                          debugPrint("$isIDVerified)");
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 42),
              //MARK: - 생년월일
              Text(tr("input_essential_information_screen.enter_birthdate"),
                  style: FontHelper.regular_16_000000),
              const SizedBox(height: 18),
              SVTextField(
                hintText: 'ex) 960214',
                controller: birthDateController,
                keyboardType: TextInputType.number,
                error: isBirthDateError,
                errorText: tr(
                    "input_essential_information_screen.validation_birthday_fail"),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(6),
                  FilteringTextInputFormatter.digitsOnly,
                ],
                onChanged: (p0) {
                  if (p0.length >= 6) {
                    //TODO - 에러 핸들링 isBirthDateError
                    isBirthDateError = false;
                  } else {
                    isBirthDateError = true;
                  }

                  checkReadyToConfirm();
                },
              ),
              const SizedBox(height: 42),
              Text(tr("input_essential_information_screen.height_weight"),
                  style: FontHelper.regular_16_000000),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                      child: SVDropdownPicker(
                      hintText: "180cm",
                      items: heightList,
                      selectedValue: selectedHeightIndex,
                      onChanged: (p0) {
                        setState(() {
                          selectedHeightIndex = p0;
                        });
                        checkReadyToConfirm();
                      },
                    )),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: SVDropdownPicker(
                      hintText: "40kg",
                      items: weightList,
                      selectedValue: selectedWeightIndex,
                      onChanged: (p0) {
                        setState(() {
                          selectedWeightIndex = p0;
                        });
                        checkReadyToConfirm();
                      },
                    ),
                  ),
                ],
              ),
              const Spacer(),
              SVButton(
                title: tr("common.complete"),
                backgroundColor: Colors.black,
                titleColor:
                    isActivated ? Colors.white : const Color(0xFF555555),
                onPressed: isActivated
                    ? () {
                        if (isValidDate(birthDateController.text)) {
                          var gender = 1;
                          if (isMale == null) {
                            gender = 0;
                          } else {
                            if (!(isMale!)) {
                              gender = 2;
                            }
                          }

                          ApiHelper.shared.profileEdit(user.memNo, {
                            "memNo": user.memNo,
                            "gender": gender,
                            "newMemId": idController.text.trim(),
                            "birthday": birthDateController.text.trim(),
                            "heightId":
                                selectedHeightIndex != null ? (selectedHeightIndex!+100) : null,
                            "weightId":
                                selectedWeightIndex != null ? (selectedWeightIndex!+40) : null
                          }, (success) {
                            Navigator.pushNamed(
                                context, InputAdditionalInfoScreen.routeName);
                            user.gender = gender;
                            user.memId = idController.text.trim();
                            user.birthday = birthDateController.text.trim();
                            user.heightId =
                                selectedHeightIndex!+100;
                            user.weightId =
                                selectedWeightIndex!+40;
                          }, (error) {
                            debugPrint(error);
                          });
                        } else {
                          setState(() {
                            isBirthDateError = true;
                          });
                        }
                      }
                    : null,
              ),
              const SizedBox(
                height: 16,
              )
            ],
          ),
        )),
      ),
    );
  }

  bool isIdLongerThanFour(String id) {
    if (id.length >= 4 && id.length <= 20) {
      return true;
    } else {
      return false;
    }
  }

  void checkReadyToConfirm() {
    setState(() {
      isActivated = false;
    });
    if (!isIDVerified) return;
    if (isBirthDateError) return;
    if (selectedHeightIndex == null || selectedWeightIndex == null) return;

    setState(() {
      isActivated = true;
    });
  }

  bool isValidDate(String input) {
    const datePattern = r'^\d{6}$'; // YYMMDD 형식
    if (!RegExp(datePattern).hasMatch(input)) {
      return false;
    }

    final year = int.tryParse(input.substring(0, 2));
    final month = int.tryParse(input.substring(2, 4));
    final day = int.tryParse(input.substring(4, 6));

    if (year == null || month == null || day == null) {
      return false;
    }

    if (year < 0 || year > 99) {
      return false;
    }

    if (month < 1 || month > 12) {
      return false;
    }

    if (day < 1 || day > 31) {
      return false;
    }

    return true;
  }
}
