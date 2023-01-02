import 'package:mtoybox/modules/domain/model/article/item.dart';

class ArticleItemMapConverter {
  Map<String, dynamic> toMap(Item item) {
    return {
      'name': item.name,
      'photo': {'path': item.photo.path, 'isBuiltin': item.photo.isBuiltin},
      'categoryName': item.category.name
    };
  }

  List<Item> fromMap(Map<String, dynamic> map) {
    // return Item(Photo(map['photo']['path'], isBuiltin: map['photo']['isBuiltin']), map['name'],
    //     Category('くだもの', Colors.purple))
    throw UnimplementedError('not yet implemented!');
  }
}
