import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PresetColorButton extends StatelessWidget {
  const PresetColorButton({
    super.key,
    required this.selectedColors,
    required this.presetColor,
    required this.onPressed,
  });

  final List<PresetColor> selectedColors;
  final PresetColor presetColor;
  final Function(PresetColor) onPressed;

  @override
  Widget build(BuildContext context) {
    bool isSelected = selectedColors.contains(presetColor);

    return CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: () {
        onPressed(presetColor);
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100.0), // Adjust as needed
              border: Border.all(
                color: isSelected ? Colors.black : Colors.transparent,
                width: 1.0, // Border width
              ),
            ),
            child: presetColor.icon,
          ),
          const SizedBox(height: 12),
          Text(
            presetColor.convertToString,
            style: TextStyle(
              color: isSelected ? Colors.black : const Color(0xFFAAAAAA),
              fontSize: 12,
              fontFamily: 'pretendard',
              fontWeight: FontWeight.w400,
            ),
          )
        ],
      ),
    );
  }
}

//MARK: - 컬러버튼
enum PresetColor {
  beige,
  kahki,
  yellow,
  orange,
  red,
  wine,
  brown,
  navy,
  blue,
  green,
  purple,
  gray,
  black,
  silver,
  gold,
  mint,
  ravender,
  white,
  skyBlue,
  pink
}

extension PresetColorExtension on PresetColor {
  int get apiId {
    // 열거형의 값을 1부터 시작하는 정수 ID로 매핑합니다.
    return index + 1;
  }

  static PresetColor fromId(int id) {
    // 정수 ID를 열거형 값으로 변환합니다.
    if (id >= 1 && id <= PresetColor.values.length) {
      return PresetColor.values[id - 1];
    } else {
      throw ArgumentError("Invalid PresetColor ID: $id");
    }
  }

  String get convertToString {
    switch (this) {
      case PresetColor.beige:
        return tr("preset_color_strings.beige");
      case PresetColor.kahki:
        return tr("preset_color_strings.kahki");
      case PresetColor.yellow:
        return tr("preset_color_strings.yellow");
      case PresetColor.orange:
        return tr("preset_color_strings.orange");
      case PresetColor.red:
        return tr("preset_color_strings.red");
      case PresetColor.wine:
        return tr("preset_color_strings.wine");
      case PresetColor.brown:
        return tr("preset_color_strings.brown");
      case PresetColor.navy:
        return tr("preset_color_strings.navy");
      case PresetColor.blue:
        return tr("preset_color_strings.blue");
      case PresetColor.green:
        return tr("preset_color_strings.green");
      case PresetColor.purple:
        return tr("preset_color_strings.purple");
      case PresetColor.gray:
        return tr("preset_color_strings.gray");
      case PresetColor.black:
        return tr("preset_color_strings.black");
      case PresetColor.silver:
        return tr("preset_color_strings.silver");
      case PresetColor.gold:
        return tr("preset_color_strings.gold");
      case PresetColor.mint:
        return tr("preset_color_strings.mint");
      case PresetColor.ravender:
        return tr("preset_color_strings.ravender");
      case PresetColor.white:
        return tr("preset_color_strings.white");
      case PresetColor.skyBlue:
        return tr("preset_color_strings.skyBlue");
      case PresetColor.pink:
        return tr("preset_color_strings.pink");
      default:
        return "";
    }
  }

  Widget get icon {
    switch (this) {
      case PresetColor.beige:
        return const ColorOval(color: Color(0xFFEFDBBA));
      case PresetColor.kahki:
        return const ColorOval(color: Color(0xFF5A6C2E));
      case PresetColor.yellow:
        return const ColorOval(color: Color(0xFFECCC1F));
      case PresetColor.orange:
        return const ColorOval(color: Color(0xFFE48727));
      case PresetColor.red:
        return const ColorOval(color: Color(0xFFDE2121));
      case PresetColor.wine:
        return const ColorOval(color: Color(0xFF852032));
      case PresetColor.brown:
        return const ColorOval(color: Color(0xFF8C5831));
      case PresetColor.navy:
        return const ColorOval(color: Color(0xFF001F71));
      case PresetColor.blue:
        return const ColorOval(color: Color(0xFF2964A8));
      case PresetColor.green:
        return const ColorOval(color: Color(0xFF229762));
      case PresetColor.purple:
        return const ColorOval(color: Color(0xFF64377A));
      case PresetColor.gray:
        return const ColorOval(color: Color(0xFF646464));
      case PresetColor.black:
        return const ColorOval(color: Color(0xFF000000));
      case PresetColor.silver:
        return Container(
          width: 24,
          height: 24,
          decoration: const ShapeDecoration(
            image: DecorationImage(
              image: AssetImage("assets/icons/silver.png"),
              fit: BoxFit.fill,
            ),
            shape: OvalBorder(),
          ),
        );
      case PresetColor.gold:
        return Transform.rotate(
          angle: 270 * (3.1415926535897932 / 180),
          child: Container(
            width: 24,
            height: 24,
            decoration: const ShapeDecoration(
              image: DecorationImage(
                image: AssetImage("assets/icons/gold.png"),
                fit: BoxFit.fill,
              ),
              shape: OvalBorder(),
            ),
          ),
        );
      case PresetColor.mint:
        return const ColorOval(color: Color(0xFFA9D4CA));
      case PresetColor.ravender:
        return const ColorOval(color: Color(0xFFCEC7D7));
      case PresetColor.white:
        return const ColorOval(color: Color(0xFFF2F2F2));
      case PresetColor.skyBlue:
        return const ColorOval(color: Color(0xFFBCCCDB));
      case PresetColor.pink:
        return const ColorOval(color: Color(0xFFEBC1C2));
    }
  }
}

class ColorOval extends StatelessWidget {
  const ColorOval({
    super.key,
    required this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 24,
      height: 24,
      decoration: ShapeDecoration(
        color: color,
        shape: const OvalBorder(),
      ),
    );
  }
}
