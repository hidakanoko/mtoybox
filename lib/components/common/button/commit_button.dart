import 'package:flutter/material.dart';

@immutable
class CommitButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  final Color? color;
  final Color? fontColor;

  const CommitButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.color,
      this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)),
            ),
            backgroundColor: color ?? Colors.green),
        child: createButtonBody(),
      ),
    );
  }

  Widget createButtonBody() {
    var widgets = <Widget>[];
    widgets.add(Padding(
        padding: const EdgeInsets.only(right: 5, top: 5),
        child: Icon(
          Icons.check,
          color: fontColor ?? Colors.white,
        )));
    widgets.add(Text(
      text,
      style: TextStyle(fontSize: 20, color: fontColor ?? Colors.white),
    ));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
  }
}
