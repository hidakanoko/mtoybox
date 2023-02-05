import 'package:flutter/material.dart';
import 'package:mtoybox/pages/image_library/article_list.dart';
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
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ArticleList()));
                },
                child: const Text('ずかん')),
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SelectOne()));
                },
                child: const Text('えらんであそぼう')),
          ],
        ),
      ),
    );
  }
}
