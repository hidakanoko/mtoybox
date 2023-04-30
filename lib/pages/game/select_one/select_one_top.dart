import 'package:flutter/material.dart';
import 'package:mtoybox/components/button/menu_button.dart';
import 'package:mtoybox/components/modal/alert_modal_factory.dart';
import 'package:mtoybox/pages/game/select_one/select_one_player.dart';

class SelectOneTop extends StatefulWidget {
  const SelectOneTop({super.key});

  @override
  State<SelectOneTop> createState() => _SelectOneTopState();
}

class _SelectOneTopState extends State<SelectOneTop> {
  bool playing = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('えらんであそぼう'),
        leading: playing ? createCancelGameButton() : createBackButton(),
      ),
      body: playing ? createPlayGameBody() : createStartGameBody(),
    );
  }

  Widget createStartGameBody() {
    return Center(
        child: MenuButton(
      onPressed: () {
        setState(() {
          playing = true;
        });
      },
      text: 'はじめる',
      icon: Icons.play_circle_outlined,
    ));
  }

  Widget createPlayGameBody() {
    return SelectOnePlayer(
      finished: () => playing = false,
    );
  }

  Widget createBackButton() {
    return BackButton(
      color: Colors.white,
      onPressed: () => Navigator.pop(context),
    );
  }

  Widget createCancelGameButton() {
    return GestureDetector(
      child: const Icon(
        Icons.cancel_outlined,
        color: Colors.white,
      ),
      onTap: () async {
        var confirm = await AlertModalFactory.show(
            context: context, title: 'かくにん', contents: 'ゲームをやめる？');
        if (confirm == true) {
          setState(() {
            playing = false;
          });
        }
      },
    );
  }
}
