import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'edit_user_dialog_controller.dart';

class EditUserDialog extends ConsumerStatefulWidget {
  const EditUserDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends ConsumerState<EditUserDialog> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(editUserDialogControllerProvider);
    return FormBuilder(
      key: _formKey,
      clearValueOnUnregister: true,
      child: Column(
        children: [
          const CircleAvatar(radius: 60, child: Icon(Icons.camera)),
          FormBuilderTextField(name: 'username'),
          const SizedBox(height: 50),
          ElevatedButton(onPressed: state.isLoading ? null : () {}, child: Text(AppLocalizations.of(context)!.save)),
        ],
      ),
    );
  }
}
