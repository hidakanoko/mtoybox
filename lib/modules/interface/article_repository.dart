import 'dart:convert';

import 'package:mtoybox/modules/domain/gateway/article_gateway.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';
import 'package:mtoybox/modules/domain/model/category/category_name.dart';
import 'package:mtoybox/modules/infrastructure/file_system.dart';
import 'package:mtoybox/modules/interface/converter/article_item_map_converter.dart';

class ArticleRepository implements ArticleGateway {
  static final _cache = ArticleRepository(
      fs: FileSystem.instance(), converter: ArticleItemMapConverter());

  final FileSystem fs;
  final ArticleItemMapConverter converter;

  final articleFile = 'article.json';
  final initialArticles = [
    Item(Photo('assets/images/fruits/apple1.png', isBuiltin: true), 'りんご1',
        CategoryName('くだもの')),
    Item(Photo('assets/images/fruits/apple2.png', isBuiltin: true), 'りんご2',
        CategoryName('くだもの')),
    Item(Photo('assets/images/fruits/mikan1.png', isBuiltin: true), 'みかん',
        CategoryName('くだもの')),
    Item(Photo('assets/images/fruits/watermelon1.png', isBuiltin: true), 'めろん',
        CategoryName('くだもの')),
  ];

  ArticleRepository({required this.fs, required this.converter});

  factory ArticleRepository.instance() {
    return _cache;
  }

  @override
  Future<bool> exists() async {
    return await fs.existsInDocumentPath(articleFile);
  }

  @override
  Future<List<Item>> getAll() async {
    if (!await exists()) {
      return [];
    }
    dynamic contents = json.decode(await fs.readInDocumentPath(articleFile));
    if (contents is List && contents.any((e) => e! is Map<String, dynamic>)) {
      return contents.map((e) => converter.fromMap(e)).toList();
    } else {
      throw Exception('failed to read items from file');
    }
  }

  @override
  Future<void> save(List<Item> articles) async {
    var itemsMap = initialArticles.map((e) => converter.toMap(e)).toList();
    var jsonText = jsonEncode(itemsMap);
    await fs.saveInDocumentPath(articleFile, jsonText);
  }

  @override
  Future<void> initializeIfNotExists() async {
    if (await exists()) {
      return;
    }
    save(initialArticles);
  }
}
