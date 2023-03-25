import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/domain/model/article/item_id.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';
import 'package:mtoybox/modules/domain/model/category/categories.dart';
import 'package:mtoybox/modules/infrastructure/file_system.dart';
import 'package:mtoybox/modules/interface/converter/article_item_map_converter.dart';

class ArticleRepository extends StateNotifier<List<Item>> {
  final FileSystem _fs;
  final ArticleItemMapConverter _converter = ArticleItemMapConverter();
  final Categories _categories;
  final articleFile = 'article.json';

  ArticleRepository(super._state,
      {required FileSystem fs, required Categories categories})
      : _fs = fs,
        _categories = categories;

  Future<void> save(Item article) async {
    var cloned = List.of(state);
    var idx = cloned.indexWhere((element) => element.id == article.id);
    if (idx >= 0) {
      cloned.removeAt(idx);
    }
    cloned.add(article);
    await _saveToFileAndCache(cloned);
  }

  Future<void> initialize() async {
    if (!await _fileExists()) {
      await _initializeWithDefault();
    }
    try {
      await _cacheItems();
    } catch (e) {
      // キャッシュに失敗した場合 (フォーマット不正 etc) もう一度初期化してキャッシュリトライ
      await _initializeWithDefault();
    }
  }

  Future<void> _initializeWithDefault() async {
    var items = [
      Item(
          ItemId.generate(),
          const Photo('assets/images/fruits/apple1.png', isBuiltin: true),
          'りんご1',
          _categories.findByName('くだもの')?.id),
      Item(
          ItemId.generate(),
          const Photo('assets/images/fruits/apple2.png', isBuiltin: true),
          'りんご2',
          _categories.findByName('くだもの')?.id),
      Item(
          ItemId.generate(),
          const Photo('assets/images/fruits/mikan1.png', isBuiltin: true),
          'みかん',
          _categories.findByName('くだもの')?.id),
      Item(
          ItemId.generate(),
          const Photo('assets/images/fruits/watermelon1.png', isBuiltin: true),
          'めろん',
          _categories.findByName('やさい')?.id),
    ];
    await _saveToFileAndCache(items);
  }

  Future<bool> _fileExists() async {
    return await _fs.existsInDocumentPath(articleFile);
  }

  Future<void> _saveToFileAndCache(List<Item> articles) async {
    var itemsMap = articles.map((e) => _converter.toMap(e)).toList();
    var jsonText = jsonEncode(itemsMap);
    await _fs.saveInDocumentPath(articleFile, jsonText);
    await _cacheItems();
  }

  Future<void> _cacheItems() async {
    if (!await _fileExists()) {
      throw Exception('item file not exists!');
    }
    dynamic contents = json.decode(await _fs.readInDocumentPath(articleFile));
    if (contents is List && contents.any((e) => e! is Map<String, dynamic>)) {
      state = contents.map<Item>((e) => _converter.fromMap(e)).toList();
    } else {
      throw Exception('failed to read items from file');
    }
  }
}
