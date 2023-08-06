import 'package:flutter/material.dart';
import 'package:mtoybox/components/common/photo_image_provider_factory.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';

class ArticleImage extends StatelessWidget {
  final Photo _photo;
  const ArticleImage(this._photo, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                    image: PhotoImageProviderFactory.create(_photo),
                    fit: BoxFit.contain),
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
              ),
              margin: const EdgeInsets.all(5),
            )));
  }
}