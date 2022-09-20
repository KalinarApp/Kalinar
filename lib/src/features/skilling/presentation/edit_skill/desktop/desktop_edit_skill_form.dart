import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:hero/src/features/skilling/presentation/edit_ability/edit_ability_screen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class DesktopEditSkillForm extends StatelessWidget {
  final GlobalKey<FormBuilderState> _formKey;

  const DesktopEditSkillForm(this._formKey, {super.key});

  // Future<void> _showAbilityEditModal(BuildContext context) async {
  //   String? result = await showModalBottomSheet<String>(context: context, isScrollControlled: true, builder: (_) => const EditAbilityScreen());

  //   if (null != result) {
  //     _formKey.currentState?.fields["ability"]?.didChange(result);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
