import 'package:flutter/material.dart';

class Category {
  final String name;
  final Color color;

  Category(this.name, this.color);

  /// カテゴリーは名前で一意とする
  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) {
    return other is Category &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }
}
