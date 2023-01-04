import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';

class CategoryMapConverter {
  Category fromMap(Map<String, dynamic> map) {
    return Category(map['name'], Color(int.parse(map['color'])));
  }
}
