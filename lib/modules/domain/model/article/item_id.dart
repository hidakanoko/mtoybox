import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/model/Identity.dart';
import 'package:mtoybox/modules/domain/model/uuid.dart';

@immutable
class ItemId extends Identity<UuidValue> {
  const ItemId(super.id);
  factory ItemId.generate() {
    return ItemId(UuidValue.generate());
  }
}
