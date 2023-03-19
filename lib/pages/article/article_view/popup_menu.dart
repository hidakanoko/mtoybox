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
            child: Row(children: const [
              Icon(
                Icons.edit,
                color: Colors.blueAccent,
              ),
              Text('へんしゅう')
            ]),
          ),
          PopupMenuItem(
            onTap: onDeleteTapped,
            child: Row(children: const [
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
