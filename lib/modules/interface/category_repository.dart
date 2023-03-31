import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/modules/domain/model/category/categories.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/infrastructure/file_system.dart';
import 'package:mtoybox/modules/interface/converter/category_map_converter.dart';

class CategoryRepository extends StateNotifier<Categories> {
  final FileSystem fs;
  final CategoryMapConverter converter = CategoryMapConverter();

  final categoryFile = 'category.json';

  CategoryRepository(super._state, {required this.fs});

  Future<void> init() async {
    await _cacheCategories();
  }

  Future<void> save(Category category) async {
    var clonedList = state.asList();
    if (state.exists(category.id)) {
      clonedList.remove(state.findById(category.id));
      clonedList.add(category);
    } else {
      clonedList.add(category);
    }
    await _saveToFileAndUpdateState(clonedList);
  }

  Future<void> saveAll(Categories categories) async {
    await _saveToFileAndUpdateState(categories.asList());
  }

  Future<bool> dataExists() async {
    return await fs.existsInDocumentPath(categoryFile);
  }

  Future<void> _saveToFileAndUpdateState(List<Category> categories) async {
    var jsonStr =
        jsonEncode(categories.map((e) => converter.toMap(e)).toList());
    fs.saveInDocumentPath(categoryFile, jsonStr);
    await _cacheCategories();
  }

  Future<void> _cacheCategories() async {
    if (!await fs.existsInDocumentPath(categoryFile)) {
      throw Exception('Category not found, restart app.');
    }
    dynamic result = jsonDecode(await fs.readInDocumentPath(categoryFile));
    if (result is! List) {
      throw Exception('failed to read category from file');
    }

    state = Categories(result.map((e) {
      return converter.fromMap(e);
    }).toList());
  }
}
