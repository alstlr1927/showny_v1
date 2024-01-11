import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:showny/components/bottom_sheet/bottom_sheet_picker.dart';
import 'package:showny/components/bottom_sheet/show_modal_sheet.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

enum FileType { image, video }

class StyleupPickProvider with ChangeNotifier {
  State state;

  List<AssetEntity> imageList = [];
  List<AssetEntity> videoList = [];

  List<XFile> selectedFiles = [];
  // File? selectedFile;

  // FileType fileType = FileType.image;

  String fileType = '';

  // image / video
  bool get multiMode => _multiMode;
  bool _multiMode = false;

  // thumbnail
  XFile? thumbnail;

  void setSelectFile(List<XFile> files) {
    selectedFiles.clear();
    selectedFiles = [...files];
    notifyListeners();
  }

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

  // String getCurFileTypKr() {
  //   return fileType == FileType.image ? '이미지' : '비디오';
  // }

  Future fileSelectBottomSheet() async {
    ImagePicker picker = ImagePicker();
    List<BottomSheetItem> options = [];
    options = [
      BottomSheetItem(
        title: '이미지',
        onPressed: () async {
          List<XFile> images = await picker.pickMultiImage(
            maxWidth: 1440,
            maxHeight: 1440 * 5 / 4,
            imageQuality: 100,
          );
          if (images.isEmpty) return;
          fileType = 'img';
          thumbnail = null;
          setSelectFile(images);
        },
      ),
      BottomSheetItem(
        title: '비디오',
        onPressed: () async {
          XFile? video = await picker.pickVideo(source: ImageSource.gallery);
          if (video == null) return;

          VideoThumbnail.thumbnailFile(
            video: video.path,
            imageFormat: ImageFormat.JPEG,
            quality: 100,
            thumbnailPath: (await getTemporaryDirectory()).path,
          ).then((thumbPath) {
            if (thumbPath == null) {
              Navigator.pop(state.context);
              return;
            }
            fileType = 'video';
            thumbnail = XFile(thumbPath);
            setSelectFile([video]);
          });
        },
      ),
    ];
    showModalPopUp(
      context: state.context,
      builder: (context) {
        return BottomSheetPicker(
          actions: options,
          cancelItem: BottomSheetItem(title: '취소', onPressed: () {}),
        );
      },
    );
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
