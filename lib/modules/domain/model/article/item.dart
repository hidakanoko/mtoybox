import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';

class Item {
  final Photo photo;
  final String name;
  final Category category;

  Item(this.photo, this.name, this.category);
}
