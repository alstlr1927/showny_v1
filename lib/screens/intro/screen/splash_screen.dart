import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64.0),
          child: Image.asset(
            'assets/logos/showny.png',
            width: double.infinity,
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
