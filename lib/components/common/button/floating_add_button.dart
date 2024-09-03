import 'package:flutter/material.dart';

class FloatingAddButton extends StatelessWidget {
  final void Function()? onPressed;
  const FloatingAddButton({super.key, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.blueAccent,
      foregroundColor: Colors.white,
      child: const Icon(Icons.add),
    );
  }
}
