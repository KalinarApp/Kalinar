import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/features/admin/presentation/skilltree/components/skill_selection_field.dart';
import 'package:hero/src/features/admin/presentation/skilltree/skilltree_controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../common_widgets/save_button.dart';

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
              SkillSelectionField(reset: () {}, initialValue: null),
              FormBuilderTextField(
                name: "name",
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (_) => controller.reset(),
                decoration: const InputDecoration(labelText: "Gruppenname"),
              ),
              FormBuilderTextField(
                name: "description",
                minLines: 2,
                maxLines: 5,
                onChanged: (_) => controller.reset(),
                decoration: const InputDecoration(labelText: "Beschreibung"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
