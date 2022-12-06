import 'package:flutter/material.dart';
import 'package:mtoybox/modules/interface/routes.dart';

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
                  Navigator.pushNamed(
                      context, Routes.imageLibraryArticleList.key);
                },
                child: const Text('ずかん')),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.selectOne.key);
                },
                child: const Text('えらんであそぼう')),
          ],
        ),
      ),
    );
  }
}
