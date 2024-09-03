import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/components/article/article_image.dart';
import 'package:mtoybox/modules/domain/model/article/article.dart';
import 'package:mtoybox/modules/interface/provider_factory.dart';

class ArticleIcon extends ConsumerWidget {
  final Article item;
  final void Function()? _onTap;

  const ArticleIcon(this.item, {super.key, void Function()? onTap})
      : _onTap = onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var categoryId = item.categoryId;
    return _wrapByGestureDetectorIfNecessary(Column(
      children: [
        Expanded(
            child: Container(
                decoration: BoxDecoration(
                  color: categoryId != null
                      ? ref
                          .watch(categoryRepositoryProvider)
                          .findById(categoryId)
                          ?.color
                      : null,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                margin: const EdgeInsets.fromLTRB(10, 14, 10, 1),
                padding: const EdgeInsets.all(5),
                child: ArticleImage(item.photos[0]))),
        Text(
          item.name,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    ));
  }

  Widget _wrapByGestureDetectorIfNecessary(Widget container) {
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
