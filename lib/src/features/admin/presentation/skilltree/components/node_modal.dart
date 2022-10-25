import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hero/src/common_widgets/form_fields/bool_field.dart';
import 'package:hero/src/common_widgets/form_fields/value_range_field.dart';
import 'package:hero/src/features/admin/presentation/skilltree/components/skill_selection_field.dart';
import 'package:hero/src/features/admin/application/skilltree_controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../../common_widgets/save_button.dart';

class NodeModal extends ConsumerWidget {
  static const routeName = "groups/create";
  static final _formKey = GlobalKey<FormBuilderState>();

  final RoundedLoadingButtonController controller = RoundedLoadingButtonController();

  NodeModal({Key? key}) : super(key: key);

  Future<void> _save(WidgetRef ref, BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final data = _formKey.currentState?.value;
      if (null != data) {
        ref.read(skilltreeControllerProvider.notifier).addNode(data);
        Navigator.pop(context);
      } else {
        controller.error();
        Future.delayed(const Duration(seconds: 3), controller.reset);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                  SaveButton(controller: controller, onSave: () => _save(ref, context)),
                ],
              ),
              const SkillSelectionField(),
              const BoolField(name: "isEasyReachable", label: "Direkt Freischaltbar?", initialValue: false),
              const ValueRangeField(name: "cost", label: "Benötigte Skillpunkte", initialValue: 0, min: 0, max: 10, step: 1),
              const ValueRangeField(name: "importance", label: "Benötigte Skillpunkte", initialValue: 0, min: 0, max: 10, step: 1),
              FormBuilderColorPickerField(
                name: "color",
                valueTransformer: (value) => value?.value.toString(),
                initialValue: Colors.purple,
                validator: FormBuilderValidators.required(),
                decoration: const InputDecoration(labelText: "wähle eine Hintergrundfarbe:"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
