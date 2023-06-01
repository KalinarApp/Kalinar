import 'package:flutter/material.dart';

class InformationRow extends StatelessWidget {
  final String title;
  final String? value;

  const InformationRow({required this.title, this.value, super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          WidgetSpan(
            child: Text(
              "$title: ",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(color: Theme.of(context).colorScheme.primary),
            ),
          ),
          WidgetSpan(child: SelectableText(value ?? "-", style: Theme.of(context).textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
