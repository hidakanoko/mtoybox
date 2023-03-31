import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/infrastructure/file_system.dart';
import 'package:mtoybox/modules/interface/converter/article_item_map_converter.dart';

class ArticleRepository extends StateNotifier<List<Item>> {
  final FileSystem _fs;
  final ArticleItemMapConverter _converter = ArticleItemMapConverter();
  final articleFile = 'article.json';

  ArticleRepository(super._state, {required FileSystem fs}) : _fs = fs;

  Future<void> init() async {
    await _cacheItems();
  }

  Future<void> save(Item article) async {
    var cloned = List.of(state);
    var idx = cloned.indexWhere((element) => element.id == article.id);
    if (idx >= 0) {
      cloned.removeAt(idx);
    }
    cloned.add(article);
    await _saveToFileAndCache(cloned);
  }

  Future<void> saveAll(List<Item> articles) async {
    await _saveToFileAndCache(articles);
  }

  Future<bool> dataExists() async {
    return await _fs.existsInDocumentPath(articleFile);
  }

  Future<void> _saveToFileAndCache(List<Item> articles) async {
    var itemsMap = articles.map((e) => _converter.toMap(e)).toList();
    var jsonText = jsonEncode(itemsMap);
    await _fs.saveInDocumentPath(articleFile, jsonText);
    await _cacheItems();
  }

  Future<void> _cacheItems() async {
    if (!await dataExists()) {
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
