import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hero/src/features/admin/presentation/skills/components/name_field.dart';
import 'package:hero/src/features/admin/presentation/skills/skill_controller.dart';
import 'package:hero/src/features/admin/presentation/skills/components/skill_form.dart';
import 'package:hero/src/features/admin/presentation/skills/skill_list_controller.dart';
import 'package:hero/src/utilities/async_value_extension.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../common_widgets/save_button.dart';
import '../../domain/skill.dart';

class EditSkillScreen extends ConsumerStatefulWidget {
  static const name = "EditSkill";
  static const route = "edit";

  final String skillId;

  const EditSkillScreen(this.skillId, {super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _EditSkillScreenState();
}

class _EditSkillScreenState extends ConsumerState<EditSkillScreen> {
  static final _formKey = GlobalKey<FormBuilderState>();
  late final Skill item;

  late SkillController controller;
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  void initState() {
    controller = ref.read(skillControllerProvider);
    item = ref.read(skillListControllerProvider).value!.firstWhere((element) => element.id == widget.skillId);
    super.initState();
  }

  Future<void> _save() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final data = _formKey.currentState?.value;
      if (null != data) {
        controller.update(item.id, data).then((value) {
          if (!mounted) return;
          value.showSnackbarOnError(context);
          if (value.hasError) {
            _btnController.error();
          } else {
            _btnController.success();
            GoRouter.of(context).pop();
          }
        });
      } else {
        _btnController.error();
      }
    } else {
      _btnController.error();
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
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(110),
            child: NameField(initialValue: item.name, readOnly: false, reset: () => _btnController.reset()),
          ),
        ),
        body: SkillForm(_formKey, item: item, reset: () => _btnController.reset()),
      ),
    );
  }
}
