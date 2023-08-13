import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/components/article/article_image.dart';
import 'package:mtoybox/components/category/category_label.dart';
import 'package:mtoybox/modules/domain/model/article/article.dart';
import 'package:mtoybox/modules/domain/model/category/category_id.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/interface/provider_factory.dart';
import 'package:mtoybox/pages/article/article_edit.dart';
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
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    saved = widget._item;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isEditing
          ? AppBar(title: Text(saved.name), automaticallyImplyLeading: false)
          : AppBar(
              title: Text(saved.name),
              actions: [PopupMenu(_editArticle, _deleteArticle)],
            ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: isEditing ? _createEditBody() : _createViewBody()));
        },
      ),
    );
  }

  Category? _getCategory(CategoryId categoryId) {
    return ref.read(categoryRepositoryProvider).findById(categoryId);
  }

  void _deleteArticle() {
    ref.read(articleRepositoryProvider.notifier).delete(saved);
    Navigator.pop(context);
  }

  void _editArticle() {
    setState(() {
      isEditing = true;
    });
  }

  Widget _createViewBody() {
    var items = <Widget>[];
    items.add(Text(saved.name, style: const TextStyle(fontSize: 30)));

    if (saved.categoryId != null) {}

    var category =
        saved.categoryId != null ? _getCategory(saved.categoryId!) : null;
    if (category != null) {
      items.add(Center(child: CategoryLabel(category)));
    }

    items.add(Text(saved.description, style: const TextStyle(fontSize: 25)));

    items.add(SizedBox.square(child: ArticleImage(saved.photos[0])));

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items,
      ),
    );
  }

  Widget _createEditBody() {
    return ArticleEdit(
        article: saved,
        onSaved: (Article updated) {
          setState(() {
            isEditing = false;
            saved = updated;
          });
        },
        onClosed: () {
          setState(() {
            isEditing = false;
          });
        });
  }
}
