import 'package:flutter/material.dart';
import 'package:mtoybox/components/category_item.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/interface/category_repository.dart';

class CategorySelector extends StatefulWidget {
  final Category? initial;
  final void Function(Category)? onChanged;
  const CategorySelector(this.initial, {super.key, this.onChanged});

  @override
  State<CategorySelector> createState() => _CategorySelectorState();
}

class _CategorySelectorState extends State<CategorySelector> {
  final CategoryRepository _repository = CategoryRepository.instance();
  Category? selected;

  @override
  Widget build(BuildContext context) {
    var categories = _repository.getAll().asList();
    return DropdownButton<Category>(
        value: selected ?? widget.initial,
        items: categories.map<DropdownMenuItem<Category>>((Category category) {
          return DropdownMenuItem<Category>(
              value: category, child: CategoryItem(category));
        }).toList(),
        onChanged: (Category? category) {
          setState(() {
            if (category != null) {
              selected = category;
            } else {
              selected = categories.first;
            }
          });
          Function? onChange = widget.onChanged;
          if (onChange != null) {
            onChange(category);
          }
        });
  }
}
