import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';

class Item {
  final Photo photo;
  final String name;
  final Color themeColor;

  Item(this.photo, this.name, this.themeColor);
}
