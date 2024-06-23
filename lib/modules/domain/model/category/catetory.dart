import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/model/category/category_id.dart';

@immutable
class Category {
  final CategoryId id;
  final String name;
  final Color color;

  const Category(this.id, this.name, this.color);

  @override
  int get hashCode => id.toString().hashCode;

  @override
  bool operator ==(Object other) {
    return other is Category &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }

  Category clone() {
    return Category(id, name, color);
  }
}
