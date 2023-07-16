import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/model/Identity.dart';
import 'package:mtoybox/modules/domain/model/identity_uuid.dart';

@immutable
class CategoryId extends Identity<IdentityUuid> {
  const CategoryId(super.id);
  factory CategoryId.generate() {
    return CategoryId(IdentityUuid.generate());
  }
}
