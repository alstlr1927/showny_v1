import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

enum FileType { image, video }

class StyleupPickProvider with ChangeNotifier {
  State state;

  List<AssetEntity> imageList = [];
  List<AssetEntity> videoList = [];

  File? selectedFile;

  FileType fileType = FileType.image;

  // image / video
  bool get multiMode => _multiMode;
  bool _multiMode = false;

  Future<void> _getGalleryImages() async {
    imageList.clear();
    imageList = await PhotoManager.getAssetListRange(
      start: 0,
      end: 50,
      type: RequestType.image,
    );

    notifyListeners();
  }

  Future<void> _getGalleryVideo() async {
    // imageList.clear();
    // imageList = await PhotoManager.getAssetListRange(
    //   start: 0,
    //   end: 50,
    //   type: RequestType.video,
    // );

    // notifyListeners();
  }

  void setFileType(String? type) async {
    // if (type == null) return;

    // fileType = parseToFileType(type);
    // if (fileType == FileType.image) {
    //   _multiMode = true;
    //   await _getGalleryImages();
    // } else {
    //   _multiMode = false;
    //   await _getGalleryVideo();
    // }

    notifyListeners();
  }

  void setMultiMode({required bool value}) {
    _multiMode = value;
    notifyListeners();
  }

  FileType parseToFileType(String value) {
    if (value == "image") {
      return FileType.image;
    } else {
      return FileType.video;
    }
  }

  String getCurFileTypKr() {
    return fileType == FileType.image ? '이미지' : '비디오';
  }

  @override
  void notifyListeners() {
    if (state.mounted) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  StyleupPickProvider(this.state) {
    _getGalleryImages();
    // _getGalleryVideo();
  }
}
