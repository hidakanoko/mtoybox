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
    var categoryFuture = ref.watch(categoryInitializerFutureProvider);
    AsyncValue? articleFuture;
    if (!categoryFuture.isLoading) {
      articleFuture = ref.watch(articleInitializerFutureProvider);
    }

    Widget mainWidget;
    if (categoryFuture.hasError ||
        (articleFuture != null && articleFuture.hasError)) {
      mainWidget = const Text('error occur while loading');
    } else if (articleFuture == null || articleFuture.isLoading) {
      mainWidget = const CircularProgressIndicator();
    } else {
      mainWidget = MaterialApp(
        title: 'まどかのおもちゃ箱',
        theme: ThemeData.from(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigoAccent),
            textTheme: Typography.material2021().black),
        home: const Menu(),
      );
    }

    return mainWidget;
  }
}
