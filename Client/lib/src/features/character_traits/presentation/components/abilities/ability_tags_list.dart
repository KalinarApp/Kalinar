import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../common_widgets/spinner.dart';
import '../../../../../utils/build_context_extensions.dart';
import '../../../data/ability_repository.dart';

class AbilityTagsList extends ConsumerWidget {
  final String abilityId;

  const AbilityTagsList({super.key, required this.abilityId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tags = ref.watch(listAbilityTagsByAbilityIdProvider(abilityId));

    return tags.maybeWhen(
      data: (tags) => Flexible(
        child: Text(
          tags.join(", "),
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.bodySmall!.copyWith(color: context.colorScheme.primary.withOpacity(.8)),
        ),
      ),
      orElse: () => const Spinner(size: 10),
    );
  }
}
