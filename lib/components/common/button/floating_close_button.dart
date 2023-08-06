import 'package:flutter/material.dart';

class FloatingCloseButton extends StatelessWidget {
  final void Function()? onPressed;
  const FloatingCloseButton({super.key, this.onPressed});
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      backgroundColor: Colors.grey.shade600,
      child: const Icon(Icons.close),
    );
  }
}
