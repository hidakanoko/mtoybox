import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/modules/domain/model/article/article.dart';
import 'package:mtoybox/modules/infrastructure/file_system.dart';
import 'package:mtoybox/modules/interface/converter/article_map_converter.dart';

class ArticleRepository extends StateNotifier<List<Article>> {
  final FileSystem _fs;
  final ArticleMapConverter _converter = ArticleMapConverter();
  final articleFile = 'article.json';

  ArticleRepository(super._state, {required FileSystem fs}) : _fs = fs;

  Future<void> init() async {
    await _cacheItems();
  }

  Future<void> save(Article article) async {
    var cloned = List.of(state);
    var idx = cloned.indexWhere((element) => element.id == article.id);
    if (idx >= 0) {
      cloned.removeAt(idx);
    }
    cloned.add(article);
    await _saveToFileAndCache(cloned);
  }

  Future<void> saveAll(List<Article> articles) async {
    await _saveToFileAndCache(articles);
  }

  Future<void> delete(Article article) async {
    var deleteIndex = state.indexWhere((element) => element.id == article.id);
    if (deleteIndex < 0) {
      throw Exception('article not exists. cannot delete!');
    }
    var copy = [...state];
    copy.removeAt(deleteIndex);
    state = [...copy];
  }

  Future<bool> dataExists() async {
    return await _fs.existsInDocumentPath(articleFile);
  }

  Future<void> _saveToFileAndCache(List<Article> articles) async {
    var itemsMap = articles.map((e) => _converter.toMap(e)).toList();
    var jsonText = jsonEncode(itemsMap);
    await _fs.saveInDocumentPath(articleFile, jsonText);
    await _cacheItems();
  }

  Future<void> _cacheItems() async {
    if (!await dataExists()) {
      throw Exception('item file not exists!');
    }
    var contents = json.decode(await _fs.readInDocumentPath(articleFile));
    if (contents is List && contents.any((e) => e! is Map<String, dynamic>)) {
      state = contents.map<Article>((e) => _converter.fromMap(e)).toList();
    } else {
      throw Exception('failed to read items from file');
    }
  }
}
