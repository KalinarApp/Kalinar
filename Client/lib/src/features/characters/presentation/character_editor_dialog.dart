// ignore_for_file: use_build_context_synchronously

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:kalinar/src/utils/hooks/rounded_loading_button_controller_hook.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../utils/http/async_value_extension.dart';
import '../application/controllers/character_controller.dart';
import '../domain/character.dart';
import 'character_detail_screen.dart';
import 'character_editor.dart';

Future showCharacterEditorDialog(BuildContext context, {Character? character}) async {
  showDialog(
    context: context,
    builder: (ctx) => Dialog(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * .95,
        width: max(550, MediaQuery.of(context).size.width * .6),
        child: CharacterEditorDialog(character: character),
      ),
    ),
  );
}

class CharacterEditorDialog extends HookConsumerWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  final Character? character;

  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  CharacterEditorDialog({this.character, super.key});

  Future<void> _save(BuildContext context, WidgetRef ref) async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final data = _formKey.currentState?.value;
      final controller = ref.read(characterControllerProvider);
      if (null != data) {
        final value = null == character ? await controller.create(data) : await controller.update(character!.id, data);
        if (!context.mounted) return;
        value.showNotification(context);
        if (value.hasError) {
          _btnController.error();
        } else {
          _btnController.success();

          ref.read(characterControllerProvider).get(value.value!);
          context.pop();
          context.goNamed(CharacterDetailScreen.name, pathParameters: {"id": value.value!});
        }
      } else {
        _btnController.error();
      }
    } else {
      _btnController.error();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = useRoundedLoadingButtonController();
    return FormBuilder(key: _formKey, child: CharacterEditor(character, onSave: () => _save(context, ref), buttonController: controller));
  }
}
