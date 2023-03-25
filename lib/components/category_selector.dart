import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/components/category_item.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/interface/provider_factory.dart';

class CategorySelector extends ConsumerWidget {
  final Category? initial;
  final void Function(Category category)? onChanged;
  const CategorySelector(this.initial, {super.key, this.onChanged});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var categories = ref.watch(categoryProvider);
    return DropdownButton<Category>(
        value: initial,
        items: categories
            .asList()
            .map<DropdownMenuItem<Category>>((Category category) {
          return DropdownMenuItem<Category>(
              value: category, child: CategoryItem(category));
        }).toList(),
        onChanged: (Category? category) {
          var fn = onChanged;
          if (fn != null && category != null) {
            fn(category);
          }
        });
  }
}
