import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/components/article/article_icon.dart';
import 'package:mtoybox/components/common/app_bar_title.dart';
import 'package:mtoybox/components/common/button/app_bar_back.dart';
import 'package:mtoybox/components/common/button/category_filter_button.dart';
import 'package:mtoybox/components/common/button/floating_add_button.dart';
import 'package:mtoybox/components/common/button/sort_button.dart';
import 'package:mtoybox/modules/domain/model/article/article.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/interface/provider_factory.dart';
import 'package:mtoybox/pages/article/article_view/article_view.dart';
import 'package:mtoybox/pages/article/create_article.dart';

class ArticleList extends ConsumerStatefulWidget {
  const ArticleList({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ArticleListState();
  }
}

class _ArticleListState extends ConsumerState {
  SortOrder sortOrder = SortOrder.asc;
  @override
  Widget build(BuildContext context) {
    final articles = ref.watch(articleRepositoryProvider);
    final sortOrder = ref.watch(articleListSortOrderProvider);
    final categoryFilter = ref.watch(categoryFilterProvider);

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: AppBar(
            title: const AppBarTitle('もどる'),
            actions: const [
              SortButton(),
              CategoryFilterButton(),
            ],
            leading: const AppBarBack(),
          )),
      body: GridView.count(
          crossAxisCount: 3,
          children:
              _getArticleIcons(context, articles, sortOrder, categoryFilter)),
      floatingActionButton:
          FloatingAddButton(onPressed: () => addArticle(context)),
    );
  }

  List<Widget> _getArticleIcons(BuildContext context, List<Article> articles,
      SortOrder sortOrder, Category? categoryFilter) {
    articles.sort((a, b) {
      return sortOrder.isAsc
          ? a.name.compareTo(b.name)
          : b.name.compareTo(a.name);
    });
    return articles
        .where((element) =>
            categoryFilter == null || categoryFilter.id == element.categoryId)
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
