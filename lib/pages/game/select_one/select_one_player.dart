import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectOnePlayer extends ConsumerStatefulWidget {
  const SelectOnePlayer({super.key, required void Function() finished});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _SelectOnePlayerState();
  }
}

class _SelectOnePlayerState extends ConsumerState<SelectOnePlayer> {
  @override
  Widget build(BuildContext context) {
    return Row();
  }
}
