import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NativeGalleryAccess {
  static const platform = MethodChannel('showny_channel/gallery');

  Future<List<String>> getGalleryImages() async {
    try {
      final List<String> images =
          await platform.invokeListMethod('getGalleryImages') as List<String>;
      return images;
    } on PlatformException catch (e) {
      debugPrint('get Gallery error : $e');
      return [];
    }
  }
}
