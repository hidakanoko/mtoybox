import 'package:mtoybox/modules/domain/model/article/item_id.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';
import 'package:mtoybox/modules/domain/model/category/category_id.dart';

class Item {
  final ItemId id;
  Photo photo;
  String name;
  CategoryId? categoryId;

  Item(this.id, this.photo, this.name, this.categoryId);

  Item clone() {
    return Item(id, photo.clone(), name, categoryId);
  }
}
