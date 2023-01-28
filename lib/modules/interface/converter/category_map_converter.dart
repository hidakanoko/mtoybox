import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/model/category/category_id.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/infrastructure/uuid.dart';

class CategoryMapConverter {
  Map<String, dynamic> toMap(Category category) {
    return {
      'id': category.id.toString(),
      'name': category.name,
      'color': category.color.value
    };
  }

  Category fromMap(Map<String, dynamic> map) {
    return Category(
        CategoryId(UuidValue(map['id'])), map['name'], Color(map['color']));
  }
}
