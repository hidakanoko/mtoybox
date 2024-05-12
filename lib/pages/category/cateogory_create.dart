import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/components/article/article_name_input.dart';
import 'package:mtoybox/components/common/button/commit_button.dart';

class CategoryCreate extends ConsumerStatefulWidget {
  const CategoryCreate({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryCreateState();
}

class _CategoryCreateState extends ConsumerState<CategoryCreate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('あたらしい なかま・できごと'),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
                child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: createWidgets(),
                      ),
                    )));
          },
        ));
  }

  List<Widget> createWidgets() {
    final List<Widget> widgets = [
      TextFormField()
      // ArticleNameInput(
      //   onChanged: (String value) {
      //     setState(() {
      //       providedName = value;
      //     });
      //   },
      // ),
      // CategorySelector(selectedCategory, onChanged: (Category category) {
      //   setState(() {
      //     selectedCategory = category;
      //   });
      // }),
      // Row(
      //   children: [
      //     CameraButton((Photo photo) {
      //       setState(() {
      //         this.selectedPhoto = photo;
      //       });
      //     }),
      //     GalleryButton((photo) {
      //       setState(() {
      //         this.selectedPhoto = photo;
      //       });
      //     })
      //   ],
      // ),
      // ArticleDescriptionInput(
      //   onChanged: (String value) {
      //     setState(() {
      //       providedDescription = value;
      //     });
      //   },
      // ),
    ];

    widgets.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      CommitButton(
        onPressed: isFilled() ? register : null,
        text: '登録',
      )
    ]));
    return widgets;
  }

  bool isFilled() {
    // return providedName != null &&
    //     selectedPhoto != null &&
    //     selectedCategory != null;
    return true;
  }

  void register() {
    // // この時点でnullになることはあり得ない, 型調整のための記述
    // Photo? photo = selectedPhoto;
    // if (photo == null) {
    //   return;
    // }
    // String? name = providedName;
    // if (name == null) {
    //   return;
    // }

    // String description = providedDescription ?? "";

    // var newItem = Article(
    //     ArticleId.generate(), [photo], name, description, selectedCategory!.id);

    // ref.read(articleRepositoryProvider.notifier).save(newItem);

    // Navigator.pop(context, newItem);
    Navigator.pop(context);
  }
}
