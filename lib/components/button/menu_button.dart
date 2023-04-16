import 'package:flutter/material.dart';

@immutable
class MenuButton extends StatelessWidget {
  final void Function() onPressed;
  final String text;

  const MenuButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.all(20),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              backgroundColor: Colors.blue.shade500),
          child: Text(
            text,
            style: const TextStyle(fontSize: 30),
          ),
        ),
      ),
    );
  }
}
