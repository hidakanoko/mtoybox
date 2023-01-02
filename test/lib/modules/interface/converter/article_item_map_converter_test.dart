import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/interface/converter/article_item_map_converter.dart';

void main() {
  var converter = ArticleItemMapConverter();
  test('ArticleItemMapConverter toMap()', (() {
    // given
    var item = Item(Photo('path/to/photo', isBuiltin: true), 'りんご',
        Category('くだもの', Colors.blue));

    // when
    var map = converter.toMap(item);

    // then
    expect(
        map,
        equals({
          'name': 'りんご',
          'photo': {'path': 'path/to/photo', 'isBuiltin': true},
          'categoryName': 'くだもの'
        }));
  }));
}
