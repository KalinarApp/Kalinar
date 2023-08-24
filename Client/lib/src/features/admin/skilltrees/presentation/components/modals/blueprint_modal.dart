import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../../../common_widgets/form_fields/content_field.dart';
import '../../../../../../common_widgets/save_button.dart';
import '../../../../../../utils/http/async_value_extension.dart';
import '../../../application/skilltree_controller.dart';

class BlueprintModal extends ConsumerStatefulWidget {
  const BlueprintModal({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BlueprintModalState();
}

class _BlueprintModalState extends ConsumerState<BlueprintModal> {
  static final _formKey = GlobalKey<FormBuilderState>();
  final RoundedLoadingButtonController controller = RoundedLoadingButtonController();

  Future<void> _save(BuildContext context, String? id, bool isBlueprint) async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final data = _formKey.currentState?.value;
      if (null != data) {
        final value = null == id || !isBlueprint
            ? await ref.read(skilltreeControllerProvider.notifier).createBlueprint(data)
            : await ref.read(skilltreeControllerProvider.notifier).updateBlueprint(id, data);
        if (!mounted) return;
        value.showNotification(context);
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
                  SaveButton(controller: controller, onSave: () => _save(context, state.id, state.isBlueprint)),
                ],
              ),
              ContentField(
                "name",
                label: AppLocalizations.of(context)!.blueprintName,
                validators: FormBuilderValidators.required(),
                initialValue: state.skilltree.name,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
