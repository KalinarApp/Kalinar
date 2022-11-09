import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SaveButton extends StatelessWidget {
  final RoundedLoadingButtonController controller;
  final Function() onSave;

  const SaveButton({required this.controller, required this.onSave, super.key});

  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      width: 100,
      height: 30,
      controller: controller,
      onPressed: onSave,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(AppLocalizations.of(context)!.save),
      ),
    );
  }
}
