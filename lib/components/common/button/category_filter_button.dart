import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/components/category/category_label.dart';
import 'package:mtoybox/modules/interface/provider_factory.dart';

@immutable
class CategoryFilterButton extends ConsumerWidget {
  const CategoryFilterButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var category = ref.watch(categoryFilterProvider);

    return category != null
        ? IconButton(
            onPressed: () => {openSelectCategory(context, ref)},
            icon: const Icon(
              Icons.filter_alt,
              size: 40,
            ),
            color: category.color)
        : IconButton(
            onPressed: () => {openSelectCategory(context, ref)},
            icon: const Icon(
              Icons.filter_alt_off,
              size: 40,
            ),
            color: Colors.grey,
          );
  }

  void openSelectCategory(BuildContext context, WidgetRef ref) {
    var categories = ref.watch(categoryRepositoryProvider);
    final articles = ref.watch(articleRepositoryProvider);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            backgroundColor: Colors.white,
            shape: const RoundedRectangleBorder(),
            contentPadding: const EdgeInsets.all(0),
            children: [
              ElevatedButton(
                onPressed: () {
                  ref.read(categoryFilterProvider.notifier).state = null;
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                    shape: const RoundedRectangleBorder(),
                    backgroundColor: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      width: 30,
                      height: 30,
                      margin: const EdgeInsets.all(10),
                    ),
                    const Text(
                      'ぜんぶ',
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ),
              ...categories.asList().map((c) {
                final usageCount = articles
                    .where((element) => element.categoryId == c.id)
                    .length;

                return ElevatedButton(
                    onPressed: () {
                      ref.read(categoryFilterProvider.notifier).state = c;
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 24),
                        shape: const RoundedRectangleBorder(),
                        backgroundColor: Colors.white),
                    child: CategoryLabel(
                      c,
                      usageCount: usageCount,
                    ));
              }).toList()
            ],
          );
        });
  }
}
