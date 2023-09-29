import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timeago_flutter/timeago_flutter.dart';

import '../../../../../constants/app_sizes.dart';
import '../../../../../utils/build_context_extensions.dart';
import '../../../../user_management/data/user_repository.dart';
import '../../../domain/ability.dart';
import '../suggestable_state_icon.dart';
import '../user_token.dart';
import 'ability_detail_dialog.dart';
import 'ability_tags_list.dart';
import 'passive_ability_icon.dart';

class AbilityGridItem extends ConsumerWidget {
  final Ability item;

  const AbilityGridItem({super.key, required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final creator = ref.watch(getUserByIdProvider(item.creatorId));

    return Card(
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      child: InkWell(
        onTap: () => context.goNamed(AbilityDetailDialog.name, pathParameters: {"id": item.id}),
        borderRadius: borderRadius,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Text(item.name, style: context.textTheme.titleSmall, maxLines: 2),
              gapH12,
              if (item.description != null)
                Expanded(
                  child: Text(
                    item.description!,
                    style: context.textTheme.bodySmall,
                    maxLines: 8,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              gapH4,
              Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AbilityTagsList(abilityId: item.id),
                      if (item.isPassive) const PassiveAbilityIcon(),
                    ],
                  ),
                  const Divider(),
                  Row(
                    children: [
                      UserToken(creator: creator.valueOrNull),
                      const Spacer(),
                      Timeago(builder: (context, value) => Text(value, maxLines: 1), date: item.modifiedAt ?? item.createdAt, locale: "en_short"),
                      gapW4,
                      SuggestableStateIcon(state: item.state),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
