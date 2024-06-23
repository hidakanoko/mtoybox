import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class CategoryColorPicker extends StatelessWidget {
  final void Function(Color color) onChanged;
  final Color initialValue;
  final availableColors = const [
    Colors.black,
    Colors.blue,
    Colors.amber,
    Colors.brown,
    Colors.green,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.red,
    Colors.yellow,
    Colors.cyan,
    Colors.grey,
    Colors.indigo,
    Colors.teal,
    Colors.deepOrange,
    Colors.lightBlue,
    Colors.lime,
    Colors.lightGreen,
    Colors.blueGrey,
  ];

  final int _portraitCrossAxisCount = 4;
  final int _landscapeCrossAxisCount = 5;

  const CategoryColorPicker(
      {super.key, required this.onChanged, this.initialValue = Colors.black});

  @override
  Widget build(BuildContext context) {
    return BlockPicker(
      pickerColor: initialValue,
      onColorChanged: onChanged,
      useInShowDialog: false,
      availableColors: availableColors,
      layoutBuilder: pickerLayoutBuilder,
    );
  }

  Widget pickerLayoutBuilder(
      BuildContext context, List<Color> colors, PickerItem child) {
    Orientation orientation = MediaQuery.of(context).orientation;

    return SizedBox(
      width: 300,
      height: orientation == Orientation.portrait ? 390 : 260,
      child: GridView.count(
        crossAxisCount: orientation == Orientation.portrait
            ? _portraitCrossAxisCount
            : _landscapeCrossAxisCount,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        children: [for (Color color in colors) child(color)],
      ),
    );
  }
}
