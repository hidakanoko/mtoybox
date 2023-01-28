import 'package:mtoybox/modules/domain/model/category/category_id.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';

class Categories {
  final List<Category> _list;

  Categories(this._list);

  Category? findById(CategoryId id) {
    if (!exists(id)) {
      return null;
    }
    return _list.firstWhere((element) {
      return element.id == id;
    });
  }

  Category? findByName(String name) {
    if (_list.any((element) => element.name == name)) {
      return _list.firstWhere((element) => element.name == name);
    } else {
      return null;
    }
  }

  bool exists(CategoryId id) {
    return _list.any((element) => element.id == id);
  }

  void add(Category category) {
    _list.add(category);
  }

  void update(Category category) {
    var old = findById(category.id);
    _list.remove(old);
    _list.add(category);
  }

  List<Category> asList() {
    return _list.toList();
  }
}
