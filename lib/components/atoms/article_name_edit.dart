import 'package:flutter/material.dart';

class ArticleNameEdit extends StatefulWidget {
  final void Function(String text)? onChanged;
  final String initialValue;
  const ArticleNameEdit({super.key, this.onChanged, this.initialValue = ""});

  @override
  State<StatefulWidget> createState() {
    return _ArticleTestState();
  }
}

class _ArticleTestState extends State<ArticleNameEdit> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 30,
      initialValue: widget.initialValue,
      style: const TextStyle(
        fontSize: 30,
      ),
      decoration: const InputDecoration(
          icon: Icon(Icons.app_registration_sharp), labelText: 'なまえ'),
      onChanged: (String value) {
        var onChanged = widget.onChanged;
        if (onChanged != null) {
          onChanged(value);
        }
      },
    );
  }
}