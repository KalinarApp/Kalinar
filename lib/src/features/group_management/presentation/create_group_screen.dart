import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import '../../../common_widgets/save_button.dart';

import '../application/group_controller.dart';

class CreateGroupScreen extends ConsumerStatefulWidget {
  const CreateGroupScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends ConsumerState<CreateGroupScreen> {
  static final _formKey = GlobalKey<FormBuilderState>();

  final _btnController = RoundedLoadingButtonController();

  late final GroupController controller;

  @override
  void initState() {
    controller = ref.read(groupControllerProvider);
    super.initState();
  }

  Future<void> _save(WidgetRef ref, BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final data = _formKey.currentState?.value;
      if (null != data) {
        ref.read(groupControllerProvider).save(data);
        Navigator.pop(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 200),
      color: Theme.of(context).dialogBackgroundColor,
      child: Padding(
        padding: EdgeInsets.only(left: 12, right: 12, bottom: MediaQuery.of(context).viewInsets.bottom + 25),
        child: FormBuilder(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppBar(
                elevation: 0,
                automaticallyImplyLeading: false,
                actions: [
                  SaveButton(controller: _btnController, onSave: () => _save(ref, context)),
                ],
              ),
              FormBuilderTextField(
                name: "name",
                autovalidateMode: AutovalidateMode.onUserInteraction,
                onChanged: (_) => _btnController.reset(),
                decoration: const InputDecoration(labelText: "Gruppenname"),
              ),
              FormBuilderTextField(
                name: "description",
                minLines: 2,
                maxLines: 5,
                onChanged: (_) => _btnController.reset(),
                decoration: const InputDecoration(labelText: "Beschreibung"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
