import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common_widgets/form_fields/dropable_image_picker.dart';
import '../../../common_widgets/form_fields/invisible_field.dart';
import '../../../common_widgets/kalinar_form.dart';
import '../../../common_widgets/no_animation_single_child_scrollview.dart';
import '../../../constants/app_sizes.dart';
import '../../../utils/http/async_value_extension.dart';
import '../data/user_repository.dart';
import '../domain/user.dart';
import 'components/user_avatar.dart';
import 'edit_user_dialog_controller.dart';

class EditUserDialog extends ConsumerWidget {
  final User? user;

  const EditUserDialog({super.key, this.user});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(editUserDialogControllerProvider);

    ref.listen(editUserDialogControllerProvider, (previous, state) {
      if (state == previous) return;
      state.showNotification(
        context,
        successMessage: user == null ? AppLocalizations.of(context)!.userCreated : AppLocalizations.of(context)!.userUpdated,
      );
    });

    onSubmit(data) => ref.read(editUserDialogControllerProvider.notifier).submit(userId: user?.id, user: User.fromJson(data));

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: min(500, MediaQuery.of(context).size.width * 0.8),
        height: min(600, MediaQuery.of(context).size.height * 0.9),
        child: NoAnimationSingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: Sizes.p20, horizontal: Sizes.p64),
            child: KalinarForm(
              isLoading: state.isLoading,
              submit: onSubmit,
              onSuccess: () {
                ref.invalidate(getUserByIdProvider);
                ref.invalidate(getUserGroupsByIdProvider);
              },
              formFields: [
                InvisibleField(name: "id", initialValue: user?.id ?? ""),
                gapH32,
                if (user == null)
                  FittedBox(child: Text(AppLocalizations.of(context)!.userCreateTitle, style: Theme.of(context).textTheme.headlineMedium)),
                if (user != null)
                  FittedBox(child: Text(AppLocalizations.of(context)!.userEditTitle, style: Theme.of(context).textTheme.headlineMedium)),
                gapH24,
                DropableImagePicker(
                  name: "imageUrl",
                  initialValue: user?.imageUrl,
                  builder: (imageUrl, isLoading) => UserAvatar(imageUrl: imageUrl, radius: Sizes.p76),
                ),
                gapH48,
                FormBuilderTextField(
                  name: 'username',
                  initialValue: user?.username,
                  validator: FormBuilderValidators.required(),
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.username),
                  scrollPadding: const EdgeInsets.only(bottom: 150),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
