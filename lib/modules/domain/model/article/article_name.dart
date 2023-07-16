import 'package:flutter/material.dart';

@immutable
class ArticleName {
  final String value;
  ArticleName(this.value) {
    if (value.length > 100) throw ArgumentError.value(value);
  }
}
