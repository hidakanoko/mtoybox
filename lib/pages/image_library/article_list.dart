import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mtoybox/components/article.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';

class ArticleList extends StatefulWidget {
  const ArticleList({super.key});

  @override
  State<ArticleList> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  final List<Article> _articles = [
    Article(Item(Photo('assets/images/fruits/apple1.png', isBuiltin: true),
        'りんご1', Colors.blue)),
    Article(Item(Photo('assets/images/fruits/apple2.png', isBuiltin: true),
        'りんご2', Colors.green)),
    Article(Item(Photo('assets/images/fruits/mikan1.png', isBuiltin: true),
        'みかん', Colors.red)),
    Article(Item(Photo('assets/images/fruits/watermelon1.png', isBuiltin: true),
        'めろん', Colors.purple)),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ずかん'),
      ),
      body: GridView.count(
        crossAxisCount: 3,
        children: _articles.toList(),
      ),
      floatingActionButton: buildButton(),
    );
  }

  FloatingActionButton buildButton() {
    return FloatingActionButton(
        onPressed: addArticle, child: const Icon(Icons.add));
  }

  addArticle() async {
    final picker = ImagePicker();
    final img = await picker.pickImage(source: ImageSource.camera);
    if (img == null) return;

    setState(() {
      _articles.add(Article(
          Item(Photo(img.path, isBuiltin: false), 'テスト', Colors.yellow)));
    });
  }
}
