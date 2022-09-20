import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'mobile_edit_skill_form.dart';
import '../../../../../common_widgets/save_button.dart';

class MobileEditSkillScreen extends StatefulWidget {
  const MobileEditSkillScreen({super.key});

  @override
  State<MobileEditSkillScreen> createState() => _MobileEditSkillScreenState();
}

class _MobileEditSkillScreenState extends State<MobileEditSkillScreen> {
  static final _formKey = GlobalKey<FormBuilderState>();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            SaveButton(controller: _btnController, onSave: () => Navigator.pop(context)),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(100),
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
                              onChanged: (value) => _btnController.reset(),
                              validator: FormBuilderValidators.required(),
                              textInputAction: TextInputAction.next,
                              decoration: const InputDecoration(hintText: "Name"),
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
        body: MobileEditSkillForm(_formKey),
      ),
    );
  }
}
