import 'package:flutter_test/flutter_test.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/domain/model/article/item_id.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';
import 'package:mtoybox/modules/domain/model/category/category_id.dart';
import 'package:mtoybox/modules/infrastructure/uuid.dart';
import 'package:mtoybox/modules/interface/converter/article_item_map_converter.dart';

void main() {
  var converter = ArticleItemMapConverter();
  test('ArticleItemMapConverter toMap()', (() {
    // given
    var item = Item(
        const ItemId(UuidValue('testitemid')),
        const Photo('path/to/photo', isBuiltin: true),
        'りんご',
        const CategoryId(UuidValue('testcategoryid')));

    // when
    var map = converter.toMap(item);

    // then
    expect(
        map,
        equals({
          'id': 'testitemid',
          'name': 'りんご',
          'photo': {'path': 'path/to/photo', 'isBuiltin': true},
          'categoryId': 'testcategoryid'
        }));
  }));
}
