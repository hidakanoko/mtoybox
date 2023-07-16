import 'package:mtoybox/modules/domain/model/article/article.dart';
import 'package:mtoybox/modules/domain/model/article/article_id.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';
import 'package:mtoybox/modules/domain/model/category/category_id.dart';
import 'package:mtoybox/modules/domain/model/identity_uuid.dart';

class ArticleMapConverter {
  Map<String, dynamic> toMap(Article item) {
    return {
      'id': item.id.toString(),
      'name': item.name,
      'photo': {'path': item.photo.path, 'isBuiltin': item.photo.isBuiltin},
      'categoryId': item.categoryId.toString()
    };
  }

  Article fromMap(Map<String, dynamic> map) {
    return Article(
        ArticleId(IdentityUuid(map['id'])),
        Photo(map['photo']['path'], isBuiltin: map['photo']['isBuiltin']),
        map['name'],
        map['description'],
        CategoryId(IdentityUuid(map['categoryId'])));
  }
}
