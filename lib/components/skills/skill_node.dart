import 'package:flutter/material.dart';

import '../../models/skilltree/skill_tree.dart';

class SkillNode extends StatelessWidget {
  final Skill skill;

  const SkillNode(this.skill, {super.key});

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
        turns: const AlwaysStoppedAnimation(45 / 360),
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(color: skill.color),
          child: Text(skill.label),
        ));
  }
}
