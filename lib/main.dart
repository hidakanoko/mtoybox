import 'package:flutter/material.dart';
import 'package:mtoybox/modules/interface/routes.dart';
import 'package:mtoybox/pages/image_library/article_list.dart';
import 'package:mtoybox/pages/image_library/create_article.dart';
import 'package:mtoybox/pages/menu.dart';
import 'package:mtoybox/pages/select_one.dart';

void main() {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'まどかのおもちゃ箱',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Menu(),
      routes: {
        Routes.selectOne.key: (context) => const SelectOne(),
        Routes.imageLibraryArticleList.key: ((context) => const ArticleList()),
        Routes.createArticle.key: ((context) => const CreateArticle()),
      },
    );
  }
}
