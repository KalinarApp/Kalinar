import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../../../common_widgets/form_fields/bool_field.dart';
import '../../../../../../common_widgets/form_fields/content_field.dart';
import '../../../../../../common_widgets/form_fields/value_range_field.dart';
import '../../../../../../common_widgets/save_button.dart';
import '../../../../../../utilities/async_value_extension.dart';
import '../../../application/skilltree_controller.dart';
import '../builder/character_selection_field.dart';

class SkilltreeModal extends ConsumerStatefulWidget {
  const SkilltreeModal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SkilltreeModalState();
}

class _SkilltreeModalState extends ConsumerState<SkilltreeModal> {
  static final _formKey = GlobalKey<FormBuilderState>();
  final RoundedLoadingButtonController controller = RoundedLoadingButtonController();

  bool hasCharacter = false;

  Future<void> _save(BuildContext context, String? id) async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final data = _formKey.currentState?.value;
      if (null != data) {
        final value = null == id
            ? await ref.read(skilltreeControllerProvider.notifier).createOnServer(data)
            : await ref.read(skilltreeControllerProvider.notifier).updateSkilltree(id, data);
        if (!mounted) return;
        value.showSnackbarOnError(context);
        if (value.hasError) {
          controller.error();
          Future.delayed(const Duration(seconds: 3), controller.reset);
        } else {
          controller.success();
          Navigator.of(context).pop(true);
        }
      } else {
        controller.error();
        Future.delayed(const Duration(seconds: 3), controller.reset);
      }
    } else {
      controller.error();
      Future.delayed(const Duration(seconds: 3), controller.reset);
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(skilltreeControllerProvider);

    return Container(
      constraints: const BoxConstraints(minHeight: 200),
      color: Theme.of(context).dialogBackgroundColor,
      child: Padding(
        padding: EdgeInsets.only(left: 12, right: 12, bottom: MediaQuery.of(context).viewInsets.bottom + 12.0),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                actions: [
                  SaveButton(controller: controller, onSave: () => _save(context, state.id)),
                ],
              ),
              const SizedBox(height: 10),
              ContentField(
                "name",
                label: AppLocalizations.of(context)!.skilltreeName,
                validators: FormBuilderValidators.required(),
                initialValue: state.skilltree.name,
              ),
              CharacterSelectionField(initialValue: state.skilltree.character, onChanged: ((value) => setState(() => hasCharacter = null != value))),
              const SizedBox(height: 10),
              ValueRangeField(
                name: "points",
                label: AppLocalizations.of(context)!.skilltreePoints,
                initialValue: state.skilltree.points.toDouble(),
                min: 0,
                max: 10000,
                step: 1,
                valueTransform: (value) => value?.round() ?? 0,
              ),
              if (hasCharacter || null != state.skilltree.character)
                BoolField(
                  name: "isActiveTree",
                  label: AppLocalizations.of(context)!.skilltreeIsActive,
                  initialValue: state.skilltree.isActiveTree,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
