import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/components/article/article_image.dart';
import 'package:mtoybox/modules/domain/model/article/article.dart';
import 'package:mtoybox/modules/interface/provider_factory.dart';

class ArticleIcon extends ConsumerWidget {
  final Article item;
  final void Function()? _onTap;

  const ArticleIcon(this.item, {Key? key, void Function()? onTap})
      : _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var categoryId = item.categoryId;
    return _wrapByGestureDetectorIfNecessary(Container(
        decoration: BoxDecoration(
          color: categoryId != null
              ? ref
                  .watch(categoryRepositoryProvider)
                  .findById(categoryId)
                  ?.color
              : null,
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            ArticleImage(item.photos[0]),
            Container(
              margin: const EdgeInsets.only(top: 0, bottom: 5),
              child: Text(
                item.name,
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            )
          ],
        )));
  }

  Widget _wrapByGestureDetectorIfNecessary(Container container) {
    if (_onTap == null) {
      return container;
    } else {
      return GestureDetector(
        onTap: _onTap,
        child: container,
      );
    }
  }
}
