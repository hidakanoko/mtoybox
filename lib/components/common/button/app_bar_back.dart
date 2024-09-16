import 'package:flutter/material.dart';

class AppBarBack extends StatelessWidget {
  const AppBarBack({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.blue),
      iconSize: 45,
      onPressed: () => Navigator.of(context).pop(),
    );
  }
}
