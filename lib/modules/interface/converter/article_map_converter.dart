import 'package:mtoybox/modules/domain/model/article/article.dart';
import 'package:mtoybox/modules/domain/model/article/article_id.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';
import 'package:mtoybox/modules/domain/model/category/category_id.dart';
import 'package:mtoybox/modules/domain/model/identity_uuid.dart';
import 'package:mtoybox/modules/interface/converter/photo_map_converter.dart';

class ArticleMapConverter {
  final PhotoMapConverter _photoMapConverter = PhotoMapConverter();

  Map<String, dynamic> toMap(Article item) {
    return {
      'id': item.id.toString(),
      'name': item.name,
      'description': item.description,
      'photos': item.photos.map((e) => _photoMapConverter.toMap(e)).toList(),
      'categoryId': item.categoryId.toString()
    };
  }

  Article fromMap(Map<String, dynamic> map) {
    return Article(
        ArticleId(IdentityUuid(map['id'])),
        _extractPhotosElement(map)
            .map<Photo>((e) => _photoMapConverter.fromMap(e))
            .toList(),
        map['name'],
        map['description'],
        CategoryId(IdentityUuid(map['categoryId'])));
  }

  List<Map<String, dynamic>> _extractPhotosElement(Map<String, dynamic> map) {
    final photos = map['photos'] as List;
    if (photos.runtimeType == List) {
      return photos.cast<Map<String, dynamic>>();
    } else {
      return [];
    }
  }
}
