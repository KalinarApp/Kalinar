import 'package:flutter/material.dart';

class InformationRow extends StatelessWidget {
  final String title;
  final String? value;

  const InformationRow({required this.title, this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [Text("$title:", style: Theme.of(context).textTheme.bodyLarge), const SizedBox(width: 5), Text(value ?? "-")],
    );
  }
}
