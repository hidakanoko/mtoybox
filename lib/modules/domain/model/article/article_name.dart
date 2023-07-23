import 'package:flutter/material.dart';

@immutable
class ArticleName {
  final String value;
  ArticleName(this.value) {
    if (value.isEmpty || value.length > 100) throw ArgumentError.value(value);
  }
}
