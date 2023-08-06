import 'package:flutter/material.dart';

class ArticleDescriptionInput extends StatelessWidget {
  final void Function(String text)? onChanged;
  final String initialValue;
  const ArticleDescriptionInput(
      {super.key, this.onChanged, this.initialValue = ""});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 200,
      initialValue: initialValue,
      keyboardType: TextInputType.multiline,
      maxLines: 2,
      style: const TextStyle(
        fontSize: 25,
      ),
      decoration: const InputDecoration(
          icon: Icon(Icons.app_registration_sharp), labelText: 'せつめい'),
      onChanged: onChanged,
    );
  }
}
