import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/gateway/category_gateway.dart';
import 'package:mtoybox/modules/domain/model/category/categories.dart';
import 'package:mtoybox/modules/domain/model/category/category_id.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/infrastructure/file_system.dart';
import 'package:mtoybox/modules/interface/converter/category_map_converter.dart';

class CategoryRepository implements CategoryGateway {
  static final _cache = CategoryRepository(
      fs: FileSystem.instance(), converter: CategoryMapConverter());

  final FileSystem fs;
  final CategoryMapConverter converter;

  final categoryFile = 'category.json';

  CategoryRepository({required this.fs, required this.converter});

  factory CategoryRepository.instance() {
    return _cache;
  }

  @override
  Future<void> initialize() async {
    if (!await _exists()) {
      _initializeWithDefault();
      return;
    }
    try {
      // 正常に読み込みできるか確認
      _readAsMap();
    } catch (e) {
      // 読み込みに失敗した場合も初期化する
      _initializeWithDefault();
    }
  }

  @override
  Future<Categories> getAll() async {
    if (!await fs.existsInDocumentPath(categoryFile)) {
      throw Exception('Category not found, restart app.');
    }
    dynamic result = jsonDecode(await fs.readInDocumentPath(categoryFile));
    if (result is! List) {
      throw Exception('failed to read category from file');
    }
    return Categories(result.map((e) {
      return converter.fromMap(e);
    }).toList());
  }

  @override
  Future<Category?> findById(CategoryId id) async {
    var categories = await getAll();
    return categories.findById(id);
  }

  @override
  Future<void> save(Category category) async {
    var categories = await getAll();
    if (!categories.exists(category.id)) {
      categories.add(category);
    } else {
      categories.update(category);
    }
    saveAll(categories.asList());
  }

  Future<bool> _exists() async {
    return await fs.existsInDocumentPath(categoryFile);
  }

  Future<List> _readAsMap() async {
    dynamic result = jsonDecode(await fs.readInDocumentPath(categoryFile));
    if (result is! List<dynamic>) {
      throw Exception('failed to read category from file');
    }
    return result;
  }

  Future<void> _initializeWithDefault() async {
    var defaults = [
      Category(CategoryId.generate(), 'どうぶつ', Colors.red),
      Category(CategoryId.generate(), 'くだもの', Colors.yellow),
      Category(CategoryId.generate(), 'やさい', Colors.green),
      Category(CategoryId.generate(), 'さかな', Colors.blue),
    ];
    await saveAll(defaults);
  }

  Future<void> saveAll(List<Category> categories) async {
    var jsonStr =
        jsonEncode(categories.map((e) => converter.toMap(e)).toList());
    fs.saveInDocumentPath(categoryFile, jsonStr);
  }
}
