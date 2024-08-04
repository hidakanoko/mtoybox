import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/modules/interface/provider_factory.dart';

@immutable
class CategoryFilterButton extends ConsumerWidget {
  const CategoryFilterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var cateogry = ref.watch(categoryFilterProvider);

    return cateogry != null
        ? IconButton(
            onPressed: () => {openSelectCategory()},
            icon: const Icon(
              Icons.circle,
              size: 35,
            ),
            color: Colors.blue)
        : IconButton(
            onPressed: () => {openSelectCategory()},
            icon: const Icon(
              Icons.square,
              size: 35,
            ),
            color: Colors.red,
          );
  }

  void openSelectCategory() {}
  // Future<void> openSelectCategory(BuildContext context) {
  //   return showDialog(context: context, builder: (BuildContext context) => {
  //     return SimpleDialog(title: Text("test"),);
  //   });
  // }
}
