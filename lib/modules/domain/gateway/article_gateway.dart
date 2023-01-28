import 'package:mtoybox/modules/domain/model/article/item.dart';

abstract class ArticleGateway {
  Future<bool> exists();
  Future<void> save(Item article);
  Future<List<Item>> getAll();
  Future<void> initialize();
}
