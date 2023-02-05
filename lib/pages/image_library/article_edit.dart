import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';

class ArticleEdit extends StatefulWidget {
  final Item _item;
  const ArticleEdit(this._item, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _ArticleEditState();
  }
}

class _ArticleEditState extends State<ArticleEdit> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._item.name),
      ),
    );
  }
}
