import 'package:flutter/material.dart';

class CategoryNameInput extends StatelessWidget {
  final void Function(String text)? onChanged;
  final String initialValue;
  const CategoryNameInput({super.key, this.onChanged, this.initialValue = ""});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: 15,
      initialValue: initialValue,
      style: const TextStyle(
        fontSize: 30,
      ),
      decoration: const InputDecoration(
          icon: Icon(Icons.app_registration_sharp), labelText: 'できごと・なかま'),
      onChanged: onChanged,
    );
  }
}
