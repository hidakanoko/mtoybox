import 'package:mtoybox/modules/domain/model/article/article_id.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';
import 'package:mtoybox/modules/domain/model/category/category_id.dart';

class Article {
  final ArticleId id;
  List<Photo> photos;
  String name;
  String description;
  CategoryId? categoryId;

  Article(this.id, this.photos, this.name, this.description, this.categoryId);

  Article clone() {
    return Article(id, photos.map((e) => e.clone()).toList(), name, description,
        categoryId);
  }
}
