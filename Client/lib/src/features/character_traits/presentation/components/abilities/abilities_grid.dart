import 'package:collection/collection.dart';
import 'package:diacritic/diacritic.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../common_widgets/async_grid.dart';
import '../../../../../constants/app_sizes.dart';
import '../../../application/search_controller.dart';
import '../../../domain/ability.dart';
import 'ability_grid_item.dart';

class AbilitiesGrid extends ConsumerWidget {
  final AsyncValue<List<Ability>> abilities;

  const AbilitiesGrid({super.key, required this.abilities});

  List<Ability> _filter(List<Ability> data, String query) {
    return data.where((item) {
      return item.name.toLowerCase().contains(query.toLowerCase()) || (item.description?.toLowerCase().contains(query.toLowerCase()) ?? false);
    }).toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchControllerProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final crossAxisCount = constraints.maxWidth ~/ 200;

        return AsyncGrid<Ability>(
          abilities,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount < 1 ? 1 : crossAxisCount,
            childAspectRatio: .8,
            crossAxisSpacing: Sizes.p24,
            mainAxisSpacing: Sizes.p24,
          ),
          builder: (item) => AbilityGridItem(item: item),
          refreshList: () async {},
          filter: (data) => _filter(data, searchQuery),
          sort: (data) => data.sortedBy((element) => removeDiacritics(element.name.toLowerCase())),
        );
      },
    );
  }
}
