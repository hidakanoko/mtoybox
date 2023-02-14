import 'package:flutter/material.dart';
import 'package:mtoybox/components/article_image.dart';
import 'package:mtoybox/modules/domain/gateway/category_gateway.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/interface/category_repository.dart';

class ArticleIcon extends StatelessWidget {
  final Item item;
  final CategoryGateway _categoryGateway = CategoryRepository.instance();
  final void Function()? _onTap;

  ArticleIcon(this.item, {Key? key, void Function()? onTap})
      : _onTap = onTap,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    var categoryId = item.categoryId;
    return _wrapByGestureDetectorIfNecessary(Container(
        decoration: BoxDecoration(
          color: categoryId != null
              ? _categoryGateway.findById(categoryId)?.color
              : null,
          borderRadius: BorderRadius.circular(20.0),
        ),
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(5),
        child: Column(
          children: [
            ArticleImage(item.photo),
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
