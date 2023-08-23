import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kalinar/src/common_widgets/kalinar_form.dart';
import 'package:kalinar/src/common_widgets/no_animation_single_child_scrollview.dart';
import 'package:kalinar/src/utils/async_value_extension.dart';

import '../data/user_repository.dart';
import '../domain/user.dart';
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

    onSubmit(data) => ref.read(editUserDialogControllerProvider.notifier).submit(user: User("", data["username"], ""));

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.hardEdge,
      child: NoAnimationSingleChildScrollView(
        child: Container(
          width: min(500, MediaQuery.of(context).size.width * 0.8),
          height: min(600, MediaQuery.of(context).size.height * 0.9),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Theme.of(context).dialogBackgroundColor),
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
                const SizedBox(height: 50),
                FittedBox(child: Text(AppLocalizations.of(context)!.createUserTitle, style: Theme.of(context).textTheme.headlineMedium)),
                const SizedBox(height: 50),
                CircleAvatar(
                  radius: 60,
                  backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
                  child: Icon(Icons.person_4, size: 80, color: Theme.of(context).dialogBackgroundColor),
                ),
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
