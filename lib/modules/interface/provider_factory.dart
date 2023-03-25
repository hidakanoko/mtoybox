import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/domain/model/category/categories.dart';
import 'package:mtoybox/modules/infrastructure/file_system.dart';
import 'package:mtoybox/modules/interface/article_repository.dart';
import 'package:mtoybox/modules/interface/category_repository.dart';

final categoryProvider =
    StateNotifierProvider<CategoryRepository, Categories>((ref) {
  return CategoryRepository(Categories([]), fs: FileSystem.instance());
});

final articleProvider =
    StateNotifierProvider<ArticleRepository, List<Item>>((ref) {
  final categories = ref.watch(categoryProvider);
  return ArticleRepository([],
      fs: FileSystem.instance(), categories: categories);
});
