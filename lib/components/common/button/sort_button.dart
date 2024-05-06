import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mtoybox/modules/interface/provider_factory.dart';

@immutable
class SortButton extends ConsumerWidget {
  const SortButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var sortOrder = ref.watch(articleListSortOrderProvider);
    return Transform.rotate(
      angle: sortOrder.isAsc ? 0 : 180 * math.pi / 180,
      child: IconButton(
          onPressed: () {
            ref.read(articleListSortOrderProvider.notifier).state =
                sortOrder.isAsc ? SortOrder.desc : SortOrder.asc;
          },
          icon: const Icon(
            Icons.sort,
            size: 40,
          )),
    );
  }
}
