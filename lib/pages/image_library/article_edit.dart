import 'package:flutter/material.dart';
import 'package:mtoybox/components/article_image.dart';
import 'package:mtoybox/components/category_item.dart';
import 'package:mtoybox/components/category_selector.dart';
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
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isEditing ? _createEditBody() : _createViewBody(),
      floatingActionButton: isEditing ? buildSaveButton() : buildEditButton(),
    );
  }

  Category? _getCategory() {
    var categoryId = widget._item.categoryId;
    return categoryId != null ? _categoryGateway.findById(categoryId) : null;
  }

  FloatingActionButton buildEditButton() {
    return FloatingActionButton(
        onPressed: _editArticle, child: const Icon(Icons.edit_rounded));
  }

  FloatingActionButton buildSaveButton() {
    return FloatingActionButton(
        onPressed: _saveArticle, child: const Icon(Icons.done));
  }

  void _editArticle() {
    setState(() {
      isEditing = true;
    });
  }

  void _saveArticle() {
    setState(() {
      isEditing = false;
    });
  }

  Widget _createViewBody() {
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

  Widget _createEditBody() {
    var items = <Widget>[];
    items.add(Center(
        child: Text(widget._item.name, style: const TextStyle(fontSize: 30))));

    items.add(ArticleImage(widget._item.photo));

    var category = _getCategory();
    items.add(CategorySelector(category));

    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: items,
      ),
    );
  }
}
