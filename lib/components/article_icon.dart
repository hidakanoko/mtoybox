import 'package:flutter/material.dart';
import 'package:mtoybox/components/article_image.dart';
import 'package:mtoybox/modules/domain/gateway/category_gateway.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/interface/category_repository.dart';

class ArticleIcon extends StatelessWidget {
  final Item item;
  final CategoryGateway categoryGateway = CategoryRepository.instance();

  ArticleIcon(this.item, {Key? key}) : super(key: key);

  Future<Category?> findCategory() async {
    var categoryId = item.categoryId;
    if (categoryId != null) {
      return (await categoryGateway.getAll()).findById(categoryId);
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: findCategory(),
        builder: (context, snapshot) {
          return Container(
              decoration: BoxDecoration(
                color: snapshot.hasData ? snapshot.data?.color : null,
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
                      style: const TextStyle(
                          fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ));
        });
  }
}
