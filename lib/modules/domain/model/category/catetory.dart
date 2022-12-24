import 'package:flutter/material.dart';

class Category {
  final String name;
  final Color color;

  Category(this.name, this.color);

  @override
  int get hashCode => Object.hash(name, color);

  @override
  bool operator ==(Object other) {
    return other is Category &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }
}
