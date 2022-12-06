import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';

class PhotoImageProviderFactory {
  static ImageProvider create(Photo photo) {
    if (photo.isBuiltin) {
      return AssetImage(photo.path);
    } else {
      return FileImage(File(photo.path));
    }
  }
}
