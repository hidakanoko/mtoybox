import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';
import 'package:mtoybox/modules/domain/model/category/category_name.dart';

class ArticleItemMapConverter {
  Map<String, dynamic> toMap(Item item) {
    return {
      'name': item.name,
      'photo': {'path': item.photo.path, 'isBuiltin': item.photo.isBuiltin},
      'categoryName': item.categoryName
    };
  }

  Item fromMap(Map<String, dynamic> map) {
    return Item(
        Photo(map['photo']['path'], isBuiltin: map['photo']['isBuiltin']),
        map['name'],
        CategoryName('くだもの'));
  }
}
