import 'dart:math';

import 'package:flutter/material.dart';

class SkillIcon extends StatelessWidget {
  final String iconUrl;

  const SkillIcon(this.iconUrl, {super.key});

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -pi / 4,
      child: SizedBox(
        width: 128,
        height: 128,
        child: Card(
          elevation: 12,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Transform.rotate(angle: pi / 4, child: Image.network(iconUrl)),
          ),
        ),
      ),
    );
  }
}
