import 'package:flutter/material.dart';
import 'package:showny/utils/colors.dart';
import 'package:showny/utils/theme.dart';

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({
    Key? key,
    required this.title,
    this.description,
    this.button1Text,
    this.button2Text,
    this.button1OnTap,
  }) : super(key: key);

  final String title;
  final String? description;
  final String? button1Text;
  final Function()? button1OnTap;
  final String? button2Text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Dialog(
      backgroundColor: Colors.transparent,
      //this right here
      child: Container(
        height: size.height * 0.18,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(title,
                style: themeData()
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: black, fontSize: 14)),
            SizedBox(
              height: size.height * 0.01,
            ),
            const Divider(
              thickness: 1,
              height: 1,
              color: borderColor,
            ),
            GestureDetector(
                onTap: button1OnTap ??
                    () {
                      Navigator.pop(context);
                    },
                child: Text(description ?? "",
                    style: themeData()
                        .textTheme
                        .headlineSmall!
                        .copyWith(color: black, fontSize: 14))),
            SizedBox(
              height: size.height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}

class InQueryDialog extends StatelessWidget {
  const InQueryDialog({
    Key? key,
    required this.title,
    this.description,
    required this.description1,
    this.button1Text,
    this.button2Text,
    this.button1OnTap,
  }) : super(key: key);

  final String title;
  final String? description;
  final String description1;
  final String? button1Text;
  final Function()? button1OnTap;
  final String? button2Text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Dialog(
      backgroundColor: Colors.transparent,
      //this right here
      child: Container(
        height: size.height * 0.25,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Text(title, style: themeData().textTheme.headlineSmall),
            SizedBox(
              height: size.height * 0.01,
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(description1,
                  style: themeData().textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.w400, fontSize: 12, color: grey),
                  textAlign: TextAlign.center),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            const Divider(
              thickness: 1,
              height: 1,
              color: borderColor,
            ),
            GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Text(description ?? "",
                    style: themeData().textTheme.headlineSmall)),
            SizedBox(
              height: size.height * 0.01,
            ),
          ],
        ),
      ),
    );
  }
}

class OptionDialog extends StatelessWidget {
  const OptionDialog({
    Key? key,
    required this.title,
    this.description,
    this.button1Text,
    this.button2Text,
    this.button1OnTap,
  }) : super(key: key);

  final String title;
  final String? description;
  final String? button1Text;
  final Function()? button1OnTap;
  final String? button2Text;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Dialog(
      backgroundColor: Colors.transparent,
      //this right here
      child: Container(
        height: size.height * 0.19,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: size.height * 0.03,
            ),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                textAlign: TextAlign.center,
                title,
                style: themeData()
                    .textTheme
                    .headlineSmall!
                    .copyWith(color: black, fontSize: 14),
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            const Divider(
              thickness: 1,
              height: 1,
              color: borderColor,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: SizedBox(
                    width: size.width * 0.22,
                    child: Center(
                      child: Text(button1Text ?? "",
                          style: themeData()
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: black, fontSize: 14)),
                    ),
                  ),
                ),
                SizedBox(
                  height: size.height * 0.05,
                  child: const VerticalDivider(
                    color: borderColor,
                    thickness: 2,
                  ),
                ),
                GestureDetector(
                  onTap: button1OnTap,
                  child: SizedBox(
                    width: size.width * 0.22,
                    child: Center(
                      child: Text(button2Text ?? "",
                          style: themeData()
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: black, fontSize: 14)),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: size.width * 0.02,
            ),
          ],
        ),
      ),
    );
  }
}

showLoaderDialogue(BuildContext context) {
  showDialog<void>(
    context: context,
    useSafeArea: false,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    },
  );
}

