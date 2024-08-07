import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/modules/application/repository_initializer.dart';
import 'package:mtoybox/modules/domain/model/article/article.dart';
import 'package:mtoybox/modules/domain/model/category/categories.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/infrastructure/file_system.dart';
import 'package:mtoybox/modules/interface/article_repository.dart';
import 'package:mtoybox/modules/interface/category_repository.dart';

final categoryRepositoryProvider =
    StateNotifierProvider<CategoryRepository, Categories>((ref) {
  return CategoryRepository(const Categories([]), fs: FileSystem.instance());
});

final articleRepositoryProvider =
    StateNotifierProvider<ArticleRepository, List<Article>>((ref) {
  return ArticleRepository([], fs: FileSystem.instance());
});

final repositoryInitializerFutureProvider = FutureProvider((ref) async {
  var repositoryInitializer = RepositoryInitializer(
      categoryRepository: ref.read(categoryRepositoryProvider.notifier),
      articleRepository: ref.read(articleRepositoryProvider.notifier));
  return repositoryInitializer.initializeIfNotExists();
});

enum SortOrder {
  asc,
  desc;

  bool get isAsc => this == SortOrder.asc;
}

final articleListSortOrderProvider = StateProvider<SortOrder>((ref) {
  return SortOrder.asc;
});

final categoryFilterProvider = StateProvider<Category?>((ref) {
  return null;
});
