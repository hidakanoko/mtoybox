import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/model/category/category_id.dart';

class Category {
  final CategoryId id;
  final String name;
  final Color color;

  Category(this.id, this.name, this.color);

  @override
  int get hashCode => id.toString().hashCode;

  @override
  bool operator ==(Object other) {
    return other is Category &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }
}
