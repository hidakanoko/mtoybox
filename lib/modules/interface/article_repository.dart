import 'dart:convert';

import 'package:mtoybox/modules/domain/gateway/article_gateway.dart';
import 'package:mtoybox/modules/domain/gateway/category_gateway.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/domain/model/article/item_id.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';
import 'package:mtoybox/modules/domain/model/category/categories.dart';
import 'package:mtoybox/modules/infrastructure/file_system.dart';
import 'package:mtoybox/modules/interface/category_repository.dart';
import 'package:mtoybox/modules/interface/converter/article_item_map_converter.dart';

class ArticleRepository implements ArticleGateway {
  static final _cache = ArticleRepository(
      fs: FileSystem.instance(),
      converter: ArticleItemMapConverter(),
      categoryGateway: CategoryRepository.instance());

  final FileSystem _fs;
  final ArticleItemMapConverter _converter;
  final CategoryGateway _categoryGateway;

  final articleFile = 'article.json';

  ArticleRepository(
      {required FileSystem fs,
      required ArticleItemMapConverter converter,
      required CategoryGateway categoryGateway})
      : _fs = fs,
        _converter = converter,
        _categoryGateway = categoryGateway;

  factory ArticleRepository.instance() {
    return _cache;
  }
  @override
  Future<bool> exists() async {
    return await _fs.existsInDocumentPath(articleFile);
  }

  @override
  Future<List<Item>> getAll() async {
    if (!await exists()) {
      return [];
    }
    dynamic contents = json.decode(await _fs.readInDocumentPath(articleFile));
    if (contents is List && contents.any((e) => e! is Map<String, dynamic>)) {
      return contents.map<Item>((e) => _converter.fromMap(e)).toList();
    } else {
      throw Exception('failed to read items from file');
    }
  }

  @override
  Future<void> save(Item article) async {
    var items = await getAll();
    var idx = items.indexWhere((element) => element.id == article.id);
    if (idx >= 0) {
      items.removeAt(idx);
    }
    items.add(article);
    await _saveAsMap(items);
  }

  Future<void> _saveAsMap(List<Item> articles) async {
    var itemsMap = articles.map((e) => _converter.toMap(e)).toList();
    var jsonText = jsonEncode(itemsMap);
    await _fs.saveInDocumentPath(articleFile, jsonText);
  }

  @override
  Future<void> initialize() async {
    if (!await exists()) {
      await _initializeWithDefault();
    }
    try {
      // 読み込みできるかチェック
      await _readAsMap();
    } catch (e) {
      // 読み込みできない場合は初期化
      await _initializeWithDefault();
    }
  }

  Future<void> _initializeWithDefault() async {
    Categories categories = await _categoryGateway.getAll();

    var items = [
      Item(
          ItemId.generate(),
          Photo('assets/images/fruits/apple1.png', isBuiltin: true),
          'りんご1',
          categories.findByName('くだもの')?.id),
      Item(
          ItemId.generate(),
          Photo('assets/images/fruits/apple2.png', isBuiltin: true),
          'りんご2',
          categories.findByName('くだもの')?.id),
      Item(
          ItemId.generate(),
          Photo('assets/images/fruits/mikan1.png', isBuiltin: true),
          'みかん',
          categories.findByName('くだもの')?.id),
      Item(
          ItemId.generate(),
          Photo('assets/images/fruits/watermelon1.png', isBuiltin: true),
          'めろん',
          categories.findByName('やさい')?.id),
    ];
    await _saveAsMap(items);
  }

  Future<List<Map<String, dynamic>>> _readAsMap() async {
    dynamic contents = json.decode(await _fs.readInDocumentPath(articleFile));
    return contents;
  }
}
