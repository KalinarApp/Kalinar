import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hero/src/common_widgets/save_button.dart';
import 'package:hero/src/features/authentication/presentation/groups/create_group_controller.dart';
import 'package:hero/src/utilities/async_value_extension.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../domain/group.dart';

class CreateGroupScreen extends ConsumerWidget {
  static const routeName = "groups/create";
  static final _formKey = GlobalKey<FormBuilderState>();

  CreateGroupScreen({Key? key}) : super(key: key);

  Future<void> _save(WidgetRef ref) async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final data = _formKey.currentState?.value;
      if (null != data) {
        ref.read(createGroupControllerProvider.notifier).save(data);
      }
    }
  }

  // void _setError(error, stackTrace) {
  //   _btnController.error();
  // }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(createGroupControllerProvider);
    final controller = ref.read(createGroupControllerProvider.notifier);

    state.whenData((value) {
      if (null != value) Navigator.pop(context);
    });

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
                  SaveButton(controller: controller.buttonController, onSave: () => _save(ref)),
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
