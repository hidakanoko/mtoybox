import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';

class CategoryItem extends StatelessWidget {
  final Category _category;
  const CategoryItem(this._category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          color: _category.color,
          width: 30,
          height: 30,
          margin: const EdgeInsets.all(10),
        ),
        Text(
          _category.name.value,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
