import 'package:flutter/material.dart';

import '../../../../utils/build_context_extensions.dart';

class DefaultUserAvatar extends StatelessWidget {
  final double? radius;

  const DefaultUserAvatar({super.key, this.radius});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: radius,
      backgroundColor: context.colorScheme.onSurfaceVariant,
      child: LayoutBuilder(
        builder: (context, constraints) => Icon(Icons.person_4, size: constraints.maxHeight, color: context.theme.dialogBackgroundColor),
      ),
    );
  }
}
