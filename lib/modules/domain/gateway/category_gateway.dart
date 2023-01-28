import 'package:mtoybox/modules/domain/model/category/categories.dart';
import 'package:mtoybox/modules/domain/model/category/category_id.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';

abstract class CategoryGateway {
  Future<void> initialize();
  Future<Categories> getAll();
  Future<Category?> findById(CategoryId id);
  Future<void> save(Category category);
}
