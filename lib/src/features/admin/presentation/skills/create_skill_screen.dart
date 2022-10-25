import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hero/src/features/admin/presentation/skills/components/skill_form.dart';
import 'package:hero/src/utilities/async_value_extension.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../common_widgets/form_fields/name_field.dart';
import '../../../../common_widgets/save_button.dart';
import '../../application/skill_controller.dart';

class CreateSkillScreen extends ConsumerStatefulWidget {
  static const name = "CreateSkill";
  static const route = "create";

  const CreateSkillScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateSkillScreenState();
}

class _CreateSkillScreenState extends ConsumerState<CreateSkillScreen> {
  static final _formKey = GlobalKey<FormBuilderState>();

  late SkillController controller;
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  void initState() {
    controller = ref.read(skillControllerProvider);
    super.initState();
  }

  Future<void> _save() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final data = _formKey.currentState?.value;
      if (null != data) {
        controller.create(data).then((value) {
          if (!mounted) return;
          value.showSnackbarOnError(context);
          if (value.hasError) {
            _btnController.error();
            Future.delayed(const Duration(seconds: 3), _btnController.reset);
          } else {
            _btnController.success();
            GoRouter.of(context).pop();
          }
        });
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
      child: Scaffold(
        appBar: AppBar(
          actions: [
            SaveButton(controller: _btnController, onSave: _save),
          ],
          bottom: const PreferredSize(preferredSize: Size.fromHeight(110), child: NameField()),
        ),
        body: SkillForm(_formKey),
      ),
    );
  }
}
