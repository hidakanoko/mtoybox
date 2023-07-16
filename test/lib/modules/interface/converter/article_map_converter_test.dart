import 'package:flutter_test/flutter_test.dart';
import 'package:mtoybox/modules/domain/model/article/article.dart';
import 'package:mtoybox/modules/domain/model/article/article_id.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';
import 'package:mtoybox/modules/domain/model/category/category_id.dart';
import 'package:mtoybox/modules/domain/model/identity_uuid.dart';
import 'package:mtoybox/modules/interface/converter/article_map_converter.dart';

void main() {
  var converter = ArticleMapConverter();
  test('ArticleItemMapConverter toMap()', (() {
    // given
    var item = Article(
        const ArticleId(IdentityUuid('testitemid')),
        const Photo('path/to/photo', isBuiltin: true),
        'りんご',
        'りんごのせつめい',
        const CategoryId(IdentityUuid('testcategoryid')));
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
