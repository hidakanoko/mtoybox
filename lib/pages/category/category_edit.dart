import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/components/category/category_color_picker.dart';
import 'package:mtoybox/components/category/category_name_input.dart';
import 'package:mtoybox/components/common/button/commit_button.dart';
import 'package:mtoybox/modules/domain/model/category/catetory.dart';
import 'package:mtoybox/modules/interface/provider_factory.dart';

class CategoryEdit extends ConsumerStatefulWidget {
  final Category category;
  const CategoryEdit({super.key, required this.category});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CategoryEditState();
}

class _CategoryEditState extends ConsumerState<CategoryEdit> {
  String? providedName;
  Color? providedColor;

  @override
  void initState() {
    super.initState();
    providedName = widget.category.name;
    providedColor = widget.category.color;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('なかま・できごと のへんしゅう'),
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
        initialValue: widget.category.name,
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
        text: '保存',
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

    var category = Category(widget.category.id, name, color);

    ref.read(categoryRepositoryProvider.notifier).save(category);

    Navigator.pop(context, category);
  }
}
