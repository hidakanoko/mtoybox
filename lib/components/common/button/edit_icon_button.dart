import 'package:flutter/material.dart';

class EditIconButton extends StatelessWidget {
  final void Function() onPress;
  const EditIconButton(this.onPress, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPress,
      icon: const Icon(Icons.edit),
      iconSize: 40,
    );
  }
}
