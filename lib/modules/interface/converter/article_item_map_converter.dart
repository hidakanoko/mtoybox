import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/domain/model/article/item_id.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';
import 'package:mtoybox/modules/domain/model/category/category_id.dart';
import 'package:mtoybox/modules/domain/model/uuid.dart';

class ArticleItemMapConverter {
  Map<String, dynamic> toMap(Item item) {
    return {
      'id': item.id.toString(),
      'name': item.name,
      'photo': {'path': item.photo.path, 'isBuiltin': item.photo.isBuiltin},
      'categoryId': item.categoryId.toString()
    };
  }

  Item fromMap(Map<String, dynamic> map) {
    return Item(
        ItemId(UuidValue(map['id'])),
        Photo(map['photo']['path'], isBuiltin: map['photo']['isBuiltin']),
        map['name'],
        CategoryId(UuidValue(map['categoryId'])));
  }
}
