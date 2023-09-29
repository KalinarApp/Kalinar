import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../common_widgets/async_container.dart';
import '../../../../user_management/data/user_repository.dart';
import '../../../data/ability_repository.dart';
import 'abilities_grid.dart';

class AbilitiesTab extends ConsumerWidget {
  static const String name = 'Abilities';
  static const String path = '/traits/abilities';

  const AbilitiesTab({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupId = ref.watch(getSelectedGroupProvider);

    return AsyncContainer(
      value: groupId,
      data: (data) {
        if (null == data) return Container();
        final abilities = ref.watch(listAbilitiesProvider(data.group.id));
        return AbilitiesGrid(abilities: abilities);
      },
    );
  }
}
