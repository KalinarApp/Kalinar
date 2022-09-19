import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hero/src/common_widgets/save_button.dart';
import 'package:hero/src/features/skilling/presentation/edit_ability/ability_form.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class EditAbilityScreen extends StatefulWidget {
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
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          automaticallyImplyLeading: false,
          leading: IconButton(
            icon: const Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
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
