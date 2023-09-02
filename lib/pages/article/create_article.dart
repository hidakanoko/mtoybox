import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/components/article/article_image.dart';
import 'package:mtoybox/components/common/button/camera_button.dart';
import 'package:mtoybox/components/category/category_selector.dart';
import 'package:mtoybox/components/article/article_description_input.dart';
import 'package:mtoybox/components/article/article_name_input.dart';
import 'package:mtoybox/components/common/button/commit_button.dart';
import 'package:mtoybox/components/common/button/gallery_button.dart';
import 'package:mtoybox/modules/domain/model/article/article.dart';
import 'package:mtoybox/modules/domain/model/article/article_id.dart';
import 'package:mtoybox/modules/domain/model/article/photo.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/interface/provider_factory.dart';

class CreateArticle extends ConsumerStatefulWidget {
  const CreateArticle({super.key});

  @override
  ConsumerState<CreateArticle> createState() => _CreateArticleState();
}

class _CreateArticleState extends ConsumerState<CreateArticle> {
  String? providedName;
  String? providedDescription;
  Photo? selectedPhoto;
  Category? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('ずかんのあたらしいこうもく'),
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
    final widgets = [
      ArticleNameInput(
        onChanged: (String value) {
          setState(() {
            providedName = value;
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
          GalleryButton((photo) {
            setState(() {
              this.selectedPhoto = photo;
            });
          })
        ],
      ),
      ArticleDescriptionInput(
        onChanged: (String value) {
          setState(() {
            providedDescription = value;
          });
        },
      ),
    ];
    Photo? selectedPhoto = this.selectedPhoto;
    if (selectedPhoto != null) {
      widgets.add(ArticleImage(selectedPhoto));
    }

    widgets.add(Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      CommitButton(
        onPressed: isFilled() ? register : null,
        text: '登録',
      )
    ]));
    return widgets;
  }

  bool isFilled() {
    return providedName != null &&
        selectedPhoto != null &&
        selectedCategory != null;
  }

  void register() {
    // この時点でnullになることはあり得ない, 型調整のための記述
    Photo? photo = selectedPhoto;
    if (photo == null) {
      return;
    }
    String? name = providedName;
    if (name == null) {
      return;
    }

    String description = providedDescription ?? "";

    var newItem = Article(
        ArticleId.generate(), [photo], name, description, selectedCategory!.id);

    ref.read(articleRepositoryProvider.notifier).save(newItem);

    Navigator.pop(context, newItem);
  }
}
