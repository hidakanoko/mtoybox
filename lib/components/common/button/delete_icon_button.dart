import 'package:flutter/material.dart';

class DeleteIconButton extends StatelessWidget {
  final void Function() onPress;
  final bool disabled;
  const DeleteIconButton(this.onPress, {super.key, this.disabled = false});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: disabled ? null : onPress,
      icon: const Icon(Icons.delete_forever),
      iconSize: 40,
    );
  }
}
