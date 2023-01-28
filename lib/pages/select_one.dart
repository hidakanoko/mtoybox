import 'package:flutter/material.dart';

class SelectOne extends StatefulWidget {
  const SelectOne({super.key});

  @override
  State<SelectOne> createState() => _SelectOneState();
}

class _SelectOneState extends State<SelectOne> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('えらんであそぼう'),
      ),
      body: Row(),
    );
  }
}
