import 'package:flutter/material.dart';
import 'package:mtoybox/components/article_icon.dart';
import 'package:mtoybox/modules/domain/gateway/article_gateway.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/interface/article_repository.dart';
import 'package:mtoybox/modules/interface/routes.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({super.key});

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  final ArticleGateway articleGateway = ArticleRepository.instance();

  Future<List<ArticleIcon>> _getArticleIcons() async {
    var list = await articleGateway.getAll();
    return list
        .map((item) => ArticleIcon(item, onTap: () => _onArticleIconTap(item)))
        .toList();
  }

  void _onArticleIconTap(item) {
    print(item);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getArticleIcons(),
        builder: ((context, snapshot) {
          Widget body;
          if (snapshot.hasData && snapshot.data != null) {
            body = GridView.count(
                crossAxisCount: 3, children: snapshot.data!.toList());
          } else {
            body = const Text('Loading...');
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('ずかん'),
            ),
            body: body,
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
    if (result == null || result is! Item) {
      return;
    }
    setState(() {});
  }
}
