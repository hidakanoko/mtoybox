import 'package:mtoybox/modules/domain/model/category/category_name.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';

class Categories {
  final List<Category> _list;

  Categories(this._list);

  Category findByName(CategoryName categoryName) {
    return _list.firstWhere((element) {
      return element.name == categoryName;
    });
  }
}
