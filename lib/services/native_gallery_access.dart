import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeGalleryAccess {
  static const platform = MethodChannel('showny_channel/gallery');

  static Future<String?> openGallery() async {
    try {
      final String? result = await platform.invokeMethod('openGallery');
      return result;
    } on PlatformException catch (e) {
      debugPrint('Failed to open gallery : ${e.message}');
      return null;
    }
  }
}
