import 'dart:io';
import 'package:flutter/material.dart';
// For compatibility with flutter web.
import 'package:mtoybox/modules/domain/model/article/photo.dart';

class ImageSizeRecognizer {
  static Future<bool> isVertical(Photo photo) async {
    if (photo.isBuiltin) {
      // assetの画像はFileを生成できないので縦固定にする
      return true;
    }
    var f = File(photo.path);
    var img = await decodeImageFromList(f.readAsBytesSync());
    return img.height > img.width;
  }
}
