import 'dart:math';

import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kalinar/src/common_widgets/loading_text.dart';
import 'package:kalinar/src/constants/app_sizes.dart';
import 'package:kalinar/src/features/character_traits/data/ability_repository.dart';
import 'package:kalinar/src/utils/build_context_extensions.dart';

import '../../../../../common_widgets/no_animation_single_child_scrollview.dart';

class AbilityDetailDialog extends ConsumerWidget {
  static const String name = 'AbilityDetails';
  static const String path = ':id';

  final String abilityId;

  const AbilityDetailDialog(this.abilityId, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final item = ref.watch(getAbilityByIdProvider(abilityId));

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: min(500, MediaQuery.of(context).size.width * 0.8),
        height: min(300, MediaQuery.of(context).size.height * 0.9),
        child: NoAnimationSingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60),
            child: Column(
              children: [
                FittedBox(child: LoadingText(Text(item.valueOrNull?.name ?? "", style: context.textTheme.headlineMedium), isLoading: item.isLoading)),
                gapH24,
                LoadingText(
                  Text(item.valueOrNull?.description ?? "", style: context.textTheme.bodyLarge),
                  isLoading: item.isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
