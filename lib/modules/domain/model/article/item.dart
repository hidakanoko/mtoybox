import 'package:mtoybox/modules/domain/model/article/photo.dart';
import 'package:mtoybox/modules/domain/model/category/category_name.dart';

class Item {
  final Photo photo;
  final String name;
  final CategoryName categoryName;

  Item(this.photo, this.name, this.categoryName);
}
