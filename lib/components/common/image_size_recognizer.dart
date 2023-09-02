import 'dart:io';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:image_size_getter/file_input.dart'; // For compatibility with flutter web.
import 'package:mtoybox/modules/domain/model/article/photo.dart';

class ImageSizeRecognizer {
  static isVertical(Photo photo) {
    if (photo.isBuiltin) {
      // assetの画像はFileを生成できないので縦固定にする
      return true;
    }
    final size = ImageSizeGetter.getSize(FileInput(File(photo.path)));
    return size.height > size.width;
  }
}
