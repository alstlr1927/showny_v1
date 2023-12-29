import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:showny/utils/colors.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 15),
      child: SizedBox(
        height: 200, // adjust as needed
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    height: 120,
                    decoration: BoxDecoration(
                        color: white, borderRadius: BorderRadius.circular(12)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(tr("common_chatting.image")),
                        const Divider(
                          thickness: 1,
                          color: Colors.grey,
                        ),
                        Text(tr("common_chatting.video")),
                      ],
                    ),
                  )
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 48,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(12)),
                child: Center(
                  child: Text(
                    tr("common_chatting.cancellation"),
                    style: const TextStyle(
                      color: black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
