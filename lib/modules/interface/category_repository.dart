import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/gateway/category_gateway.dart';
import 'package:mtoybox/modules/domain/model/category/category_name.dart';
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
  Future<List<Category>> getAll() async {
    if (!await fs.existsInDocumentPath(categoryFile)) {
      return _getDefault();
    }
    dynamic result = jsonDecode(await fs.readInDocumentPath(categoryFile));
    if (result! is List) {
      throw Exception('failed to read category from file');
    }
    return result.map((e) {
      if (e is Map<String, dynamic>) {
        return converter.fromMap(e);
      }
    });
  }

  List<Category> _getDefault() {
    return [
      Category(CategoryName('どうぶつ'), Colors.red),
      Category(CategoryName('くだもの'), Colors.yellow),
      Category(CategoryName('やさい'), Colors.green),
      Category(CategoryName('さかな'), Colors.blue),
    ];
  }
}
