import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common_widgets/save_button.dart';

import 'create_group_controller.dart';

class CreateGroupScreen extends ConsumerWidget {
  static const routeName = "groups/create";
  static final _formKey = GlobalKey<FormBuilderState>();

  CreateGroupScreen({Key? key}) : super(key: key);

  Future<void> _save(WidgetRef ref, BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final data = _formKey.currentState?.value;
      if (null != data) {
        ref.read(createGroupControllerProvider.notifier).save(data);
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.read(createGroupControllerProvider.notifier);

    return Container(
      constraints: const BoxConstraints(minHeight: 200),
      color: Theme.of(context).dialogBackgroundColor,
      child: Padding(
        padding: EdgeInsets.only(left: 12, right: 12, bottom: MediaQuery.of(context).viewInsets.bottom),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                actions: [
                  SaveButton(controller: controller.buttonController, onSave: () => _save(ref, context)),
                ],
              ),
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
