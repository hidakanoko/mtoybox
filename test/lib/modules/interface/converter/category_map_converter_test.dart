import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mtoybox/modules/domain/model/category/category_id.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/domain/model/identity_uuid.dart';
import 'package:mtoybox/modules/interface/converter/category_map_converter.dart';

void main() {
  var converter = CategoryMapConverter();
  test('CategoryMapConverter toMap()', (() {
    // given
    var category = const Category(
        CategoryId(IdentityUuid('testcategoryid')), 'どうぶつ', Colors.red);

    // when
    var map = converter.toMap(category);

    // then
    expect(
        map,
        equals({
          'id': 'testcategoryid',
          'name': 'どうぶつ',
          'color': Colors.red.value
        }));
  }));
}
