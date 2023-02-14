import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/gateway/category_gateway.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/interface/category_repository.dart';

class ArticleAppBar extends StatelessWidget {
  final CategoryGateway _categoryGateway = CategoryRepository.instance();
  final Item _item;
  ArticleAppBar(this._item, {super.key});

  @override
  Widget build(BuildContext context) {
    var categoryId = _item.categoryId;
    return AppBar(
      title: Text(_item.name),
      backgroundColor: categoryId != null
          ? _categoryGateway.findById(categoryId)?.color
          : null,
    );
  }
}
