import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/components/category/category_color_picker.dart';
import 'package:mtoybox/components/category/category_name_input.dart';
import 'package:mtoybox/components/common/button/commit_button.dart';
import 'package:mtoybox/modules/domain/model/category/category_id.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/interface/provider_factory.dart';

class CategoryCreate extends ConsumerStatefulWidget {
  const CategoryCreate({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryCreateState();
}

class _CategoryCreateState extends ConsumerState<CategoryCreate> {
  String? providedName;
  Color? providedColor;
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
      CategoryNameInput(
        onChanged: (String value) {
          setState(() {
            providedName = value;
          });
        },
      ),
      Center(
          child: CategoryColorPicker(
        onChanged: (color) {
          setState(() {
            providedColor = color;
          });
        },
        initialValue: providedColor ?? Colors.black,
      )),
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
    return providedName != null &&
        providedName!.isNotEmpty &&
        providedColor != null;
  }

  void register() {
    // // この時点でnullになることはあり得ない, 型調整のための記述
    String? name = providedName;
    if (name == null) {
      return;
    }

    Color? color = providedColor;
    if (color == null) {
      return;
    }

    var category = Category(CategoryId.generate(), name, color);

    ref.read(categoryRepositoryProvider.notifier).save(category);

    Navigator.pop(context, category);
  }
}
