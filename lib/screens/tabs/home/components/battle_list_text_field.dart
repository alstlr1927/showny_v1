import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:showny/constants.dart';

class BattleListTextField extends StatelessWidget {
  const BattleListTextField({
    super.key,
    required this.controller,
    required this.onSearched,
  });

  final TextEditingController controller;
  final Function(String query) onSearched;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          enabledBorder: const UnderlineInputBorder(),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          suffixIcon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CupertinoButton(
                minSize: 0.0,
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 10.0,
                  height: 10.0,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: Image.asset(
                    'assets/icons/x_mark.png',
                    color: Colors.white,
                    width: 7.5,
                    height: 7.5,
                  ),
                ),
                onPressed: () {
                  controller.text = "";
                  onSearched(controller.text);
                },
              ),
              CupertinoButton(
                minSize: 0.0,
                padding: EdgeInsets.zero,
                onPressed: () {
                  onSearched(controller.text);
                },
                child: Image.asset(
                  'assets/icons/search.png',
                  width: 24.0,
                  height: 24.0,
                ),
              ),
              const SizedBox(width: 16.0),
            ],
          ),
          hintText: '검색어를 입력해주세요.'),
      cursorColor: Colors.black,
      style: Constants.defaultTextStyle.copyWith(fontSize: 12.0),
    );
  }
}
