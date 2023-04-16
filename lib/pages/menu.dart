import 'package:flutter/material.dart';
import 'package:mtoybox/components/button/menu_button.dart';
import 'package:mtoybox/pages/article/article_list.dart';
import 'package:mtoybox/pages/select_one.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('まどかのおもちゃ箱'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MenuButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ArticleList()));
                },
                text: 'ずかん'),
            MenuButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SelectOne()));
                },
                text: 'えらんであそぼう'),
          ],
        ),
      ),
    );
  }
}
