import 'package:flutter/material.dart';
import 'package:mtoybox/modules/interface/article_repository.dart';
import 'package:mtoybox/modules/interface/category_repository.dart';
import 'package:mtoybox/pages/menu.dart';

void main() async {
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    CategoryRepository.instance()
        .initialize()
        .whenComplete(() => ArticleRepository.instance().initialize());

    return MaterialApp(
      title: 'まどかのおもちゃ箱',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Menu(),
    );
  }
}
