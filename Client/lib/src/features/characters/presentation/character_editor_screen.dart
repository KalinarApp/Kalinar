import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../common_widgets/layout/responsive_layout.dart';
import '../../../utilities/async_value_extension.dart';
import '../application/controllers/character_controller.dart';
import '../domain/character.dart';
import 'character_detail_screen.dart';
import 'desktop/character_editor.dart' as desktop;
import 'mobile/character_editor.dart' as mobile;

class CharacterEditorScreen extends ConsumerStatefulWidget {
  static const name = "CharacterEditor";
  static const route = "editor";

  final String? characterId;

  const CharacterEditorScreen(this.characterId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CharacterEditorScreenState();
}

class _CharacterEditorScreenState extends ConsumerState<CharacterEditorScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  late final Character? item = null;

  late CharacterController controller;
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  void initState() {
    controller = ref.read(characterControllerProvider);
    super.initState();
  }

  Future<void> _save() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final data = _formKey.currentState?.value;
      if (null != data) {
        final value = null == widget.characterId ? await controller.create(data) : await controller.update(widget.characterId!, data);
        if (!mounted) return;
        value.showSnackbarOnError(context);
        if (value.hasError) {
          _btnController.error();
          Future.delayed(const Duration(seconds: 3), _btnController.reset);
        } else {
          _btnController.success();

          ref.read(characterControllerProvider).get(value.value!);
          context.goNamed(CharacterDetailScreen.name, pathParameters: {"id": value.value!});
        }
      } else {
        _btnController.error();
        Future.delayed(const Duration(seconds: 3), _btnController.reset);
      }
    } else {
      _btnController.error();
      Future.delayed(const Duration(seconds: 3), _btnController.reset);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: ResponsiveLayout(
        mobile: mobile.CharacterEditor(item, onSave: _save, buttonController: _btnController),
        desktop: desktop.CharacterEditor(item, onSave: _save, buttonController: _btnController),
      ),
    );
  }
}
