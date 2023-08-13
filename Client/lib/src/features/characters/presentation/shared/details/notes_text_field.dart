// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../utils/async_value_extension.dart';
import '../../../application/controllers/character_controller.dart';
import '../../../domain/character.dart';
import 'auto_saving_text_field.dart';

class NotesTextField extends HookConsumerWidget {
  final Character character;

  const NotesTextField(this.character, {super.key});

  bool _isOwner() {
    return FirebaseAuth.instance.currentUser?.uid == character.userId;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoSavingTextField(
      title: AppLocalizations.of(context)!.characterNotes,
      initialValue: character.notes,
      minLines: null,
      maxLines: null,
      expands: true,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      enabled: _isOwner(),
      onSaving: (currentText) async {
        final state = await ref.read(characterControllerProvider).update(character.id, {"notes": currentText});
        if (!context.mounted) return;
        state.showSnackbarOnError(context);
      },
    );
  }
}
