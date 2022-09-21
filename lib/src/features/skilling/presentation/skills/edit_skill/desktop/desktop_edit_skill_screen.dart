import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hero/src/common_widgets/save_button.dart';
import 'package:hero/src/features/skilling/presentation/skills/edit_skill/desktop/form/skill_ability_selection_component.dart';
import 'package:hero/src/features/skilling/presentation/skills/edit_skill/desktop/form/skill_description_component.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import '../../../abilities/edit_ability/edit_ability_screen.dart';
import 'desktop_edit_skill_form.dart';

class DesktopEditSkillScreen extends StatefulWidget {
  const DesktopEditSkillScreen({super.key});

  @override
  State<DesktopEditSkillScreen> createState() => _DesktopEditSkillScreenState();
}

class _DesktopEditSkillScreenState extends State<DesktopEditSkillScreen> {
  static final _formKey = GlobalKey<FormBuilderState>();
  final RoundedLoadingButtonController _btnController = RoundedLoadingButtonController();

  Future<void> _showAbilityEditModal() async {
    // String? result = await showModalBottomSheet<String>(
    //   context: context,
    //   isScrollControlled: true,
    //   constraints: BoxConstraints(maxWidth: Platform.isAndroid || Platform.isIOS ? double.infinity : MediaQuery.of(context).size.width * .4),
    //   builder: (_) => const EditAbilityScreen(),
    // );
    Scaffold.of(context).openDrawer();
    // if (!mounted) return;
    // if (null != result) {
    //   _formKey.currentState?.fields["ability"]?.didChange(result);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: Scaffold(
        drawer: const EditAbilityScreen(),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          actions: [SaveButton(controller: _btnController, onSave: () => Navigator.pop(context))],
        ),
        body: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 4,
              child: Material(
                elevation: 10,
                color: Theme.of(context).colorScheme.surface,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SkillDescriptionComponent(_formKey, _btnController),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: SkillAbilitySelectionComponent(_formKey),
              ),
            )
          ],
        ),
      ),
    );
  }
}
