import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/modules/interface/provider_factory.dart';
import 'package:mtoybox/pages/menu.dart';

void main() async {
  runApp(const ProviderScope(child: Main()));
}

class Main extends ConsumerWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.read(categoryProvider.notifier).initialize();
    ref.read(articleProvider.notifier).initialize();

    return MaterialApp(
      title: 'まどかのおもちゃ箱',
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
          textTheme: Typography.material2021().black),
      home: const Menu(),
    );
  }
}
