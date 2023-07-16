import 'package:mtoybox/modules/domain/model/article/article_id.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';
import 'package:mtoybox/modules/domain/model/category/category_id.dart';

class Article {
  final ArticleId id;
  Photo photo;
  String name;
  String description;
  CategoryId? categoryId;

  Article(this.id, this.photo, this.name, this.description, this.categoryId);

  Article clone() {
    return Article(id, photo.clone(), name, description, categoryId);
  }
}
