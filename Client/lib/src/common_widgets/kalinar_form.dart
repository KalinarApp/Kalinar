import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'elevated_loading_button.dart';

class KalinarForm extends ConsumerStatefulWidget {
  final List<Widget> formFields;
  final bool isLoading;
  final bool willPopOnEdit;
  final FutureOr<bool> Function(Map<String, dynamic> data) submit;
  final FutureOr<void> Function()? onSuccess;

  const KalinarForm({super.key, required this.formFields, required this.isLoading, required this.submit, this.onSuccess, this.willPopOnEdit = true});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _KalinarFormState();
}

class _KalinarFormState extends ConsumerState<KalinarForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  bool _validateAndSaveForm() {
    final form = _formKey.currentState!;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  Future<void> _submit() async {
    if (_validateAndSaveForm()) {
      final success = await widget.submit(_formKey.currentState!.value);
      if (success && mounted) {
        widget.onSuccess?.call();
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      onWillPop: () async {
        if (widget.willPopOnEdit) return true;

        return !(_formKey.currentState?.isDirty ?? false);
      },
      clearValueOnUnregister: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(children: [
        ...widget.formFields,
        const SizedBox(height: 50),
        ElevatedLoadingButton(
          isLoading: widget.isLoading,
          height: 50,
          action: _submit,
          child: Text(AppLocalizations.of(context)!.save, style: Theme.of(context).textTheme.titleLarge),
        )
      ]),
    );
  }
}
