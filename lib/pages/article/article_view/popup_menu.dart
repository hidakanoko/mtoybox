import 'package:flutter/material.dart';

class PopupMenu extends StatelessWidget {
  final void Function() onEditTapped;
  final void Function() onDeleteTapped;

  const PopupMenu(this.onEditTapped, this.onDeleteTapped, {super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) {
        return [
          PopupMenuItem(
            onTap: onEditTapped,
            child: const Row(children: [
              Icon(
                Icons.edit,
                color: Colors.blueAccent,
              ),
              Text('へんしゅう')
            ]),
          ),
          PopupMenuItem(
            onTap: onDeleteTapped,
            child: const Row(children: [
              Icon(
                Icons.delete_forever,
                color: Colors.red,
              ),
              Text('さくじょ')
            ]),
          )
        ];
      },
    );
  }
}
