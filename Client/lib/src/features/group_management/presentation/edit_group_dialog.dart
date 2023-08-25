import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../common_widgets/form_fields/invisible_field.dart';
import '../../../common_widgets/kalinar_form.dart';
import '../../../common_widgets/no_animation_single_child_scrollview.dart';
import '../../../constants/app_sizes.dart';
import '../../../utils/http/async_value_extension.dart';
import '../../user_management/data/user_repository.dart';
import '../domain/group.dart';
import 'edit_group_controller.dart';

class EditGroupDialog extends ConsumerWidget {
  final Group? group;

  const EditGroupDialog({super.key, this.group});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(editGroupControllerProvider);

    ref.listen(editGroupControllerProvider, (previous, state) {
      if (state == previous) return;
      state.showNotification(context, successMessage: AppLocalizations.of(context)!.groupCreated);
    });

    onSubmit(data) => ref.read(editGroupControllerProvider.notifier).submit(group: Group.fromJson(data));

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
              willPopOnEdit: false,
              onSuccess: () {
                ref.invalidate(getUserGroupsByIdProvider);
              },
              formFields: [
                InvisibleField(name: "id", initialValue: group?.id ?? ""),
                gapH32,
                FittedBox(child: Text(AppLocalizations.of(context)!.groupCreateTitle, style: Theme.of(context).textTheme.headlineMedium)),
                gapH24,
                FormBuilderTextField(
                  name: 'name',
                  validator: FormBuilderValidators.required(),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.groupName),
                  scrollPadding: const EdgeInsets.only(bottom: 150),
                ),
                gapH20,
                FormBuilderTextField(
                  name: 'description',
                  maxLength: 2048,
                  minLines: 3,
                  maxLines: 10,
                  textInputAction: TextInputAction.go,
                  decoration: InputDecoration(labelText: AppLocalizations.of(context)!.groupDescription, hintMaxLines: 2048),
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
