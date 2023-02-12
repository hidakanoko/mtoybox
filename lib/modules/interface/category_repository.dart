import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/gateway/category_gateway.dart';
import 'package:mtoybox/modules/domain/model/category/categories.dart';
import 'package:mtoybox/modules/domain/model/category/category_id.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/infrastructure/file_system.dart';
import 'package:mtoybox/modules/interface/converter/category_map_converter.dart';

class CategoryRepository implements CategoryGateway {
  static final _instance = CategoryRepository(
      fs: FileSystem.instance(), converter: CategoryMapConverter());
  Categories? _cache;
  final FileSystem fs;
  final CategoryMapConverter converter;

  final categoryFile = 'category.json';

  CategoryRepository({required this.fs, required this.converter});

  factory CategoryRepository.instance() {
    return _instance;
  }

  @override
  Future<void> initialize() async {
    if (!await _exists()) {
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

  @override
  Categories getAll() {
    var cache = _cache;
    if (cache == null) {
      throw Exception('Category not found, restart app.');
    }
    return cache;
  }

  @override
  Category? findById(CategoryId id) {
    return getAll().findById(id);
  }

  @override
  Future<void> save(Category category) async {
    var categories = getAll();
    if (!categories.exists(category.id)) {
      categories.add(category);
    } else {
      categories.update(category);
    }
    await _saveToFile(categories.asList());
  }

  Future<bool> _exists() async {
    return await fs.existsInDocumentPath(categoryFile);
  }

  Future<void> _initializeWithDefault() async {
    var defaults = [
      Category(CategoryId.generate(), 'どうぶつ', Colors.red),
      Category(CategoryId.generate(), 'くだもの', Colors.yellow),
      Category(CategoryId.generate(), 'やさい', Colors.green),
      Category(CategoryId.generate(), 'さかな', Colors.blue),
    ];
    await _saveToFile(defaults);
  }

  Future<void> _saveToFile(List<Category> categories) async {
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
    _cache = Categories(result.map((e) {
      return converter.fromMap(e);
    }).toList());
  }
}
