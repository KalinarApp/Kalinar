import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common_widgets/no_animation_single_child_scrollview.dart';
import '../../../constants/app_sizes.dart';
import '../../../utils/http/async_value_extension.dart';
import 'join_group_controller.dart';

class JoinGroupDialog extends HookConsumerWidget {
  const JoinGroupDialog({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useTextEditingController();
    final state = ref.watch(joinGroupControllerProvider);

    ref.listen(joinGroupControllerProvider, (previous, state) {
      if (state == previous) return;
      state.showNotification(context, successMessage: AppLocalizations.of(context)!.groupJoinedMessage);
    });

    onSubmit(groupId) async {
      final success = await ref.read(joinGroupControllerProvider.notifier).join(groupId: groupId);
      if (success && context.mounted) context.pop();
    }

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
                gapH32,
                FittedBox(child: Text(AppLocalizations.of(context)!.groupJoinTitle, style: Theme.of(context).textTheme.headlineMedium)),
                gapH24,
                Text(AppLocalizations.of(context)!.groupJoinText),
                gapH8,
                TextField(
                  controller: controller,
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.groupInvitationCode,
                    suffix: IconButton(
                      icon: const Icon(Icons.check),
                      onPressed: () => onSubmit(controller.text),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
