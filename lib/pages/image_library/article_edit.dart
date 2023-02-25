import 'package:flutter/material.dart';
import 'package:mtoybox/components/article_image.dart';
import 'package:mtoybox/components/category_item.dart';
import 'package:mtoybox/modules/domain/gateway/category_gateway.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
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
    return Scaffold(
      appBar: AppBar(),
      body: _createBody(),
      floatingActionButton: buildButton(),
    );
  }

  Category? _getCategory() {
    var categoryId = widget._item.categoryId;
    return categoryId != null ? _categoryGateway.findById(categoryId) : null;
  }

  FloatingActionButton buildButton() {
    return FloatingActionButton(
        onPressed: _editArticle, child: const Icon(Icons.edit_rounded));
  }

  void _editArticle() {}

  Widget _createBody() {
    var items = <Widget>[];
    items.add(Center(
        child: Text(widget._item.name, style: const TextStyle(fontSize: 30))));

    items.add(ArticleImage(widget._item.photo));

    var category = _getCategory();
    if (category != null) {
      items.add(Center(child: CategoryItem(category)));
    }

    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: items,
      ),
    );
  }
}
