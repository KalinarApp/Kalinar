import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kalinar/src/common_widgets/form_fields/dropable_image_picker.dart';
import 'package:kalinar/src/common_widgets/no_animation_single_child_scrollview.dart';
import 'package:kalinar/src/features/user_management/data/user_repository.dart';
import 'package:kalinar/src/features/user_management/presentation/components/username_edit_widget.dart';

import '../../../utils/http/async_value_extension.dart';
import 'components/user_avatar.dart';
import 'edit_user_dialog_controller.dart';

class UserProfileDialog extends ConsumerWidget {
  const UserProfileDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(getUserByIdProvider);
    final state = ref.watch(editUserDialogControllerProvider);

    ref.listen(editUserDialogControllerProvider, (previous, state) {
      if (state == previous) return;
      state.showNotification(context, successMessage: AppLocalizations.of(context)!.userUpdated);
    });

    onSubmitUsername(String data) =>
        ref.read(editUserDialogControllerProvider.notifier).submit(userId: user.value!.id, user: user.value!.copyWith(username: data));

    onSubmitImage(String? imageUrl) =>
        ref.read(editUserDialogControllerProvider.notifier).submit(userId: user.value!.id, user: user.value!.copyWith(imageUrl: imageUrl));

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: min(500, MediaQuery.of(context).size.width * 0.8),
        height: min(600, MediaQuery.of(context).size.height * 0.9),
        child: NoAnimationSingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60),
            child: Column(
              children: [
                const SizedBox(height: 50),
                FittedBox(child: Text(AppLocalizations.of(context)!.userProfile, style: Theme.of(context).textTheme.headlineMedium)),
                const SizedBox(height: 50),
                DropableImagePicker(
                  name: "imageUrl",
                  initialValue: user.hasValue ? user.value!.imageUrl : null,
                  builder: (imageUrl, isLoading) => UserAvatar(imageUrl: imageUrl, radius: 80),
                  onChanged: onSubmitImage,
                ),
                const SizedBox(height: 50),
                UsernameEditWidget(
                  initialValue: user.hasValue ? user.value!.username : null,
                  isLoading: user.isLoading || state.isLoading,
                  onSubmit: onSubmitUsername,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
