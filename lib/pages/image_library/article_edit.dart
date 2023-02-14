import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/gateway/category_gateway.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/interface/category_repository.dart';

class ArticleEdit extends StatefulWidget {
  final Item _item;
  const ArticleEdit(this._item, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _ArticleEditState();
  }
}

class _ArticleEditState extends State<ArticleEdit> {
  final CategoryGateway _categoryGateway = CategoryRepository.instance();

  @override
  Widget build(BuildContext context) {
    var categoryId = widget._item.categoryId;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._item.name),
        backgroundColor: categoryId != null
            ? _categoryGateway.findById(categoryId)?.color
            : null,
      ),
    );
  }
}
