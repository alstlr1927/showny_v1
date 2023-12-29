import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:showny/utils/images.dart';
import 'package:showny/widgets/common_dialougue.dart';

shareFile(
    {required String goodsImage,
    required String goodsNm,
    required String goodsPrice,
    required String brandNm,
    required String goodsDescription}) async {
  try {
    var directory = await getApplicationCacheDirectory();
    var fileName = goodsImage.split('/').last;
    var path = '${directory.path}/$fileName';
    await Dio()
        .download(
      goodsImage,
      path,
      onReceiveProgress: (recivedBytes, totalBytes) {},
      deleteOnError: true,
    )
        .then((_) {
      Share.shareXFiles([XFile(path)],
          text: '$goodsNm, $goodsPrice, $brandNm, $goodsDescription');
    });
  } catch (e) {
    print("Exception$e");
  }
}

shareChatImage({
  required String chatImage,
  required BuildContext context,
}) async {
  try {
    showLoaderDialogue(context);
    var directory = await getApplicationCacheDirectory();
    var fileName = chatImage.split('?').first.split('/').last;
    var path = '${directory.path}/$fileName';
    await Dio().download(
      chatImage,
      path,
      onReceiveProgress: (recivedBytes, totalBytes) {
        print('recivedBytes :: $recivedBytes ,, totalBytes :: $totalBytes');
      },
      deleteOnError: true,
    ).then((_) {
      Navigator.pop(context);
      Share.shareXFiles([XFile(path)]);
    });
  } catch (e) {
    log("Exception$e");
  }
}
