import 'package:flutter/material.dart';
import 'package:mtoybox/components/article_image.dart';
import 'package:mtoybox/components/input/article_name_edit.dart';
import 'package:mtoybox/components/button/floating_close_button.dart';
import 'package:mtoybox/components/button/floating_commit_button.dart';
import 'package:mtoybox/components/button/floating_edit_button.dart';
import 'package:mtoybox/components/category_item.dart';
import 'package:mtoybox/components/category_selector.dart';
import 'package:mtoybox/modules/domain/gateway/article_gateway.dart';
import 'package:mtoybox/modules/domain/gateway/category_gateway.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/interface/article_repository.dart';
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
  final ArticleGateway _articleGateway = ArticleRepository.instance();
  Item? _editingItem;
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: isEditing ? _createEditBody() : _createViewBody(),
      floatingActionButton: isEditing
          ? buildSaveButton()
          : FloatingEditButton(onPressed: _editArticle),
    );
  }

  Category? _getCategory() {
    var categoryId = widget._item.categoryId;
    return categoryId != null ? _categoryGateway.findById(categoryId) : null;
  }

  Widget buildSaveButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 5),
          child: FloatingCloseButton(onPressed: _cancelEdit),
        ),
        FloatingCommitButton(
          onPressed: _saveArticle,
        )
      ],
    );
  }

  void _editArticle() {
    setState(() {
      _editingItem = widget._item.clone();
      isEditing = true;
    });
  }

  void _cancelEdit() {
    setState(() {
      _editingItem = null;
      isEditing = false;
    });
  }

  void _saveArticle() {
    setState(() {
      var item = _editingItem;
      if (item != null) {
        widget._item.name = item.name;
        widget._item.categoryId = item.categoryId;
        _articleGateway.save(widget._item);
      }
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
    _editingItem = widget._item.clone();
    var items = <Widget>[];
    items.add(Center(
        child: ArticleNameEdit(
      initialValue: widget._item.name,
      onChanged: (text) {
        _editingItem?.name = text;
      },
    )));

    items.add(ArticleImage(widget._item.photo));

    var category = _getCategory();
    items.add(CategorySelector(
      category,
      onChanged: (p0) {
        _editingItem?.categoryId = p0.id;
      },
    ));

    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: items,
      ),
    );
  }
}
