import 'package:flutter/material.dart';

@immutable
class ArticleDescription {
  final String value;
  ArticleDescription(this.value) {
    if (value.length > 200) throw ArgumentError.value(value);
  }
}
