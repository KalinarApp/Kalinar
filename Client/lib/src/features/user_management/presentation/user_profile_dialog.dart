import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kalinar/src/common_widgets/form_fields/dropable_image_picker.dart';
import 'package:kalinar/src/common_widgets/no_animation_single_child_scrollview.dart';

import '../../../constants/app_sizes.dart';
import '../../../constants/storage_key.dart';
import '../../../routing/app_route.dart';
import '../../../utils/http/async_value_extension.dart';
import '../../../utils/local_storage/shared_preferences_helper.dart';
import '../../group_management/domain/group_member.dart';
import '../../group_management/presentation/components/group_selection_dropdown.dart';
import '../data/user_repository.dart';
import 'components/user_avatar.dart';
import 'components/username_edit_widget.dart';
import 'edit_user_dialog_controller.dart';

class UserProfileDialog extends ConsumerWidget {
  const UserProfileDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(getUserByIdProvider);
    final state = ref.watch(editUserDialogControllerProvider);
    final groups = ref.watch(getUserGroupsByIdProvider);
    final selectedGroup = ref.watch(getSelectedGroupProvider);

    ref.listen(editUserDialogControllerProvider, (previous, state) {
      if (state == previous) return;
      state.showNotification(context, successMessage: AppLocalizations.of(context)!.userUpdated);
    });

    onSubmitUsername(String data) =>
        ref.read(editUserDialogControllerProvider.notifier).submit(userId: user.value!.id, user: user.value!.copyWith(username: data));

    onSubmitImage(String? imageUrl) =>
        ref.read(editUserDialogControllerProvider.notifier).submit(userId: user.value!.id, user: user.value!.copyWith(imageUrl: imageUrl));

    onSubmitGroup(GroupMember? group) {
      ref.read(getSharedPreferencesProvider).setString(StorageKey.defaultGroupId, group?.group.id);
      ref.invalidate(getUserGroupsByIdProvider);
    }

    return ClipRRect(
      borderRadius: borderRadius,
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: min(500, MediaQuery.of(context).size.width * 0.8),
        height: min(600, MediaQuery.of(context).size.height * 0.9),
        child: NoAnimationSingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.p20, horizontal: Sizes.p64),
            child: Column(
              children: [
                gapH32,
                FittedBox(child: Text(AppLocalizations.of(context)!.userProfile, style: Theme.of(context).textTheme.headlineMedium)),
                gapH24,
                DropableImagePicker(
                  name: "imageUrl",
                  initialValue: user.hasValue ? user.value!.imageUrl : null,
                  builder: (imageUrl, isLoading) => UserAvatar(imageUrl: imageUrl, radius: Sizes.p76),
                  onChanged: onSubmitImage,
                ),
                gapH48,
                UsernameEditWidget(
                  initialValue: user.hasValue ? user.value!.username : null,
                  isLoading: user.isLoading || state.isLoading,
                  onSubmit: onSubmitUsername,
                ),
                gapH32,
                FittedBox(child: Text(AppLocalizations.of(context)!.groupManagement, style: Theme.of(context).textTheme.headlineSmall)),
                gapH16,
                GroupSelectionDropdown(items: groups.valueOrNull ?? [], onChanged: onSubmitGroup, value: selectedGroup.valueOrNull),
                gapH12,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () => context.pushNamed(AppRoute.groupCreate.name),
                      child: Text(AppLocalizations.of(context)!.groupCreateAction),
                    ),
                    TextButton(
                      onPressed: () => context.pushNamed(AppRoute.groupJoin.name),
                      child: Text(AppLocalizations.of(context)!.groupJoinAction),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
