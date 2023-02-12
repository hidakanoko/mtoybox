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
  static final _instance = ArticleRepository(
      fs: FileSystem.instance(),
      converter: ArticleItemMapConverter(),
      categoryGateway: CategoryRepository.instance());
  List<Item>? _cache;
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
    return _instance;
  }

  @override
  List<Item> getAll() {
    var cache = _cache;
    if (cache == null) {
      throw Exception('Articles not initialized yet');
    }
    return cache;
  }

  @override
  Future<void> save(Item article) async {
    var items = getAll();
    var idx = items.indexWhere((element) => element.id == article.id);
    if (idx >= 0) {
      items.removeAt(idx);
    }
    items.add(article);
    await _saveToFile(items);
  }

  @override
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
    await _saveToFile(items);
  }

  Future<bool> _fileExists() async {
    return await _fs.existsInDocumentPath(articleFile);
  }

  Future<void> _saveToFile(List<Item> articles) async {
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
      _cache = contents.map<Item>((e) => _converter.fromMap(e)).toList();
    } else {
      throw Exception('failed to read items from file');
    }
  }
}
