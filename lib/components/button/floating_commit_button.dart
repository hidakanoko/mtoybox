import 'package:flutter/material.dart';

class FloatingCommitButton extends StatelessWidget {
  final void Function()? onPressed;
  const FloatingCommitButton({super.key, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.blueAccent,
      child: const Icon(Icons.done),
    );
  }
}
