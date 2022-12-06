import 'package:flutter/material.dart';
import 'package:mtoybox/components/photo_image_provider_factory.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';

class Article extends StatefulWidget {
  final Item item;

  const Article(this.item, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _Article();
  }
}

class _Article extends State<Article> {
  bool selected = false;

  void select() {
    selected = true;
  }

  void deselect() {
    selected = false;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          color: widget.item.themeColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
                child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: PhotoImageProviderFactory.create(widget.item.photo),
                    fit: BoxFit.fitHeight),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.all(5),
            )),
            Container(
              margin: const EdgeInsets.only(top: 0, bottom: 5),
              child: Text(
                widget.item.name,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            )
          ],
        ));
  }
}
