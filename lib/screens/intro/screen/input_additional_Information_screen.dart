import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:showny/api/new_api/api_helper.dart';
import 'package:showny/models/body.dart';
import 'package:showny/models/style.dart';
import 'package:showny/screens/common/components/body_type_button.dart';
import 'package:showny/screens/common/components/style_button.dart';
import 'package:showny/screens/common/components/sv_button.dart';
import 'package:showny/screens/intro/components/preset_color_button.dart';
import 'package:showny/screens/intro/components/showny_dialog.dart';
import 'package:provider/provider.dart';
import 'package:showny/providers/user_model_provider.dart';
import 'package:showny/screens/main/root_screen.dart';
import 'package:showny/utils/showny_style.dart';
import 'package:showny/utils/showny_util.dart';

class InputAdditionalInfoScreen extends StatefulWidget {
  const InputAdditionalInfoScreen({super.key});

  static String routeName = 'input_additional_info_screen';

  @override
  State<InputAdditionalInfoScreen> createState() =>
      _InputAdditionalInfoScreenState();
}

class _InputAdditionalInfoScreenState extends State<InputAdditionalInfoScreen> {
  BodyType? selectedBodyType;
  late List<Style> selectedStyles = [];
  late List<PresetColor> selectedColors = [];
  bool isActiveCompleteButton = false;

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider =
        Provider.of<UserProvider>(context, listen: false);
    final user = userProvider.user;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          tr("input_additional_info_screen.title"),
          style: ShownyStyle.body2(
            color: ShownyStyle.black,
            weight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          // 여기에 텍스트 버튼 추가
          CupertinoButton(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            onPressed: () {
              final dialog = ShownyDialog(
                message: tr("input_additional_info_screen.info_dialog_message"),
                primaryLabel:
                    tr("input_additional_info_screen.info_dialog_skip"),
                primaryRoute: MainLanding.routeName,
                primaryAction: () {},
                secondaryLabel:
                    tr("input_additional_info_screen.info_dialog_input"),
              );
              showDialog(context: context, builder: (context) => dialog);
            },
            child: Text(
              tr("input_additional_info_screen.skip_button_text"),
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 12,
                fontFamily: 'pretendard',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsetsDirectional.all(16.toWidth),
            child: Column(
              children: [
                const SizedBox(
                  height: 4,
                ),
                Text(
                  tr("input_additional_info_screen.info_label_exposure"),
                  textAlign: TextAlign.center,
                  style: ShownyStyle.caption(color: const Color(0xFF555555)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 29),
                    Text(
                      tr("input_additional_info_screen.label_body_type"),
                      style: ShownyStyle.body2(
                          color: ShownyStyle.black, weight: FontWeight.w600),
                    ),
                    const SizedBox(height: 18),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(5, (index) {
                        return BodyTypeButton(
                          enableMultiSelect: false,
                          bodyType: BodyType.values[index],
                          selectedBodyType: selectedBodyType,
                          itemPadding: 12.toWidth,
                          itemWidth: 55.toWidth,
                          isSelected: selectedBodyType?.index == index,
                          onPressed: (bodyType) {
                            setState(() {
                              if (selectedBodyType == bodyType) {
                                selectedBodyType = null;
                              } else {
                                selectedBodyType = bodyType;
                              }
                            });
                            activateCompleteButton();
                          },
                        );
                      }),
                    ),
                    const SizedBox(height: 58),
                    Row(
                      children: [
                        Text(
                          tr("input_additional_info_screen.label_select_styles"),
                          style: ShownyStyle.body2(
                              color: ShownyStyle.black,
                              weight: FontWeight.w600),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text(
                          tr("input_additional_info_screen.label_max_selection_body_type"),
                          style: const TextStyle(
                            color: Color(0xFF777777),
                            fontSize: 12,
                            fontFamily: 'pretendard',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(height: 18),
                    styleButtons(
                        (MediaQuery.of(context).size.width - 56.0) / 4),
                    const SizedBox(height: 58),
                    Row(
                      children: [
                        Text(
                          tr("input_additional_info_screen.label_select_colors"),
                          style: ShownyStyle.body2(
                              color: ShownyStyle.black,
                              weight: FontWeight.w600),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          tr("input_additional_info_screen.label_max_selection_styles"),
                          style: const TextStyle(
                            color: Color(0xFF777777),
                            fontSize: 12,
                            fontFamily: 'pretendard',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 36,
                    ),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              // childAspectRatio: 0.89,
                              crossAxisSpacing: 0,
                              mainAxisSpacing: 0),
                      itemCount: PresetColor.values.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return PresetColorButton(
                          selectedColors: selectedColors,
                          presetColor: PresetColor.values[index],
                          onPressed: (newColor) {
                            setState(
                              () {
                                if (selectedColors.contains(newColor)) {
                                  selectedColors.remove(newColor);
                                } else {
                                  if (selectedColors.length <= 2) {
                                    selectedColors.add(newColor);
                                  }
                                }
                              },
                            );
                            activateCompleteButton();
                          },
                        );
                      },
                    )
                  ],
                ),
                const SizedBox(
                  height: 42,
                ),
                SVButton(
                    title: tr("common.complete"),
                    titleColor: isActiveCompleteButton
                        ? Colors.white
                        : const Color(0xFF555555),
                    backgroundColor: isActiveCompleteButton
                        ? ShownyStyle.mainPurple
                        : const Color(0xFFEEEEEE),
                    onPressed: isActiveCompleteButton
                        ? () {
                            ApiHelper.shared.profileEdit(user.memNo, {
                              "memNo": user.memNo,
                              "bodyShapeId":
                                  (selectedBodyType!.index + 1).toString(),
                              "styleIdList":
                                  "[${selectedStyles.map((e) => (e.index + 1)).toList().join(",")}]",
                              "colorIdList":
                                  "[${selectedColors.map((e) => (e.index + 1)).toList().join(",")}]",
                            }, (success) {
                              setState(() {
                                user.styleIdList = selectedStyles
                                    .map((e) => (e.index + 1))
                                    .toList();
                                user.colorIdList = selectedColors
                                    .map((e) => (e.index + 1))
                                    .toList();
                                user.bodyShapeId =
                                    (selectedBodyType!.index + 1);
                              });
                              Navigator.pushNamedAndRemoveUntil(context,
                                  MainLanding.routeName, (route) => false);
                            }, (error) {
                              debugPrint(error);
                            });
                          }
                        : null),
                SizedBox(height: ShownyStyle.defaultBottomPadding()),
              ],
            ),
          ),
        ),
      ),
    );
  }

//MARK: - 스타일 버튼
  Widget styleButtons(double itemWidth) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: Style.values.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: itemWidth / 40,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          children: [
            StyleButton(
              style: Style.values[index],
              selectedStyles: selectedStyles,
              onPressed: (style) {
                setState(
                  () {
                    if (selectedStyles.contains(style)) {
                      selectedStyles.remove(style);
                    } else {
                      if (selectedStyles.length <= 4) {
                        selectedStyles.add(style);
                      }
                    }
                  },
                );
                activateCompleteButton();
              },
            ),
          ],
        );
      },
    );
  }

  void activateCompleteButton() {
    if (selectedBodyType != null ||
        selectedStyles.isNotEmpty ||
        selectedColors.isNotEmpty) {
      setState(() {
        isActiveCompleteButton = true;
      });
    } else {
      setState(() {
        isActiveCompleteButton = false;
      });
    }
  }
}
