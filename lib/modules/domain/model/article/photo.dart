import 'package:flutter/material.dart';

@immutable
class Photo {
  final String path;
  final bool isBuiltin;
  const Photo(this.path, {this.isBuiltin = false});

  Photo clone() {
    return Photo(path, isBuiltin: isBuiltin);
  }
}
