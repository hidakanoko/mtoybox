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
        const [
          Photo('path/to/photo', isBuiltin: true),
          Photo('path/to/photo2', isBuiltin: false)
        ],
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
          'description': 'りんごのせつめい',
          'photos': [
            {'path': 'path/to/photo', 'isBuiltin': true},
            {'path': 'path/to/photo2', 'isBuiltin': false}
          ],
          'categoryId': 'testcategoryid'
        }));
  }));

  test('ArticleItemMapConverter fromMap()', (() {
    // given
    var map = {
      'id': 'testitemid',
      'name': 'りんご',
      'description': 'りんごのせつめい',
      'photos': [
        {'path': 'path/to/photo', 'isBuiltin': true},
        {'path': 'path/to/photo2', 'isBuiltin': false}
      ],
      'categoryId': 'testcategoryid'
    };

    // when
    var item = converter.fromMap(map);

    // then
    identical(
        item,
        Article(
            const ArticleId(IdentityUuid('testitemid')),
            const [
              Photo('path/to/photo', isBuiltin: true),
              Photo('path/to/photo2', isBuiltin: false)
            ],
            'りんご',
            'りんごのせつめい',
            const CategoryId(IdentityUuid('testcategoryid'))));
  }));
}
