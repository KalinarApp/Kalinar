import 'package:flutter/material.dart';

class DefaultUserAvatar extends StatelessWidget {
  final double? radius;

  const DefaultUserAvatar({super.key, this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: Theme.of(context).colorScheme.onSurfaceVariant,
      child: LayoutBuilder(
        builder: (context, constraints) => Icon(Icons.person_4, size: constraints.maxHeight, color: Theme.of(context).dialogBackgroundColor),
      ),
    );
  }
}
