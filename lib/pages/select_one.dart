import 'package:flutter/material.dart';
import 'package:mtoybox/components/article.dart';
import 'package:mtoybox/modules/domain/model/article/item.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';

class SelectOne extends StatefulWidget {
  const SelectOne({super.key});

  @override
  State<SelectOne> createState() => _SelectOneState();
}

class _SelectOneState extends State<SelectOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('えらんであそぼう'),
      ),
      body: Row(
        children: [
          Expanded(
              child: Article(Item(
                  Photo('assets/images/fruits/apple1.png', isBuiltin: true),
                  'りんご1',
                  Colors.red))),
          Expanded(
              child: Article(Item(
                  Photo('assets/images/fruits/apple2.png', isBuiltin: true),
                  'りんご2',
                  Colors.yellow))),
        ],
      ),
    );
  }
}
