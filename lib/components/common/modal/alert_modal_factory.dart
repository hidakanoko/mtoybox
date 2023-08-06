import 'package:flutter/material.dart';

class AlertModalFactory {
  static Future<bool?> show({
    required BuildContext context,
    String? title,
    required String contents,
  }) {
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: title != null ? Text(title) : null,
            content: Text(contents),
            actions: <Widget>[
              TextButton(
                child: const Text('いいえ'),
                onPressed: () => Navigator.pop(context, false),
              ),
              TextButton(
                child: const Text('はい'),
                onPressed: () => Navigator.pop(context, true),
              ),
            ],
          );
        });
  }
}
