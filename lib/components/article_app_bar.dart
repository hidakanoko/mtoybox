import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/gateway/category_gateway.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/interface/category_repository.dart';

class ArticleAppBar extends StatelessWidget implements PreferredSizeWidget {
  final CategoryGateway _categoryGateway = CategoryRepository.instance();
  final Item _item;
  ArticleAppBar(this._item, {super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Category?>(
      builder: (context, snapshot) {
        return AppBar(
          title: Text(_item.name),
          backgroundColor: snapshot.hasData ? snapshot.data!.color : null,
        );
      },
      future: _findCategory(),
    );
  }

  Future<Category?> _findCategory() async {
    var categoryId = _item.categoryId;
    if (categoryId != null) {
      return await _categoryGateway.findById(categoryId);
    } else {
      return null;
    }
  }

  @override
  Size get preferredSize => throw Uni;
}
