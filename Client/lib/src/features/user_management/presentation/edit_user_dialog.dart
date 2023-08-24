import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kalinar/src/common_widgets/kalinar_form.dart';
import 'package:kalinar/src/common_widgets/no_animation_single_child_scrollview.dart';
import 'package:kalinar/src/utils/http/async_value_extension.dart';

import '../../../common_widgets/form_fields/invisible_field.dart';
import '../data/user_repository.dart';
import '../domain/user.dart';
import 'components/user_avatar.dart';
import 'edit_user_dialog_controller.dart';

class EditUserDialog extends ConsumerWidget {
  const EditUserDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(editUserDialogControllerProvider);

    ref.listen(editUserDialogControllerProvider, (previous, state) {
      if (state == previous) return;
      state.showNotification(context, successMessage: AppLocalizations.of(context)!.userCreated);
    });

    onSubmit(data) => ref.read(editUserDialogControllerProvider.notifier).submit(user: User.fromJson(data));

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.hardEdge,
      child: SizedBox(
        width: min(500, MediaQuery.of(context).size.width * 0.8),
        height: min(600, MediaQuery.of(context).size.height * 0.9),
        child: NoAnimationSingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60),
            child: KalinarForm(
              isLoading: state.isLoading,
              submit: onSubmit,
              onSuccess: () {
                ref.invalidate(getUserByIdProvider);
                ref.invalidate(getUserGroupsByIdProvider);
              },
              formFields: [
                const InvisibleField(name: "id", initialValue: ""),
                const SizedBox(height: 50),
                FittedBox(child: Text(AppLocalizations.of(context)!.userCreateTitle, style: Theme.of(context).textTheme.headlineMedium)),
                const SizedBox(height: 50),
                const UserAvatar(imageUrl: null, radius: 80),
                const SizedBox(height: 50),
                FormBuilderTextField(
                  name: 'username',
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
