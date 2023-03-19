import 'package:flutter/material.dart';

class FloatingEditButton extends StatelessWidget {
  final void Function()? onPressed;
  const FloatingEditButton({super.key, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.blueAccent,
      child: const Icon(Icons.edit_rounded),
    );
  }
}
