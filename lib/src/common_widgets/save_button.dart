import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

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
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Text("Save"),
      ),
    );
  }
}
