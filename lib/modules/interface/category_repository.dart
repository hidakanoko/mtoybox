import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/modules/domain/model/category/category_id.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/infrastructure/file_system.dart';
import 'package:mtoybox/modules/interface/converter/category_map_converter.dart';

class CategoryRepository extends StateNotifier<List<Category>> {
  final FileSystem fs;
  final CategoryMapConverter converter = CategoryMapConverter();

  final categoryFile = 'category.json';

  CategoryRepository(super._state, {required this.fs});

  Category? findById(CategoryId id) {
    if (!exists(id)) {
      return null;
    }
    return state.firstWhere((element) {
      return element.id == id;
    });
  }

  bool exists(CategoryId id) {
    return state.any((element) => element.id == id);
  }

  Future<void> save(Category category) async {
    var cloned = List.of(state);
    var old = findById(category.id);
    if (old == null) {
      cloned.add(category);
    } else {
      cloned.remove(old);
      cloned.add(category);
    }
    await _saveToFileAndCache(cloned);
  }

  Future<void> initialize() async {
    if (!await _fileExists()) {
      _initializeWithDefault();
      return;
    }
    try {
      _cacheCategories();
    } catch (e) {
      // キャッシュに失敗した場合 (フォーマット不正 etc) もう一度初期化してキャッシュリトライ
      _initializeWithDefault();
      _cacheCategories();
    }
  }

  Future<bool> _fileExists() async {
    return await fs.existsInDocumentPath(categoryFile);
  }

  Future<void> _initializeWithDefault() async {
    var defaults = [
      Category(CategoryId.generate(), 'どうぶつ', Colors.red),
      Category(CategoryId.generate(), 'くだもの', Colors.yellow),
      Category(CategoryId.generate(), 'やさい', Colors.green),
      Category(CategoryId.generate(), 'さかな', Colors.blue),
    ];
    await _saveToFileAndCache(defaults);
  }

  Future<void> _saveToFileAndCache(List<Category> categories) async {
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

    state = result.map((e) {
      return converter.fromMap(e);
    }).toList();
  }
}
