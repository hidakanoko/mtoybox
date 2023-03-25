import 'package:flutter/material.dart';
import 'package:mtoybox/components/article_icon.dart';
import 'package:mtoybox/components/button/floating_add_button.dart';
import 'package:mtoybox/modules/domain/gateway/article_gateway.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/interface/article_repository.dart';
import 'package:mtoybox/pages/article/article_view/article_view.dart';
import 'package:mtoybox/pages/article/create_article.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({super.key});

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  final ArticleGateway articleGateway = ArticleRepository.instance();

  List<ArticleIcon> _getArticleIcons() {
    var list = articleGateway.getAll();
    return list
        .map((item) => ArticleIcon(item, onTap: () => _onArticleIconTap(item)))
        .toList();
  }

  Future<void> _onArticleIconTap(Item item) async {
    await Navigator.of(context)
        .push(MaterialPageRoute(builder: ((context) => ArticleView(item))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ずかん'),
      ),
      body: GridView.count(crossAxisCount: 3, children: _getArticleIcons()),
      floatingActionButton: FloatingAddButton(onPressed: addArticle),
    );
  }

  addArticle() async {
    dynamic result = await Navigator.of(context)
        .push(MaterialPageRoute(builder: ((context) => const CreateArticle())));
    if (result == null || result is! Item) {
      return;
    }
    setState(() {});
  }
}