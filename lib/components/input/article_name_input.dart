import 'package:flutter/material.dart';

class ArticleNameInput extends StatelessWidget {
  final void Function(String text)? onChanged;
  final String initialValue;
  const ArticleNameInput({super.key, this.onChanged, this.initialValue = ""});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 30,
      initialValue: initialValue,
      style: const TextStyle(
        fontSize: 30,
      ),
      decoration: const InputDecoration(
          icon: Icon(Icons.app_registration_sharp), labelText: 'なまえ'),
      onChanged: onChanged,
    );
  }
}
