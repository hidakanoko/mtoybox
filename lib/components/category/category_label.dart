import 'package:flutter/material.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';

class CategoryLabel extends StatelessWidget {
  final Category _category;
  final int usageCount;
  const CategoryLabel(this._category, {super.key, this.usageCount = -1});

  @override
  Widget build(BuildContext context) {
    var children = [
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
    ];
    if (usageCount >= 0) {
      children.add(Text(
        " ($usageCount)",
        style: const TextStyle(fontSize: 22, color: Colors.grey),
      ));
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: children,
    );
  }
}
