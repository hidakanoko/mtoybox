import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/components/article/article_description_input.dart';
import 'package:mtoybox/components/article/article_image.dart';
import 'package:mtoybox/components/article/article_name_input.dart';
import 'package:mtoybox/components/category/category_selector.dart';
import 'package:mtoybox/components/common/button/cancel_button.dart';
import 'package:mtoybox/components/common/button/commit_button.dart';
import 'package:mtoybox/modules/domain/model/article/article.dart';
import 'package:mtoybox/modules/domain/model/category/category_id.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/interface/provider_factory.dart';

class ArticleEdit extends ConsumerStatefulWidget {
  final Article article;
  final Function onClosed;
  final Function(Article) onSaved;
  const ArticleEdit(
      {super.key,
      required this.article,
      required this.onSaved,
      required this.onClosed});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _ArticleEdit();
  }
}

class _ArticleEdit extends ConsumerState<ArticleEdit> {
  late final Article _editing;

  @override
  void initState() {
    super.initState();
    _editing = widget.article.clone();
  }

  @override
  Widget build(BuildContext context) {
    return _createEditBody();
  }

  Category? _getCategory(CategoryId? categoryId) {
    return categoryId != null
        ? ref.read(categoryRepositoryProvider).findById(categoryId)
        : null;
  }

  Widget _createEditBody() {
    var items = <Widget>[];
    items.add(ArticleNameInput(
      initialValue: widget.article.name,
      onChanged: (text) {
        _editing.name = text;
      },
    ));

    var category = _getCategory(_editing.categoryId);
    items.add(CategorySelector(
      category,
      onChanged: (category) {
        setState(() {
          _editing.categoryId = category.id;
        });
      },
    ));

    items.add(ArticleDescriptionInput(
      initialValue: widget.article.description,
      onChanged: (text) {
        _editing.description = text;
      },
    ));

    items.add(Padding(
        padding: const EdgeInsets.all(12),
        child: ArticleImage(widget.article.getPhoto())));

    items.add(Padding(
        padding: const EdgeInsets.fromLTRB(8, 24, 8, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CancelButton(
                onPressed: () {
                  widget.onClosed();
                },
                text: 'やめる'),
            CommitButton(
                onPressed: () {
                  _saveArticle();
                  widget.onSaved(_editing.clone());
                },
                text: 'ほぞん')
          ],
        )));

    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: items,
      ),
    );
  }

  void _saveArticle() {
    setState(() {
      ref.read(articleRepositoryProvider.notifier).save(_editing);
    });
  }
}
