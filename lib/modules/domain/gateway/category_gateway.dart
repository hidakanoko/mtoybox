import 'package:mtoybox/modules/domain/model/category/category_name.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';

abstract class CategoryGateway {
  Future<List<Category>> getAll();
}
