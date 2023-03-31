import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/interface/provider_factory.dart';

class ArticleAppBar extends ConsumerWidget {
  final Item _item;
  const ArticleAppBar(this._item, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var categoryId = _item.categoryId;
    return AppBar(
      title: Text(_item.name),
      backgroundColor: categoryId != null
          ? ref.watch(categoryRepositoryProvider).findById(categoryId)?.color
          : null,
    );
  }
}
