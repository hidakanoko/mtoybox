import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/model/identity.dart';
import 'package:mtoybox/modules/domain/model/identity_uuid.dart';

@immutable
class ArticleId extends Identity<IdentityUuid> {
  const ArticleId(super.id);
  factory ArticleId.generate() {
    return ArticleId(IdentityUuid.generate());
  }
}
