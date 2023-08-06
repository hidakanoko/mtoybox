import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/components/article/article_image.dart';
import 'package:mtoybox/components/article/article_name_input.dart';
import 'package:mtoybox/components/common/button/floating_close_button.dart';
import 'package:mtoybox/components/common/button/floating_commit_button.dart';
import 'package:mtoybox/components/category/category_label.dart';
import 'package:mtoybox/components/category/category_selector.dart';
import 'package:mtoybox/modules/domain/model/article/article.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/interface/provider_factory.dart';
import 'package:mtoybox/pages/article/article_view/popup_menu.dart';

class ArticleView extends ConsumerStatefulWidget {
  final Article _item;
  const ArticleView(this._item, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ArticleViewState();
  }
}

class _ArticleViewState extends ConsumerState<ArticleView> {
  late Article saved;
  late Article editing;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    saved = widget._item;
    editing = widget._item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget._item.name),
        actions: [PopupMenu(_editArticle, _deleteArticle)],
      ),
      body: isEditing ? _createEditBody() : _createViewBody(),
      floatingActionButton: isEditing ? buildSaveButton() : null,
    );
  }

  Category? _getCategory() {
    var categoryId = editing.categoryId;
    return categoryId != null
        ? ref.read(categoryRepositoryProvider).findById(categoryId)
        : null;
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

  void _deleteArticle() {
    ref.read(articleRepositoryProvider.notifier).delete(editing);
    Navigator.pop(context);
  }

  void _editArticle() {
    setState(() {
      isEditing = true;
    });
  }

  void _cancelEdit() {
    setState(() {
      // 保存されている状態に戻して編集を終了
      editing = saved;
      isEditing = false;
    });
  }

  void _saveArticle() {
    setState(() {
      ref.read(articleRepositoryProvider.notifier).save(editing);
      saved = editing;
      isEditing = false;
    });
  }

  Widget _createViewBody() {
    var items = <Widget>[];
    items.add(Center(
        child: Text(widget._item.name, style: const TextStyle(fontSize: 30))));

    items.add(ArticleImage(widget._item.photos[0]));

    var category = _getCategory();
    if (category != null) {
      items.add(Center(child: CategoryLabel(category)));
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
        child: ArticleNameInput(
      initialValue: widget._item.name,
      onChanged: (text) {
        editing.name = text;
      },
    )));

    items.add(ArticleImage(widget._item.photos[0]));

    var category = _getCategory();
    items.add(CategorySelector(
      category,
      onChanged: (category) {
        editing.categoryId = category.id;
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
