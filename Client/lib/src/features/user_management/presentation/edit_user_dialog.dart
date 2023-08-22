import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kalinar/src/common_widgets/no_animation_single_child_scrollview.dart';
import 'package:kalinar/src/utils/async_value_extension.dart';

import '../data/user_repository.dart';
import '../domain/user.dart';
import 'edit_user_dialog_controller.dart';

class EditUserDialog extends ConsumerStatefulWidget {
  const EditUserDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends ConsumerState<EditUserDialog> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool _validateAndSaveForm() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      final user = User("", _formKey.currentState!.value["username"], "");
      final controller = ref.read(editUserDialogControllerProvider.notifier);
      final success = await controller.submit(user: user);
      if (success && mounted) {
        ref.invalidate(getUserByIdProvider);

        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(editUserDialogControllerProvider);

    ref.listen(editUserDialogControllerProvider, (previous, state) {
      if (state == previous) return;
      state.showNotification(context, successMessage: AppLocalizations.of(context)!.userCreated);
    });

    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      clipBehavior: Clip.hardEdge,
      child: NoAnimationSingleChildScrollView(
        child: Container(
          width: min(500, MediaQuery.of(context).size.width * 0.8),
          height: min(600, MediaQuery.of(context).size.height * 0.9),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Theme.of(context).dialogBackgroundColor),
          child: FormBuilder(
            key: _formKey,
            clearValueOnUnregister: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  FittedBox(child: Text("Benutzer anlegen", style: Theme.of(context).textTheme.headlineMedium)),
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
                    textInputAction: TextInputAction.done,
                    decoration: InputDecoration(labelText: AppLocalizations.of(context)!.username),
                    scrollPadding: const EdgeInsets.only(bottom: 150),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: state.isLoading ? null : _submit,
                      child: FittedBox(
                        child: state.isLoading
                            ? SpinKitFadingCube(size: 30, color: Theme.of(context).colorScheme.primary)
                            : Text(AppLocalizations.of(context)!.save, style: Theme.of(context).textTheme.titleLarge),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
