import 'dart:math';

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
    return Container(
      width: min(500, MediaQuery.of(context).size.width * 0.8),
      height: min(600, MediaQuery.of(context).size.height * 0.8),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Theme.of(context).dialogBackgroundColor),
      child: FormBuilder(
        key: _formKey,
        clearValueOnUnregister: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 60),
          child: Column(
            children: [
              const SizedBox(height: 50),
              Text("Benutzer anlegen", style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 50),
              CircleAvatar(
                radius: 60,
                backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
                child: Icon(Icons.person_4, size: 80, color: Theme.of(context).dialogBackgroundColor),
              ),
              const SizedBox(height: 50),
              FormBuilderTextField(name: 'username', decoration: InputDecoration(labelText: AppLocalizations.of(context)!.username)),
              const SizedBox(height: 50),
              ElevatedButton(onPressed: state.isLoading ? null : () {}, child: Text(AppLocalizations.of(context)!.save)),
            ],
          ),
        ),
      ),
    );
  }
}
