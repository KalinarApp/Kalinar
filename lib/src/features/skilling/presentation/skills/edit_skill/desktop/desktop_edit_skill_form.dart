import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

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
