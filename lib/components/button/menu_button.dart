import 'package:flutter/material.dart';

@immutable
class MenuButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;
  final IconData? icon;
  final Color? color;
  final Color? fontColor;

  const MenuButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.icon,
      this.color,
      this.fontColor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(20),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                backgroundColor: color ?? Colors.blue.shade500),
            child: createButtonBody(),
          )),
    );
  }

  Widget createButtonBody() {
    var widgets = <Widget>[];
    if (icon != null) {
      widgets.add(Padding(
          padding: const EdgeInsets.only(right: 5, top: 5),
          child: Icon(
            icon,
            color: fontColor ?? Colors.white,
          )));
    }
    widgets.add(Text(
      text,
      style: TextStyle(fontSize: 30, color: fontColor ?? Colors.white),
    ));
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widgets,
    );
  }
}
