import 'package:flutter/material.dart';
import 'package:mtoybox/components/article_image.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';

class Article extends StatelessWidget {
  final Item item;

  const Article(this.item, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            ArticleImage(item.photo),
            Container(
              margin: const EdgeInsets.only(top: 0, bottom: 5),
              child: Text(
                item.name,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ));
  }
}
