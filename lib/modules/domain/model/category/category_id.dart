import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/model/Identity.dart';
import 'package:mtoybox/modules/domain/model/uuid.dart';

@immutable
class CategoryId extends Identity<UuidValue> {
  const CategoryId(super.id);
  factory CategoryId.generate() {
    return CategoryId(UuidValue.generate());
  }
}
