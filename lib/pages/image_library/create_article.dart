import 'package:flutter/material.dart';
import 'package:mtoybox/components/article_image.dart';
import 'package:mtoybox/components/atoms/camera_button.dart';
import 'package:mtoybox/components/category_selector.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';

class CreateArticle extends StatefulWidget {
  const CreateArticle({super.key});

  @override
  State<CreateArticle> createState() => _CreateArticleState();
}

class _CreateArticleState extends State<CreateArticle> {
  String _name = "";
  Photo? selectedPhoto;
  Category selectedCategory = Category('やさい', Colors.green);

  @override
  Widget build(BuildContext context) {
    final widgets = [
      TextField(
        maxLength: 30,
        style: const TextStyle(
          fontSize: 20,
        ),
        decoration: const InputDecoration(
            icon: Icon(Icons.app_registration_sharp), labelText: 'なまえ'),
        onChanged: (String value) {
          setState(() {
            _name = value;
          });
        },
      ),
      CategorySelector(selectedCategory, onChanged: (Category category) {
        setState(() {
          selectedCategory = category;
        });
      }),
      Row(
        children: [
          CameraButton((Photo photo) {
            setState(() {
              this.selectedPhoto = photo;
            });
          }),
          IconButton(
            onPressed: () => {},
            icon: const Icon(Icons.photo),
          )
        ],
      )
    ];
    Photo? selectedPhoto = this.selectedPhoto;
    if (selectedPhoto != null) {
      widgets.add(
          AspectRatio(aspectRatio: 1.0, child: ArticleImage(selectedPhoto)));
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('ずかんのあたらしいこうもく'),
      ),
      body: Column(children: widgets),
    );
  }
}
