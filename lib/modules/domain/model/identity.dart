import 'package:flutter/material.dart';

@immutable
class Identity<T> {
  final T _id;
  const Identity(this._id);

  @override
  String toString() {
    return _id.toString();
  }

  @override
  int get hashCode => _id.toString().hashCode;

  @override
  bool operator ==(Object other) {
    return other is Identity &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }
}
