import 'package:flutter/material.dart';
import 'package:mtoybox/components/common/button/menu_button.dart';
import 'package:mtoybox/pages/article/article_list.dart';
import 'package:mtoybox/pages/category/category_list.dart';

class Menu extends StatelessWidget {
  const Menu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('まどかのおもちゃばこ'),
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
              text: 'ずかん',
              icon: Icons.photo_library_rounded,
            ),
            MenuButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const CategoryList()));
                },
                text: 'できごと・なかま',
                icon: Icons.category_rounded),
          ],
        ),
      ),
    );
  }
}
