import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';

class CategoryLabel extends StatelessWidget {
  final Category _category;
  const CategoryLabel(this._category, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          color: _category.color,
          width: 30,
          height: 30,
          margin: const EdgeInsets.all(10),
        ),
        Text(
          _category.name.toString(),
          style: const TextStyle(fontSize: 30),
        ),
      ],
    );
  }
}
