import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:hero/src/features/admin/presentation/screens/skills/skill_form.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../../common_widgets/save_button.dart';
import '../../controllers/create_skill_controller.dart';

class CreateSkillScreen extends ConsumerStatefulWidget {
  static const name = "CreateSkill";
  static const route = "create";

  const CreateSkillScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CreateSkillScreenState();
}

class _CreateSkillScreenState extends ConsumerState<CreateSkillScreen> {
  static final _formKey = GlobalKey<FormBuilderState>();

  late CreateSkillController controller;
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  void initState() {
    controller = ref.read(createSkillControllerProvider);
    super.initState();
  }

  Future<void> _save() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final data = _formKey.currentState?.value;
      if (null != data) {
        controller.createSkill(data).then((value) {
          if (null == value) {
            _btnController.error();
          } else {
            _btnController.success();
            GoRouter.of(context).pop();
          }
        });
      }
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
            child: Row(
              children: [
                const SizedBox(width: 52),
                Flexible(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 100,
                        child: Column(
                          children: [
                            FormBuilderTextField(
                              name: "name",
                              maxLines: 2,
                              maxLength: 100,
                              onChanged: (value) => _btnController.reset(),
                              validator: FormBuilderValidators.required(),
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(labelText: "Name", contentPadding: EdgeInsets.only(right: 8)),
                              style: Theme.of(context).textTheme.headline5,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SkillForm(_formKey),
      ),
    );
  }
}
