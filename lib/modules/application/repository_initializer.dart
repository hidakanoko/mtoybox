import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/model/article/article.dart';
import 'package:mtoybox/modules/domain/model/article/article_id.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';
import 'package:mtoybox/modules/domain/model/category/categories.dart';
import 'package:mtoybox/modules/domain/model/category/category_id.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/interface/article_repository.dart';
import 'package:mtoybox/modules/interface/category_repository.dart';

class RepositoryInitializer {
  final CategoryRepository categoryRepository;
  final ArticleRepository articleRepository;

  const RepositoryInitializer(
      {required this.categoryRepository, required this.articleRepository});

  Future<void> initializeIfNotExists() async {
    if (await categoryRepository.dataExists() &&
        await articleRepository.dataExists()) {
      await categoryRepository.init();
      await articleRepository.init();
      return;
    }
    var categories = defaultCategories();
    categoryRepository.saveAll(categories);

    var articles = defaultArticles(categories);
    articleRepository.saveAll(articles);
  }

  Categories defaultCategories() {
    return Categories([
      Category(CategoryId.generate(), 'どうぶつ', Colors.red),
      Category(CategoryId.generate(), 'さかな', Colors.blue),
      Category(CategoryId.generate(), 'むし', Colors.purple),
      Category(CategoryId.generate(), 'くだもの', Colors.yellow),
      Category(CategoryId.generate(), 'やさい', Colors.green),
    ]);
  }

  List<Article> defaultArticles(Categories categories) {
    return [
      Article(
          ArticleId.generate(),
          const [Photo('assets/images/fruits/apple1.png', isBuiltin: true)],
          'りんご1',
          '',
          categories.findByName('くだもの')?.id),
      Article(
          ArticleId.generate(),
          const [Photo('assets/images/fruits/apple2.png', isBuiltin: true)],
          'りんご2',
          '',
          categories.findByName('くだもの')?.id),
      Article(
          ArticleId.generate(),
          const [Photo('assets/images/fruits/mikan1.png', isBuiltin: true)],
          'みかん',
          '',
          categories.findByName('くだもの')?.id),
      Article(
          ArticleId.generate(),
          const [
            Photo('assets/images/fruits/watermelon1.png', isBuiltin: true)
          ],
          'めろん',
          '',
          categories.findByName('やさい')?.id),
    ];
  }
}
