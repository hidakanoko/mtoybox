import 'package:flutter/material.dart';
import 'package:mtoybox/components/category_item.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/interface/category_repository.dart';

class CategorySelector extends StatefulWidget {
  final Category? initial;
  final void Function(Category)? onChanged;
  const CategorySelector(this.initial, {super.key, this.onChanged});

  void getStates() {}

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final CategoryRepository repository;
  late final List<Category> items;
  Category? selected;

  _CategorySelectorState() : repository = CategoryRepository.instance();

  @override
  Widget build(BuildContext context) {
    return DropdownButton<Category>(
        value: selected ?? widget.initial ?? items.first,
        items: items.map<DropdownMenuItem<Category>>((Category category) {
          return DropdownMenuItem<Category>(
              value: category, child: CategoryItem(category));
        }).toList(),
        onChanged: (Category? category) {
          setState(() {
            if (category != null) {
              selected = category;
            } else {
              selected = items.first;
            }
          });
          Function? onChange = widget.onChanged;
          if (onChange != null) {
            onChange(category);
          }
        });
  }
}
