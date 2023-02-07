import 'package:flutter/material.dart';
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
  CategoryGateway _categoryGateway = CategoryRepository.instance();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Category?>(
      builder: (context, snapshot) {
        return Scaffold(
          appBar: AppBar(
            title: Text(widget._item.name),
            backgroundColor: snapshot.hasData ? snapshot.data!.color : null,
          ),
        );
      },
      future: _findCategory(),
    );
  }

  Future<Category?> _findCategory() async {
    var categoryId = widget._item.categoryId;
    if (categoryId != null) {
      return await _categoryGateway.findById(categoryId);
    } else {
      return null;
    }
  }
}
