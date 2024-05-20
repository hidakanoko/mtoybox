import 'package:flutter/material.dart';

class DeleteIconButton extends StatelessWidget {
  final void Function() onPress;
  const DeleteIconButton(this.onPress, {super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPress,
      icon: const Icon(Icons.delete_forever),
      iconSize: 40,
    );
  }
}
