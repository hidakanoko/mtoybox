import 'package:flutter/material.dart';
import 'package:mtoybox/components/article.dart';
import 'package:mtoybox/modules/domain/gateway/article_gateway.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/interface/article_repository.dart';
import 'package:mtoybox/modules/interface/routes.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({super.key});

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  final ArticleGateway articleGateway = ArticleRepository.instance();
  final List<Article> _articles = [
    Article(Item(Photo('assets/images/fruits/apple1.png', isBuiltin: true),
        'りんご1', Category('くだもの', Colors.blue))),
    Article(Item(Photo('assets/images/fruits/apple2.png', isBuiltin: true),
        'りんご2', Category('くだもの', Colors.green))),
    Article(Item(Photo('assets/images/fruits/mikan1.png', isBuiltin: true),
        'みかん', Category('くだもの', Colors.red))),
    Article(Item(Photo('assets/images/fruits/watermelon1.png', isBuiltin: true),
        'めろん', Category('くだもの', Colors.purple))),
  ];

  Future<List<Article>> getArticles() async {
    await articleGateway.initializeIfNotExists();
    var list = await articleGateway.getAll();
    print(list);
    return _articles;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getArticles(),
        builder: ((context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('ずかん'),
            ),
            body: GridView.count(
              crossAxisCount: 3,
              children: _articles.toList(),
            ),
            floatingActionButton: buildButton(),
          );
        }));
  }

  FloatingActionButton buildButton() {
    return FloatingActionButton(
        onPressed: addArticle, child: const Icon(Icons.add));
  }

  addArticle() async {
    dynamic result =
        await Navigator.pushNamed(context, Routes.createArticle.key);
    if (result == null || result is! Article) {
      return;
    }
    setState(() {
      _articles.add(result);
    });
  }
}
