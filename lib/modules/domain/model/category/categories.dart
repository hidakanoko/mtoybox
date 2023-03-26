import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/model/category/category_id.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';

@immutable
class Categories {
  final List<Category> _list;

  const Categories(this._list);

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

  List<Category> asList() {
    return List.of(_list);
  }

  Categories copyWith() {
    return Categories(asList());
  }
}
