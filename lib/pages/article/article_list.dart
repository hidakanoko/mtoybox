import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/components/article_icon.dart';
import 'package:mtoybox/components/button/floating_add_button.dart';
import 'package:mtoybox/modules/domain/model/article/article.dart';
import 'package:mtoybox/modules/interface/provider_factory.dart';
import 'package:mtoybox/pages/article/article_view/article_view.dart';
import 'package:mtoybox/pages/article/create_article.dart';

class ArticleList extends ConsumerWidget {
  const ArticleList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articles = ref.watch(articleRepositoryProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('ずかん'),
      ),
      body: GridView.count(
          crossAxisCount: 3, children: _getArticleIcons(context, articles)),
      floatingActionButton:
          FloatingAddButton(onPressed: () => addArticle(context)),
    );
  }

  List<ArticleIcon> _getArticleIcons(
      BuildContext context, List<Article> articles) {
    return articles
        .map((item) =>
            ArticleIcon(item, onTap: () => _onArticleIconTap(context, item)))
        .toList();
  }

  Future<void> _onArticleIconTap(BuildContext context, Article item) async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: ((context) => ArticleView(item))));
  }

  addArticle(BuildContext context) async {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: ((context) => const CreateArticle())));
  }
}
