

import 'package:flutter/material.dart';

class EmptyStateScreen extends StatelessWidget {
  final String title;
  final String imageAssetPath;
  final String buttonText;
  final double? width;
  final double? height;
  final VoidCallback onClick;

  const EmptyStateScreen({
    super.key, 
    required this.title,
    required this.imageAssetPath,
    required this.buttonText,
    this.width,
    this.height,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                imageAssetPath,
                width: width ?? 50,
                height: height ?? 50,
              ),
              const SizedBox(height: 20.0),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: onClick,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40.0,
                    vertical: 12.0,
                  ),
                ),
                child: Text(buttonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}