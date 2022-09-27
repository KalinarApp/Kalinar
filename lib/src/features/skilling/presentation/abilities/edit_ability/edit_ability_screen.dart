import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../../../common_widgets/save_button.dart';
import 'ability_form.dart';

class EditAbilityScreen extends StatefulWidget {
  static const routeName = "ability/edit";

  const EditAbilityScreen({super.key});

  @override
  State<EditAbilityScreen> createState() => _EditAbilityScreenState();
}

class _EditAbilityScreenState extends State<EditAbilityScreen> {
  static final _formKey = GlobalKey<FormBuilderState>();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * .95,
      width: MediaQuery.of(context).size.width * .4,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            SaveButton(controller: _btnController, onSave: () => Navigator.pop(context, "New Ability")),
          ],
        ),
        body: FormBuilder(
            key: _formKey,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: AbilityForm(),
            )),
      ),
    );
  }
}
