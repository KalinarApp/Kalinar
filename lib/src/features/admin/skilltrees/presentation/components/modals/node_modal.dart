import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:uuid/uuid.dart';

import '../../../../../../common_widgets/form_fields/bool_field.dart';
import '../../../../../../common_widgets/form_fields/invisible_field.dart';
import '../../../../../../common_widgets/form_fields/value_range_field.dart';
import '../../../../../../common_widgets/save_button.dart';
import '../../../application/skilltree_controller.dart';
import '../../../domain/node.dart';
import '../builder/skill_selection_field.dart';

class NodeModal extends ConsumerWidget {
  final Node? item;
  static final _formKey = GlobalKey<FormBuilderState>();

  final RoundedLoadingButtonController controller = RoundedLoadingButtonController();

  NodeModal({this.item, Key? key}) : super(key: key);

  Future<void> _save(WidgetRef ref, BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final data = _formKey.currentState?.value;
      if (null != data) {
        try {
          ref.read(skilltreeControllerProvider.notifier).addNode(data);
          Navigator.of(context).pop();
        } catch (error) {
          controller.error();
          Future.delayed(const Duration(seconds: 3), controller.reset);
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
              InvisibleField(name: "id", initialValue: item?.id ?? const Uuid().v4()),
              InvisibleField(name: "xpos", initialValue: item?.xPos ?? 0),
              InvisibleField(name: "ypos", initialValue: item?.yPos ?? 0),
              SkillSelectionField(initialValue: item?.skill),
              BoolField(name: "isEasyReachable", label: "Direkt Freischaltbar?", initialValue: item?.isEasyReachable ?? false),
              ValueRangeField(name: "cost", label: "Benötigte Skillpunkte", initialValue: item?.cost ?? 0, min: 0, max: 10, step: 1),
              ValueRangeField(name: "importance", label: "Benötigte Skillpunkte", initialValue: item?.importance ?? 0, min: 0, max: 10, step: 1),
              FormBuilderColorPickerField(
                name: "color",
                valueTransformer: (value) => value?.value.toString(),
                initialValue: null != item?.color ? Color(int.parse(item!.color)) : Colors.white,
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
