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
      child: Icon(Icons.person_4, size: (radius ?? 20) * 2, color: context.theme.dialogBackgroundColor),
    );
  }
}
