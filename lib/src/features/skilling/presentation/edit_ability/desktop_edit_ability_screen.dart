import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:hero/src/common_widgets/save_button.dart';
import 'package:hero/src/features/skilling/presentation/edit_ability/ability_form.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class DesktopEditAbilityScreen extends StatefulWidget {
  const DesktopEditAbilityScreen({super.key});

  @override
  State<DesktopEditAbilityScreen> createState() => _DesktopEditAbilityScreenState();
}

class _DesktopEditAbilityScreenState extends State<DesktopEditAbilityScreen> {
  static final _formKey = GlobalKey<FormBuilderState>();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * .4,
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
